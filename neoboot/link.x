ENTRY(_start)

MEMORY
{
    ROM : ORIGIN = 0xF80000, LENGTH = 0x080000  /* Amiga Kickstart range */
}

SECTIONS
{
    .text : {
        *(.vectors*)
        *(.text*)
        *(.rodata*)
    } > ROM

    .data : {
        *(.data*)
    } > ROM

    .bss : {
        *(.bss*)
        *(COMMON)
    } > ROM
}
