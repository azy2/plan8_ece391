#include "kbd.h"
#include "lib.h"
#include "i8259.h"
#include "schedule.h"
#include "task.h"

#define SET(s,r,c) case s: kbd_state.row = r; kbd_state.col = c; break

static bool e0_waiting = false;
static bool kbd_ready = false;
static bool caps_held = false;

static uint32_t write_index[NUM_TERM];
static uint32_t read_index[NUM_TERM];
static bool buffer_full[NUM_TERM];

static kbd_t kbd_buffer[NUM_TERM][KBD_BUFFER_SIZE];

// Current kbd state
kbd_t kbd_state;

uint8_t cur_kbd_layout = QWERTY;

int8_t ascii_lookup[NUM_KBD_LAYOUT][6][16] = {
    // QWERTY
    {{'\0', 0x1B, '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'},
     {'`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', 0x8, '\0', '\0'},
     {0x9, 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\\', 0x7F, '\0'},
     {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', '\'', '\n', '\0', '\0', '\0', '\0'},
     {'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/', '\0', '\0', '\0', '\0', '\0', '\0'},
     {' ', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'}},
    // DVORAK
    {{'\0', 0x1B, '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'},
     {'`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '[', ']', 0x8, '\0', '\0'},
     {0x9, '\'', ',', '.', 'p', 'y', 'f', 'g', 'c', 'r', 'l', '/', '=', '\\', 0x7F, '\0'},
     {'a', 'o', 'e', 'u', 'i', 'd', 'h', 't', 'n', 's', '-', '\n', '\0', '\0', '\0', '\0'},
     {';', 'q', 'j', 'k', 'x', 'b', 'm', 'w', 'v', 'z', '\0', '\0', '\0', '\0', '\0', '\0'},
     {' ', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'}}
};

int8_t ascii_shift_lookup[NUM_KBD_LAYOUT][6][16] = {
    // QWERTY
    {{'\0', 0x1B, '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'},
     {'~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '=', 0x8, '\0', '\0'},
     {0x9, 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '|', 0x7F, '\0'},
     {'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"', '\n', '\0', '\0', '\0', '\0'},
     {'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?', '\0', '\0', '\0', '\0', '\0', '\0'},
     {' ', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'}},
    // DVORAK
    {{'\0', 0x1B, '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'},
     {'~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '{', '}', 0x8, '\0', '\0'},
     {0x9, '\"', '<', '>', 'P', 'Y', 'F', 'G', 'C', 'R', 'L', '?', '+', '|', 0x7F, '\0'},
     {'A', 'O', 'E', 'U', 'I', 'D', 'H', 'T', 'N', 'S', '_', '\n', '\0', '\0', '\0', '\0'},
     {':', 'Q', 'J', 'K', 'X', 'B', 'M', 'W', 'V', 'Z', '\0', '\0', '\0', '\0', '\0', '\0'},
     {' ', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0', '\0'}}
};

/* void _kbd_do_irq(int dev_id)
 * Decription: Handler for keyboard interrupts
 * input: int dev_id - unused
 * output: none
 * Side effects: Writes to the keyboard buffer. Can trigger interrupt signal
 *               and switch terminals
 */
void _kbd_do_irq(int dev_id) {
    uint8_t c;
    c = inb(0x60);
    // 0xE0 scancode indicates another byte is on the way.
    // This is to extend the number of keys the keyboard can
    // use. If we see 0xE0 we return and wait for another interupt.
    if (c == 0xE0) {
        e0_waiting = true;
        return;
    }

    uint16_t scanCode = c;

    if (e0_waiting) {
        scanCode = (0xE0 << 8) | c;
    }

    switch (scanCode) {
        // Left/Right Control pressed
    case 0x001D:
    case 0xE01D:
        kbd_state.ctrl = 1;
        kbd_state.row = 0;
        kbd_state.col = 0;
        break;

        // Left/Right Control released
    case 0x009D:
    case 0xE09D:
        kbd_state.ctrl = 0;
        kbd_state.row = 0;
        kbd_state.col = 0;
        break;

        // Left/Right Alt pressed
    case 0x0038:
    case 0xE038:
        kbd_state.row = 0;
        kbd_state.col = 0;
        kbd_state.alt = 1;
        break;

        // Left/Right Alt released
    case 0x00B8:
    case 0xE0B8:
        kbd_state.row = 0;
        kbd_state.col = 0;
        kbd_state.alt = 0;
        break;

        // Left/Right Shift pressed
    case 0x02A:
    case 0x0036:
        kbd_state.row = 0;
        kbd_state.col = 0;
        kbd_state.shift = 1;
        break;

        // Left/Right Shift released
    case 0x00AA:
    case 0x00B6:
        kbd_state.row = 0;
        kbd_state.col = 0;
        kbd_state.shift = 0;
        break;

        // Left/Right GUI/Super pressed
    case 0xE05B:
    case 0xE05C:
        kbd_state.row = 0;
        kbd_state.col = 0;
        kbd_state.super = 1;
        break;

        // Left/Right GUI/Super released
    case 0xE0DC:
    case 0xE0DB:
        kbd_state.row = 0;
        kbd_state.col = 0;
        kbd_state.super = 0;
        break;

        // Capslock pressed
    case 0x003A:
        if (!caps_held) {
            kbd_state.capsLock ^= true;
        }
        caps_held = true;
        break;
        // Capslock released
    case 0x00BA: caps_held = false; break;

        // Defines cases for all keys other than the above
        // SET takes the scancode and a row,col pair and
        // creates a case statement for the scancode that
        // fills in the row,col fields of kbd_state.
        // This is intended to map to the physical locations
        // of each key on a "standard" keyboard
        SET(0x0001, 0, 1);   // ESC
        SET(0x003B, 0, 2);   // F1
        SET(0x003C, 0, 3);   // F2
        SET(0x003D, 0, 4);   // F3
        SET(0x003E, 0, 5);   // F4
        SET(0x003F, 0, 6);   // F5
        SET(0x0040, 0, 7);   // F6
        SET(0x0041, 0, 8);   // F7
        SET(0x0042, 0, 9);   // F8
        SET(0x0043, 0, 10);   // F9
        SET(0x0044, 0, 11);  // F10
        SET(0x0057, 0, 12);  // F11
        SET(0x0058, 0, 13);  // F12
        SET(0x0029, 1, 0);   // ` ~
        SET(0x0002, 1, 1);   // 1 !
        SET(0x0003, 1, 2);   // 2 @
        SET(0x0004, 1, 3);   // 3 #
        SET(0x0005, 1, 4);   // 4 $
        SET(0x0006, 1, 5);   // 5 %
        SET(0x0007, 1, 6);   // 6 ^
        SET(0x0008, 1, 7);   // 7 &
        SET(0x0009, 1, 8);   // 8 *
        SET(0x000A, 1, 9);   // 9 (
        SET(0x000B, 1, 10);  // 0 )
        SET(0x000C, 1, 11);  // - _
        SET(0x000D, 1, 12);  // = +
        SET(0x000E, 1, 13);  // BKSP
        SET(0xE052, 1, 14);  // INSERT
        SET(0xE047, 1, 15);  // HOME
        SET(0xE049, 1, 16);  // PGUP
        SET(0x000F, 2, 0);   // TAB
        SET(0x0010, 2, 1);   // Q
        SET(0x0011, 2, 2);   // W
        SET(0x0012, 2, 3);   // E
        SET(0x0013, 2, 4);   // R
        SET(0x0014, 2, 5);   // T
        SET(0x0015, 2, 6);   // Y
        SET(0x0016, 2, 7);   // U
        SET(0x0017, 2, 8);   // I
        SET(0x0018, 2, 9);   // O
        SET(0x0019, 2, 10);  // P
        SET(0x001A, 2, 11);  // [ {
        SET(0x001B, 2, 12);  // ] }
        SET(0x002B, 2, 13);  // \ |
        SET(0xE053, 2, 14);  // DEL
        SET(0xE04F, 2, 15);  // END
        SET(0xE051, 2, 16);  // PGDN
        SET(0x001E, 3, 0);   // A
        SET(0x001F, 3, 1);   // S
        SET(0x0020, 3, 2);   // D
        SET(0x0021, 3, 3);   // F
        SET(0x0022, 3, 4);   // G
        SET(0x0023, 3, 5);   // H
        SET(0x0024, 3, 6);   // J
        SET(0x0025, 3, 7);   // K
        SET(0x0026, 3, 8);   // L
        SET(0x0027, 3, 9);   // ; :
        SET(0x0028, 3, 10);  // ' "
        SET(0x001C, 3, 11);  // ENTER
        SET(0x002C, 4, 0);   // Z
        SET(0x002D, 4, 1);   // X
        SET(0x002E, 4, 2);   // C
        SET(0x002F, 4, 3);   // V
        SET(0x0030, 4, 4);   // B
        SET(0x0031, 4, 5);   // N
        SET(0x0032, 4, 6);   // M
        SET(0x0033, 4, 7);   // , <
        SET(0x0034, 4, 8);   // . >
        SET(0x0035, 4, 9);   // / ?
        SET(0xE048, 4, 10);  // UP
        SET(0x0039, 5, 0);   // SPACE
        SET(0xE04B, 5, 1);   // LEFT
        SET(0xE050, 5, 2);   // DOWN
        SET(0xE04D, 5, 3);   // RIGHT

        // If we don't recognize the key, clear kbd_state (no key is being pressed/one was just released)
    default:
        kbd_state.row = false;
        kbd_state.col = false;
        break;
    }

    tasks[term_process[active]]->status = TASK_RUNNING;
    interupt_preempt = true;

    int f;
    for (f = 0; f < NUM_TERM; f++) {
        if (kbd_equal(kbd_state, f + F1_KEY)) {
            update_screen(f);
            break;
        }
    }

    if (kbd_to_ascii(kbd_state) == 'c' && kbd_state.ctrl) {
        SET_SIGNAL(term_process[active], INTERRUPT);
    } else {
        // If buffer isn't full and a key is pressed
        if(!buffer_full[active] && kbd_state.state & 0xFF) {

            // Write key to buffer
            kbd_buffer[active][write_index[active]] = kbd_state;
            // Increment write_index
            write_index[active] = (write_index[active] + 1)%KBD_BUFFER_SIZE;

            // If buffer full, disable writing
            if (write_index[active] == read_index[active])
                buffer_full[active] = true;
        }
    }

    e0_waiting = false;
    //Ready to read if key is pressed
    kbd_ready = true;
}

/* void kbd_clear()
 * Decription: Clears the kbd buffer of the current program
 * input: none
 * output: none
 * Side effects: Writes to the kbd buffer
 */
void kbd_clear() {
    write_index[TASK_T] = 0;
    read_index[TASK_T] = 0;
    buffer_full[TASK_T] = false;
}

/* void kbd_init(irqaction* keyboard_handler)
 * Decription: Clears the kbd buffer of the current program
 * input: keyboard_handler - pointer to irqaction struct for the kbd
 * output: none
 * Side effects: Enables a PIC line, modifies the keyboard_handler, clears kbd buffers
 */
void kbd_init(irqaction* keyboard_handler) {
    keyboard_handler->handle = _kbd_do_irq;
    keyboard_handler->dev_id = 0x21;
    keyboard_handler->next = NULL;

    kbd_ops.open = kbd_open;
    kbd_ops.close = kbd_close;
    kbd_ops.read = kbd_read;
    kbd_ops.write = kbd_write;

    irq_desc[0x1] = keyboard_handler;
    enable_irq(1);

    int i;
    for (i = 0; i < NUM_TERM; i++) {
        write_index[i] = 0;
        read_index[i] = 0;
    }
}

/* int32_t kbd_open(const int8_t* filename)
 * Decription: Does nothing to open the keyboard
 * input: filename - unused
 * output: 0 for success
 * Side effects: none
 */
int32_t kbd_open(const int8_t* filename) {
    return 0;
}

/* int32_t kbd_close(int32_t fd)
 * Decription: Does nothing to close the keyboard
 * input: fd - unused
 * output: 0 for success
 * Side effects: none
 */
int32_t kbd_close(int32_t fd) {
    return 0;
}

/* int32_t kbd_write(int32_t fd, const void* buf, int32_t nbytes)
 * Decription: Fails to write to the keyboard
 * input: fd - ignored
 *        buf - ignored
 *        nbytes - ignored
 * output: -1 for failure
 * Side effects: none
 */
int32_t kbd_write(int32_t fd, const void* buf, int32_t nbytes) {
    return -1;
}

/* int32_t kbd_read(int32_t fd, void* buf, int32_t nbytes)
 * Decription: Reads from the keyboard
 * input: fd - ignored
 *        buf - buffer to write kbd_t structs
 *        nbytes - double the number of keys desired
 * output: number of bytes written on success, -1 for invalid input
 * Side effects: sleeps for keys
 */
int32_t kbd_read(int32_t fd, void* buf, int32_t nbytes) {
    kbd_clear();
    if(nbytes & 1){ //fail on odd number requested
        return -1;
    }
    nbytes = (uint32_t)nbytes > sizeof(kbd_t)*KBD_BUFFER_SIZE ? sizeof(kbd_t)*KBD_BUFFER_SIZE : nbytes;
    int32_t i = 0;
    while(i < nbytes){
        if(read_index[TASK_T] != write_index[TASK_T] || buffer_full[TASK_T] == true){
            //read a key from the buffer
            *((kbd_t*)buf) = kbd_buffer[TASK_T][read_index[TASK_T]];
            read_index[TASK_T] = (read_index[TASK_T] + 1)%KBD_BUFFER_SIZE;
            i += sizeof(kbd_t);
            buffer_full[TASK_T] = false;
        } else {
            //Nothing to read, ask to be woken up and reschedule
            term_process[TASK_T] = cur_task;
            reschedule();
        }
    }
    return i;
}

/* int8_t kbd_to_ascii(kbd_t key)
 * Decription: Converts kbd_t to an ascii char
 * input: key - kbd_t to be translated
 * output: key in ascii
 * Side effects: none
 */
int8_t kbd_to_ascii(kbd_t key) {
    int8_t out;
    if (!key.shift) {
        out = ascii_lookup[cur_kbd_layout][key.row][key.col];
    } else {
        out = ascii_shift_lookup[cur_kbd_layout][key.row][key.col];
    }

    if (key.capsLock) {
        if (out >= 'A' && out <= 'Z') {
            out -= 'A'-'a';
        } else if (out >= 'a' && out <= 'z') {
            out -= 'a'-'A';
        } else {}
    }


    return out;
}

/* void _kbd_print_ascii(kbd_t key)
 * Decription: Prints a kbd_t to the screen in ascii
 * input: key - kbd_t to be printed
 * output: none
 * Side effects: writes to video memory
 */
void _kbd_print_ascii(kbd_t key) {
    int8_t k = kbd_to_ascii(key);
    if (k) {
        printf("%c", k);
    }
}
/* kbd_t kbd_poll()
 * Decription: Returns the current keyboard state
 * input: none
 * output: current key pressed
 * Side effects: none
 */
kbd_t kbd_poll() {
    return kbd_state;
}

/* kbd_t kbd_poll_echo()
 * Decription: Returns the current keyboard state and prints it to the screen
 * input: none
 * output: current key pressed
 * Side effects: writes to video memory
 */
kbd_t kbd_poll_echo() {
    kbd_t key = kbd_state;
    _kbd_print_ascii(key);
    return key;
}

/* kbd_t kbd_get_echo()
 * Decription: Waits for a key press then prints it to the screen
 * input: none
 * output: current key pressed
 * Side effects: writes to video memory
 */
kbd_t kbd_get_echo() {
    while (!kbd_ready) {asm volatile ("hlt");}
    kbd_ready = false;
    _kbd_print_ascii(kbd_state);
    return kbd_state;
}

/* kbd_t kbd_get()
 * Decription: Waits for a key press then returns it
 * input: none
 * output: current key pressed
 * Side effects: none
 */
kbd_t kbd_get() {
    while (!kbd_ready) {asm volatile ("hlt");}
    kbd_ready = false;
    return kbd_state;
}

/* bool kbd_equal(kbd_t key, uint8_t desired)
 * Decription:
 * input: key - kbd_t to compare
 *        desired - key to compare, in kbd_t format
 * output: 1 for equal, otherwise 0
 * Side effects: writes to video memory
 */
bool kbd_equal(kbd_t key, uint8_t desired) {
    return (key.state & 0xFF) == desired;
}
