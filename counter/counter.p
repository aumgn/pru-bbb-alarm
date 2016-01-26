.origin 0
.entrypoint start

#include <pruss_intc_mapping.h>

// "200000000" => 200Mhz
// "/ 2" => 2 instructions per step
// "- 2" => 2 instructions per loop
// makes for around 1 second.
#define WAIT_LIMIT (200000000 / 2) - 2

#define DRAM_ADDR c24

#define out r30
#define reset_mask r0
#define counter r1
#define digit_addr r2
#define digit_mask r3
#define wait_count r10
#define wait_limit r11

start:
    MOV wait_limit.w0, WAIT_LIMIT & 0xFFFF
    MOV wait_limit.w2, WAIT_LIMIT >> 16

    MOV reset_mask, #0b0011111101010000
    MOV counter, #0

display_digit:
    LSL digit_addr, counter, #1
    LBCO digit_mask, DRAM_ADDR, digit_addr, #16
    AND out, out, reset_mask
    OR  out, out, digit_mask

incr:
    ADD counter, counter, #1
    QBLE end, counter, #17

wait:
    MOV wait_count, #0
wait_loop:
    ADD wait_count, wait_count, #1
    QBLT wait_loop, wait_limit, wait_count
    QBA display_digit

end:
    MOV r31.b0, PRU0_ARM_INTERRUPT+16
    HALT
