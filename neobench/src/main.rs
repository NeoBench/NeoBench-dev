#![no_std]
#![no_main]

extern crate boot;
extern crate kernel;
extern crate gui;

use core::panic::PanicInfo;

#[no_mangle]
pub extern "C" fn _start() -> ! {
    boot::_start_boot();       // Call boot module
    kernel::_start_kernel();   // Init the kernel
    gui::_start_gui();         // Launch desktop

    loop {} // fallback
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
