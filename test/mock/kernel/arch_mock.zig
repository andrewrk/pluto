// Zig version: 0.4.0

const std = @import("std");
const Mock = @import("mock_framework.zig").Mock;
const warn = std.debug.warn;
const MemProfile = @import("mem_mock.zig").MemProfile;

pub const InterruptContext = struct {
    // Extra segments
    gs: u32,
    fs: u32,
    es: u32,
    ds: u32,

    // Destination, source, base pointer
    edi: u32,
    esi: u32,
    ebp: u32,
    esp: u32,

    // General registers
    ebx: u32,
    edx: u32,
    ecx: u32,
    eax: u32,

    // Interrupt number and error code
    int_num: u32,
    error_code: u32,

    // Instruction pointer, code segment and flags
    eip: u32,
    cs: u32,
    eflags: u32,
    user_esp: u32,
    ss: u32,
};

var mock: Mock() = undefined;

///
/// Initialise the architecture
///
pub fn init(mem_profile: *const MemProfile, allocator: *std.mem.Allocator) void {}

///
/// Inline assembly to write to a given port with a byte of data.
///
/// Arguments:
///     IN port: u16 - The port to write to.
///     IN data: u8  - The byte of data that will be sent.
///
pub fn outb(port: u16, data: u8) void {
    return mock.performAction("outb", void, port, data);
}

///
/// Inline assembly that reads data from a given port and returns its value.
///
/// Arguments:
///     IN port: u16 - The port to read data from.
///
/// Return:
///     The data that the port returns.
///
pub fn inb(port: u16) u8 {
    return mock.performAction("inb", u8, port);
}

///
/// A simple way of waiting for I/O event to happen by doing an I/O event to flush the I/O
/// event being waited.
///
pub fn ioWait() void {}

///
/// Register an interrupt handler. The interrupt number should be the arch-specific number.
///
/// Arguments:
///     IN int: u16 - The arch-specific interrupt number to register for.
///     IN handler: fn (ctx: *InterruptContext) void - The handler to assign to the interrupt.
///
pub fn registerInterruptHandler(int: u16, ctx: fn (ctx: *InterruptContext) void) void {}

///
/// Load the GDT and refreshing the code segment with the code segment offset of the kernel as we
/// are still in kernel land. Also loads the kernel data segment into all the other segment
/// registers.
///
/// Arguments:
///     IN gdt_ptr: *gdt.GdtPtr - The address to the GDT.
///
pub fn lgdt(gdt_ptr: *const gdt.GdtPtr) void {
    return mock.performAction("lgdt", void, gdt_ptr.*);
}

///
/// Load the TSS into the CPU.
///
pub fn ltr() void {}

/// Load the IDT into the CPU.
pub fn lidt(idt_ptr: *const idt.IdtPtr) void {
    return mock.performAction("lidt", void, idt_ptr.*);
}

///
/// Enable interrupts
///
pub fn enableInterrupts() void {}

///
/// Disable interrupts
///
pub fn disableInterrupts() void {}

///
/// Halt the CPU, but interrupts will still be called
///
pub fn halt() void {}

///
/// Wait the kernel but still can handle interrupts.
///
pub fn spinWait() noreturn {
    while (true) {}
}

///
/// Halt the kernel.
///
pub fn haltNoInterrupts() noreturn {
    while (true) {}
}

pub fn addTestParams(comptime fun_name: []const u8, params: ...) void {
    mock.addTestParams(fun_name, params);
}

pub fn initTest() void {
    mock = Mock().init();
}

pub fn freeTest() void {
    mock.finish();
}
