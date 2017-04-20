#include "ece391support.h"
#include "ece391syscall.h"
#include "modex.h"
#include "maze.h"
#include "blocks.h"
#include "text.h"

/* a few constants */
#define PAN_BORDER      5  /* pan when border in maze squares reaches 5    */
#define MAX_LEVEL      10  /* maximum level number                         */


#define BACKQUOTE 96
#define UP 138
#define DOWN 162
#define RIGHT 163
#define LEFT 161

/* structure used to hold game information */
typedef struct {
    /* parameters varying by level   */
    int number;                  /* starts at 1...                   */
    int maze_x_dim, maze_y_dim;  /* min to max, in steps of 2        */
    int initial_fruit_count;     /* 1 to 6, in steps of 1/2          */
    int time_to_first_fruit;     /* 300 to 120, in steps of -30      */
    int time_between_fruits;     /* 300 to 60, in steps of -30       */
    int tick_usec;         /* 20000 to 5000, in steps of -1750 */

    /* dynamic values within a level -- you may want to add more... */
    unsigned int map_x, map_y;   /* current upper left display pixel */
    unsigned int fruit_count;
} game_info_t;

static game_info_t game_info;


static int picked_up_fruit = 0;

int quit_flag = 0;
int winner= 0;
volatile int next_dir;
int play_x, play_y, last_dir, dir;
int move_cnt = 0;
int fd;
unsigned long data;

/*
 * move_up
 *   DESCRIPTION: Move the player up one pixel (assumed to be a legal move)
 *   INPUTS: ypos -- pointer to player's y position (pixel) in the maze
 *   OUTPUTS: *ypos -- reduced by one from initial value
 *   RETURN VALUE: none
 *   SIDE EFFECTS: pans display by one pixel when appropriate
 */
static void
move_up (int* ypos)
{
    /*
     * Move player by one pixel and check whether display should be panned.
     * Panning is necessary when the player moves past the upper pan border
     * while the top pixels of the maze are not on-screen.
     */
    if (--(*ypos) < game_info.map_y + BLOCK_Y_DIM * PAN_BORDER &&
        game_info.map_y > SHOW_MIN) {
        /*
         * Shift the logical view upwards by one pixel and draw the
         * new line.
         */
        set_view_window (game_info.map_x, --game_info.map_y);
        (void)draw_horiz_line (0);
    }
}


/*
 * move_right
 *   DESCRIPTION: Move the player right one pixel (assumed to be a legal move)
 *   INPUTS: xpos -- pointer to player's x position (pixel) in the maze
 *   OUTPUTS: *xpos -- increased by one from initial value
 *   RETURN VALUE: none
 *   SIDE EFFECTS: pans display by one pixel when appropriate
 */
static void
move_right (int* xpos)
{
    /*
     * Move player by one pixel and check whether display should be panned.
     * Panning is necessary when the player moves past the right pan border
     * while the rightmost pixels of the maze are not on-screen.
     */
    if (++(*xpos) > game_info.map_x + SCROLL_X_DIM -
        BLOCK_X_DIM * (PAN_BORDER + 1) &&
        game_info.map_x + SCROLL_X_DIM <
        (2 * game_info.maze_x_dim + 1) * BLOCK_X_DIM - SHOW_MIN) {
        /*
         * Shift the logical view to the right by one pixel and draw the
         * new line.
         */
        set_view_window (++game_info.map_x, game_info.map_y);
        (void)draw_vert_line (SCROLL_X_DIM - 1);
    }
}


/*
 * move_down
 *   DESCRIPTION: Move the player right one pixel (assumed to be a legal move)
 *   INPUTS: ypos -- pointer to player's y position (pixel) in the maze
 *   OUTPUTS: *ypos -- increased by one from initial value
 *   RETURN VALUE: none
 *   SIDE EFFECTS: pans display by one pixel when appropriate
 */
static void
move_down (int* ypos)
{
    /*
     * Move player by one pixel and check whether display should be panned.
     * Panning is necessary when the player moves past the right pan border
     * while the bottom pixels of the maze are not on-screen.
     */
    if (++(*ypos) > game_info.map_y + SCROLL_Y_DIM -
        BLOCK_Y_DIM * (PAN_BORDER + 1) &&
        game_info.map_y + SCROLL_Y_DIM <
        (2 * game_info.maze_y_dim + 1) * BLOCK_Y_DIM - SHOW_MIN) {
        /*
         * Shift the logical view downwards by one pixel and draw the
         * new line.
         */
        set_view_window (game_info.map_x, ++game_info.map_y);
        (void)draw_horiz_line (SCROLL_Y_DIM - 1);
    }
}


