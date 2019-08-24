const std = @import("std");
const Mock = @import("mock_framework.zig").Mock;
const MemProfile = @import("mem_mock.zig").MemProfile;
const expect = std.testing.expect;
const warn = std.debug.warn;

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

var mock: ?Mock() = undefined;

pub fn init(mem_profile: *const MemProfile, allocator: *std.mem.Allocator) void {
    return mock.?.performAction("init", void, mem_profile, allocator);
}

pub fn outb(port: u16, data: u8) void {
    return mock.?.performAction("outb", void, port, data);
}

pub fn inb(port: u16) u8 {
    return mock.?.performAction("inb", u8, port);
}

pub fn ioWait() void {
    return mock.?.performAction("ioWait", void);
}

pub fn registerInterruptHandler(int: u16, ctx: fn (ctx: *InterruptContext) void) void {
    return mock.?.performAction("registerInterruptHandler", void, int, ctx);
}

pub fn lgdt(gdt_ptr: *const gdt.GdtPtr) void {
    return mock.?.performAction("lgdt", void, gdt_ptr.*);
}

pub fn ltr() void {
    return mock.?.performAction("ltr", void);
}

pub fn lidt(idt_ptr: *const idt.IdtPtr) void {
    return mock.?.performAction("lidt", void, idt_ptr.*);
}

pub fn enableInterrupts() void {
    return mock.?.performAction("enableInterrupts", void);
}

pub fn disableInterrupts() void {
    return mock.?.performAction("disableInterrupts", void);
}

pub fn halt() void {
    return mock.?.performAction("halt", void);
}

pub fn spinWait() noreturn {
    while (true) {}
}

pub fn haltNoInterrupts() noreturn {
    while (true) {}
}

pub fn addTestParams(comptime fun_name: []const u8, params: ...) void {
    mock.?.addTestParams(fun_name, params);
}

pub fn initTest() void {
    // Make sure there isn't a mock object
    if (mock) |_| {
        warn("MOCK object for arch.zig already exists, please free previous test\n");
        expect(false);
    } else {
        mock = Mock().init();
    }
}

pub fn freeTest() void {
    // Make sure we have a mock object to free
    if (mock) |*m| {
        m.*.finish();
    } else {
        warn("MOCK object for arch.zig doesn't exists, please initiate this test\n");
        expect(false);
    }
    
    // This will stop double frees
    mock = null;
}
