#![no_std]
#![no_main]

use core::panic::PanicInfo;

/// Minimal entry point for M68K
#[no_mangle]
pub extern "C" fn _start() -> ! {
    unsafe {
        core::arch::asm!("nop");
    }
    loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