/*
 * move_left
 *   DESCRIPTION: Move the player right one pixel (assumed to be a legal move)
 *   INPUTS: xpos -- pointer to player's x position (pixel) in the maze
 *   OUTPUTS: *xpos -- decreased by one from initial value
 *   RETURN VALUE: none
 *   SIDE EFFECTS: pans display by one pixel when appropriate
 */
static void
move_left (int* xpos)
{
    /*
     * Move player by one pixel and check whether display should be panned.
     * Panning is necessary when the player moves past the left pan border
     * while the leftmost pixels of the maze are not on-screen.
     */
    if (--(*xpos) < game_info.map_x + BLOCK_X_DIM * PAN_BORDER &&
        game_info.map_x > SHOW_MIN) {
        /*
         * Shift the logical view to the left by one pixel and draw the
         * new line.
         */
        set_view_window (--game_info.map_x, game_info.map_y);
        (void)draw_vert_line (0);
    }
}


/*
 * unveil_around_player
 *   DESCRIPTION: Show the maze squares in an area around the player.
 *                Consume any fruit under the player.  Check whether
 *                player has won the maze level.
 *   INPUTS: (play_x,play_y) -- player coordinates in pixels
 *   OUTPUTS: none
 *   RETURN VALUE: 1 if player wins the level by entering the square
 *                 0 if not
 *   SIDE EFFECTS: draws maze squares for newly visible maze blocks,
 *                 consumed fruit, and maze exit; consumes fruit and
 *                 updates displayed fruit counts
 */
static int
unveil_around_player (int play_x, int play_y)
{
    int x = play_x / BLOCK_X_DIM; /* player's maze lattice position */
    int y = play_y / BLOCK_Y_DIM;
    int i, j;   /* loop indices for unveiling maze squares */

    /* Check for fruit at the player's position. */
    if ((picked_up_fruit = check_for_fruit(x, y))) {
        // If any were picked up decrement fruit_count
        game_info.fruit_count -= 1;
    }

    /* Unveil spaces around the player. */
    for (i = -1; i < 2; i++)
        for (j = -1; j < 2; j++)
            unveil_space (x + i, y + j);
    unveil_space (x, y - 2);
    unveil_space (x + 2, y);
    unveil_space (x, y + 2);
    unveil_space (x - 2, y);

    /* Check whether the player has won the maze level. */
    return check_for_win (x, y);
}


/*
 * prepare_maze_level
 *   DESCRIPTION: Prepare for a maze of a given level.  Fills the game_info
 *          structure, creates a maze, and initializes the display.
 *   INPUTS: level -- level to be used for selecting parameter values
 *   OUTPUTS: none
 *   RETURN VALUE: 0 on success, -1 on failure
 *   SIDE EFFECTS: writes entire game_info structure; changes maze;
 *                 initializes display
 */
static int
prepare_maze_level (int level)
{
    int i; /* loop index for drawing display */

    /*
     * Record level in game_info; other calculations use offset from
     * level 1.
     */
    game_info.number = level--;

    /* Set per-level parameter values. */
    if ((game_info.maze_x_dim = MAZE_MIN_X_DIM + 2 * level) >
        MAZE_MAX_X_DIM)
        game_info.maze_x_dim = MAZE_MAX_X_DIM;
    if ((game_info.maze_y_dim = MAZE_MIN_Y_DIM + 2 * level) >
        MAZE_MAX_Y_DIM)
        game_info.maze_y_dim = MAZE_MAX_Y_DIM;
    if ((game_info.initial_fruit_count = 1 + level / 2) > 6)
        game_info.initial_fruit_count = 6;
    if ((game_info.time_to_first_fruit = 300 - 30 * level) < 120)
        game_info.time_to_first_fruit = 120;
    if ((game_info.time_between_fruits = 300 - 60 * level) < 60)
        game_info.time_between_fruits = 60;
    if ((game_info.tick_usec = 20000 - 1750 * level) < 5000)
        game_info.tick_usec = 5000;

    /* Initialize dynamic values. */
    game_info.map_x = game_info.map_y = SHOW_MIN;
    game_info.fruit_count = game_info.initial_fruit_count;

    /* Create a maze. */
    if (make_maze (game_info.maze_x_dim, game_info.maze_y_dim,
                   game_info.initial_fruit_count) != 0)
        return -1;

    /* Set logical view and draw initial screen. */
    set_view_window (game_info.map_x, game_info.map_y);
    for (i = 0; i < SCROLL_Y_DIM; i++)
        (void)draw_horiz_line (i);

    /* Return success. */
    return 0;
}

