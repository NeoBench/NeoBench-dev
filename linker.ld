ENTRY(reset_handler)

MEMORY {
    RAM : ORIGIN = 0x00000000, LENGTH = 512K
}

SECTIONS {
    .init : {
        KEEP(*(.init))
    } > RAM

    .text : {
        *(.text*)
    } > RAM

    .rodata : {
        *(.rodata*)
    } > RAM

    .data : {
        *(.data*)
    } > RAM

    .bss : {
        *(.bss*)
        *(COMMON)
    } > RAM
}
