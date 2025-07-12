.section .vectors, "a"
.globl _start

    .long 0x00010000        # Initial SP
    .long _start            # Reset Vector

.text
_start:
    nop
    bra .
