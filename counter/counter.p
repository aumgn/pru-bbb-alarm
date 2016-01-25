.origin 0
.entrypoint start

#include <pruss_intc_mapping.h>

start:
    // 20000 * 5000 * 2 (instructions per step)
    // makes for around 1 second.
    MOV r1, #20000
    MOV r3, #5000

    MOV r10, 0b0011111101010000
    MOV r4, #0

display_digit:
    LSL r5, r4, #1
    LBCO r11, C24, r5, 16
    AND r30, r30, r10
    OR  r30, r30, r11

incr:
    ADD r4, r4, #1
    QBLE end, r4, #17

wait:
    MOV r0, #0
    MOV r2, #0
wait_loop:
    ADD r0, r0, #1
    QBLT wait_loop, r1, r0
    MOV r0, #0
    ADD r2, r2, #1
    QBLT wait_loop, r3, r2
    QBA display_digit

end:
    MOV r31.b0, PRU0_ARM_INTERRUPT+16
    HALT