/* some stats about how often we take longer than a single timer tick */
static int goodcount = 0;
static int badcount = 0;
static int total = 0;

/*
 * rtc_thread
 *   DESCRIPTION: Thread that handles updating the screen
 *   INPUTS: none
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: none
 */
static void rtc_thread() {
    int ticks = 0;
    int level;
    int ret;
    int open[NUM_DIRS];
    int goto_next_level = 0;


    // Loop over levels until a level is lost or quit.
    for (level = 1; (level <= MAX_LEVEL) && (quit_flag == 0); level++)
    {
        update_wall_color();
        // Prepare for the level.  If we fail, just let the player win.
        if (prepare_maze_level (level) != 0)
            break;
        goto_next_level = 0;

        // Start the player at (1,1)
        play_x = BLOCK_X_DIM;
        play_y = BLOCK_Y_DIM;

        // move_cnt tracks moves remaining between maze squares.
        // When not moving, it should be 0.
        move_cnt = 0;

        // Initialize last direction moved to up
        last_dir = DIR_RIGHT;

        // Initialize the current direction of motion to stopped
        /* dir = DIR_STOP; */
        /* next_dir = DIR_STOP; */

        // Show maze around the player's original position
        (void)unveil_around_player (play_x, play_y);

        draw_full_block (play_x, play_y, BLOCK_X_DIM, BLOCK_Y_DIM, get_player_block(last_dir), get_player_mask(last_dir));
        show_screen();

        // get first Periodic Interrupt
        ret = read(fd, &data, sizeof(unsigned long));

        /* clock_t initial_time = clock(); */
        /* clock_t curr_time = clock(); */
        /* time_t last_sec = 0; */

        /* int drawn_fruit = 0; */
        /* time_t fruit_timer_start; */
        /* time_t fruit_timer_length = 3; */

        /* time_t glow_timer_length = 1; */
        /* time_t glow_timer_start = curr_sec; */

        while ((quit_flag == 0) && (goto_next_level == 0))
        {
            // Wait for Periodic Interrupt
            ret = read(fd, &data, sizeof(unsigned long));

            // Update tick to keep track of time.  If we missed some
            // interrupts we want to update the player multiple times so
            // that player velocity is smooth
            ticks = data >> 8;

            total += ticks;

            // If the system is completely overwhelmed we better slow down:
            if (ticks > 8) ticks = 8;

            if (ticks > 1) {
                badcount++;
            }
            else {
                goodcount++;
            }
            ticks = 1;

            while (ticks--) {

                // Check to see if a key has been pressed
                if (next_dir != dir)
                {
                    // Check if new direction is backwards...if so, do immediately
                    if ((dir == DIR_UP && next_dir == DIR_DOWN) ||
                        (dir == DIR_DOWN && next_dir == DIR_UP) ||
                        (dir == DIR_LEFT && next_dir == DIR_RIGHT) ||
                        (dir == DIR_RIGHT && next_dir == DIR_LEFT))
                    {
                        if (move_cnt > 0)
                        {
                            if (dir == DIR_UP || dir == DIR_DOWN)
                                move_cnt = BLOCK_Y_DIM - move_cnt;
                            else
                                move_cnt = BLOCK_X_DIM - move_cnt;
                        }
                        dir = next_dir;
                    }
                }
                // New Maze Square!
                if (move_cnt == 0)
                {
                    // The player has reached a new maze square; unveil nearby maze
                    // squares and check whether the player has won the level.
                    if (unveil_around_player (play_x, play_y))
                    {
                        goto_next_level = 1;
                        break;
                    }

                    // Record directions open to motion.
                    find_open_directions (play_x / BLOCK_X_DIM,
                                          play_y / BLOCK_Y_DIM,
                                          open);

                    // Change dir to next_dir if next_dir is open
                    if (open[next_dir])
                    {
                        dir = next_dir;
                    }

                    // The direction may not be open to motion...
                    //   1) ran into a wall
                    //   2) initial direction and its opposite both face walls
                    if (dir != DIR_STOP)
                    {
                        if (!open[dir])
                        {
                            dir = DIR_STOP;
                        }
                        else if (dir == DIR_UP || dir == DIR_DOWN)
                        {
                            move_cnt = BLOCK_Y_DIM;
                        }
                        else
                        {
                            move_cnt = BLOCK_X_DIM;
                        }
                    }
                }
                if (dir != DIR_STOP)
                {
                    // move in chosen direction
                    last_dir = dir;
                    move_cnt--;
                    switch (dir)
                    {
                    case DIR_UP:
                        move_up (&play_y);
                        break;
                    case DIR_RIGHT:
                        move_right (&play_x);
                        break;
                    case DIR_DOWN:
                        move_down (&play_y);
                        break;
                    case DIR_LEFT:
                        move_left (&play_x);
                        break;
                    }
                }
            }
            // Get the current time and increment curr_sec by the neccessary amount.
            /* last_sec = curr_sec; */
            /* curr_time = clock(); */
            /* curr_sec = (curr_time - initial_time) / CLOCKS_PER_SEC; */

            /* if (picked_up_fruit) { */
            /*     drawn_fruit = picked_up_fruit; */
            /*     fruit_timer_start = curr_sec; */
            /*     picked_up_fruit = 0; */
            /* } */

            /* if (curr_sec > glow_timer_start + glow_timer_length) { */
            /*     update_player_glow_color(); */
            /*     glow_timer_start += glow_timer_length; */
            /* } */


            // Draw the statusbar with the new time, current level, and remaining fruit count
            /* draw_statusbar(level, curr_sec, game_info.fruit_count); */
            /* show_statusbar(); */

            // We must draw the player before the fruit text in order for the text to appear above the player.
            draw_full_block (play_x, play_y, BLOCK_X_DIM, BLOCK_Y_DIM, get_player_block(last_dir), get_player_mask(last_dir));

            /* if (drawn_fruit) { */
            /*     if (curr_sec > fruit_timer_start + fruit_timer_length) { */
            /*         drawn_fruit = 0; */
            /*     } else { */
            /*         char *str; */
            /*         switch (drawn_fruit) { */
            /*         case 1: */
            /*             str = "an apple!"; */
            /*             break; */
            /*         case 2: */
            /*             str = "grapes!"; */
            /*             break; */
            /*         case 3: */
            /*             str = "a peach!"; */
            /*             break; */
            /*         case 4: */
            /*             str = "a strawberry!"; */
            /*             break; */
            /*         case 5: */
            /*             str = "a banana!"; */
            /*             break; */
            /*         case 6: */
            /*             str = "watermelon!"; */
            /*             break; */
            /*         case 7: */
            /*             str = "YEAH!  DEW!"; */
            /*             break; */
            /*         default: */
            /*             str = "What's that?"; */
            /*         }; */
            /*         draw_text_above_player(str, strlen(str), play_x, play_y); */
            /*     } */
            /* } */

            show_screen();
        }
    }
    if (quit_flag == 0) winner = 1;
    return;
}

/*
 * keyboard_thread
 *   DESCRIPTION: Thread that handles keyboard inputs
 *   INPUTS: none
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: none
 */
static void keyboard_thread()
{
    int kbd_fd = open("/dev/kbd");
    int16_t key;
    // Break only on win or quit input - '`'
    while (winner == 0 && quit_flag == 0)
    {
        // Get Keyboard Input
        read(kbd_fd, &key, 2);

        // Check for '`' to quit
        if (key == BACKQUOTE)
        {
            quit_flag = 1;
            break;
        }
        else
        {
            switch(key)
            {
            case UP:
                next_dir = DIR_UP;
                break;
            case DOWN:
                next_dir = DIR_DOWN;
                break;
            case RIGHT:
                next_dir = DIR_RIGHT;
                break;
            case LEFT:
                next_dir = DIR_LEFT;
                break;
            default:
                break;
            }
        }
    }

    return;
}

int main() {
    if (set_mode_X(fill_horiz_buffer, fill_vert_buffer) == -1) {
        return 1;
    }

    fd = open((uint8_t *)"rtc");
    int x = 64;
    write(fd, &x, 4);

    uint32_t tid;
    thread_create(&tid, rtc_thread);

    keyboard_thread();

    clear_mode_X();

    return 0;
}
