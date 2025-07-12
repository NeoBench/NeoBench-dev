#![no_std]
#![no_main]
#![feature(asm_experimental_arch)]

use core::arch::asm;

#[link_section = ".init"]
#[no_mangle]
pub static VECTOR_TABLE: [u32; 2] = [
    0x00080000,             // Initial stack pointer (e.g., top of RAM)
    reset_handler as u32,   // Reset vector = address of entry point
];

#[no_mangle]
pub extern "C" fn reset_handler() -> ! {
    unsafe {
        asm!("nop");
    }
    loop {}
}
