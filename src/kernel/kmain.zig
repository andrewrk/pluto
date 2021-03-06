// Zig version: 0.4.0

const std = @import("std");
const builtin = @import("builtin");
const arch = if (builtin.is_test) @import("../../test/kernel/arch_mock.zig") else @import("arch.zig").internals;
const multiboot = @import("multiboot.zig");
const tty = @import("tty.zig");
const vga = @import("vga.zig");
const log = @import("log.zig");
const serial = @import("serial.zig");
const mem = @import("mem.zig");
const options = @import("build_options");

// Need to import this as we need the panic to be in the root source file, or zig will just use the
// builtin panic and just loop, which is what we don't want
const panic_root = @import("panic.zig");

// Just call the panic function, as this need to be in the root source file
pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    arch.disableInterrupts();
    panic_root.panicFmt(error_return_trace, "{}", msg);
}

pub export fn kmain(mb_info: *multiboot.multiboot_info_t, mb_magic: u32) void {
    if (mb_magic == multiboot.MULTIBOOT_BOOTLOADER_MAGIC) {
        // Booted with compatible bootloader
        const mem_profile = mem.init(mb_info);
        var buffer = mem_profile.vaddr_end[0..mem_profile.fixed_alloc_size];
        var fixed_allocator = std.heap.FixedBufferAllocator.init(buffer);

        serial.init(serial.DEFAULT_BAUDRATE, serial.Port.COM1) catch unreachable;

        log.logInfo("Init arch " ++ @tagName(builtin.arch) ++ "\n");
        arch.init(&mem_profile, &fixed_allocator.allocator, options);
        log.logInfo("Arch init done\n");
        vga.init();
        tty.init();

        log.logInfo("Init done\n");
        tty.print("Hello Pluto from kernel :)\n");
    }
}
