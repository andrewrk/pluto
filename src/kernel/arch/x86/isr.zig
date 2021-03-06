// Zig version: 0.4.0

const panic = @import("../../panic.zig");
const idt = @import("idt.zig");
const arch = @import("arch.zig");
const syscalls = @import("syscalls.zig");

const NUMBER_OF_ENTRIES: u16 = 32;

// The external assembly that is fist called to set up the exception handler.
extern fn isr0() void;
extern fn isr1() void;
extern fn isr2() void;
extern fn isr3() void;
extern fn isr4() void;
extern fn isr5() void;
extern fn isr6() void;
extern fn isr7() void;
extern fn isr8() void;
extern fn isr9() void;
extern fn isr10() void;
extern fn isr11() void;
extern fn isr12() void;
extern fn isr13() void;
extern fn isr14() void;
extern fn isr15() void;
extern fn isr16() void;
extern fn isr17() void;
extern fn isr18() void;
extern fn isr19() void;
extern fn isr20() void;
extern fn isr21() void;
extern fn isr22() void;
extern fn isr23() void;
extern fn isr24() void;
extern fn isr25() void;
extern fn isr26() void;
extern fn isr27() void;
extern fn isr28() void;
extern fn isr29() void;
extern fn isr30() void;
extern fn isr31() void;
extern fn isr128() void;

/// The exception messaged that is printed when a exception happens
const exception_msg: [NUMBER_OF_ENTRIES][]const u8 = [NUMBER_OF_ENTRIES][]const u8 {
    "Divide By Zero",
    "Single Step (Debugger)",
    "Non Maskable Interrupt",
    "Breakpoint (Debugger)",
    "Overflow",
    "Bound Range Exceeded",
    "Invalid Opcode",
    "No Coprocessor, Device Not Available",
    "Double Fault",
    "Coprocessor Segment Overrun",
    "Invalid Task State Segment (TSS)",
    "Segment Not Present",
    "Stack Segment Overrun",
    "General Protection Fault",
    "Page Fault",
    "Unknown Interrupt",
    "x87 FPU Floating Point Error",
    "Alignment Check",
    "Machine Check",
    "SIMD Floating Point",
    "Virtualization",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Reserved",
    "Security",
    "Reserved"
};

/// Errors that an isr function can return
pub const IsrError = error {
    UnrecognisedIsr
};

/// An isr handler. Takes an interrupt context and returns void.
/// Should finish quickly to avoid delaying further interrupts and the previously running code
pub const IsrHandler = fn(*arch.InterruptContext)void;

// The of exception handlers initialised to unhandled.
var isr_handlers: [NUMBER_OF_ENTRIES]IsrHandler = []IsrHandler{unhandled} ** NUMBER_OF_ENTRIES;
var syscall_handler: IsrHandler = unhandled;

///
/// A dummy handler that will make a call to panic as it is a unhandled exception.
///
/// Arguments:
///     IN context: *arch.InterruptContext - Pointer to the exception context containing the
///                                          contents of the register at the time of the exception.
///
fn unhandled(context: *arch.InterruptContext) void {
    const interrupt_num = context.int_num;
    panic.panicFmt(null, "Unhandled exception: {}, number {}", exception_msg[interrupt_num], interrupt_num);
}

///
/// Checks if the isr is valid and returns true if it is, else false.
/// To be valid it must be greater than or equal to 0 and less than NUMBER_OF_ENTRIES.
///
/// Arguments:
///     IN isr_num: u16 - The isr number to check
///
pub fn isValidIsr(isr_num: u32) bool {
    return isr_num >= 0 and isr_num < NUMBER_OF_ENTRIES;
}

///
/// The exception handler that each of the exceptions will call when a exception happens.
///
/// Arguments:
///     IN context: *arch.InterruptContext - Pointer to the exception context containing the
///                                          contents of the register at the time of the exception.
///
export fn isrHandler(context: *arch.InterruptContext) void {
    const isr_num = context.int_num;
    if (isr_num == syscalls.INTERRUPT) {
        syscall_handler(context);
    } else if (isValidIsr(isr_num)) {
        isr_handlers[isr_num](context);
    } else {
        panic.panicFmt(null, "Unrecognised isr: {}\n", isr_num);
    }
}

///
/// Register an exception by setting its exception handler to the given function.
///
/// Arguments:
///     IN irq_num: u16 - The exception number to register.
///
/// Errors:
///     IsrError.UnrecognisedIsr - If `isr_num` is invalid (see isValidIsr)
///
pub fn registerIsr(isr_num: u16, handler: fn(*arch.InterruptContext)void) !void {
    if (isr_num == syscalls.INTERRUPT) {
        syscall_handler = handler;
    } else if (isValidIsr(isr_num)) {
        isr_handlers[isr_num] = handler;
    } else {
        return IsrError.UnrecognisedIsr;
    }
}

///
/// Unregister an exception by setting its exception handler to the unhandled function call to
/// panic.
///
/// Arguments:
///     IN irq_num: u16 - The exception number to unregister.
///
pub fn unregisterIsr(isr_num: u16) void {
    isr_handlers[isr_num] = unhandled;
}

///
/// Initialise the exception and opening up all the IDT interrupt gates for each exception.
///
pub fn init() void {
    idt.openInterruptGate(0, isr0);
    idt.openInterruptGate(1, isr1);
    idt.openInterruptGate(2, isr2);
    idt.openInterruptGate(3, isr3);
    idt.openInterruptGate(4, isr4);
    idt.openInterruptGate(5, isr5);
    idt.openInterruptGate(6, isr6);
    idt.openInterruptGate(7, isr7);
    idt.openInterruptGate(8, isr8);
    idt.openInterruptGate(9, isr9);
    idt.openInterruptGate(10, isr10);
    idt.openInterruptGate(11, isr11);
    idt.openInterruptGate(12, isr12);
    idt.openInterruptGate(13, isr13);
    idt.openInterruptGate(14, isr14);
    idt.openInterruptGate(15, isr15);
    idt.openInterruptGate(16, isr16);
    idt.openInterruptGate(17, isr17);
    idt.openInterruptGate(18, isr18);
    idt.openInterruptGate(19, isr19);
    idt.openInterruptGate(20, isr20);
    idt.openInterruptGate(21, isr21);
    idt.openInterruptGate(22, isr22);
    idt.openInterruptGate(23, isr23);
    idt.openInterruptGate(24, isr24);
    idt.openInterruptGate(25, isr25);
    idt.openInterruptGate(26, isr26);
    idt.openInterruptGate(27, isr27);
    idt.openInterruptGate(28, isr28);
    idt.openInterruptGate(29, isr29);
    idt.openInterruptGate(30, isr30);
    idt.openInterruptGate(31, isr31);
    idt.openInterruptGate(syscalls.INTERRUPT, isr128);
}
