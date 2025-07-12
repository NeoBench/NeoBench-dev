#![no_std]
#![no_main]

extern crate panic_halt;

use core::fmt::Write;
use core::ptr::write_volatile;

#[link_section = ".text.start"]
#[no_mangle]
pub extern "C" fn _start() -> ! {
    let mut uart = SerialPort::new(0x00BFEC01);
    writeln!(uart, "NeoBench Boot ROM (c) 2025").ok();
    writeln!(uart, "CPU: 68060").ok();
    writeln!(uart, "MMU: Present").ok();
    writeln!(uart, "FPU: Present").ok();

    loop {
        unsafe { core::arch::asm!("nop") }
    }
}

struct SerialPort {
    addr: u32,
}

impl SerialPort {
    pub const fn new(addr: u32) -> Self {
        SerialPort { addr }
    }
}

impl Write for SerialPort {
    fn write_str(&mut self, s: &str) -> core::fmt::Result {
        for byte in s.bytes() {
            unsafe {
                write_volatile(self.addr as *mut u8, byte);
            }
        }
        Ok(())
    }
}
