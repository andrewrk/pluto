const builtin = @import("builtin");

pub const internals = if (builtin.is_test) @import("../../test/kernel/arch_mock.zig") else switch (builtin.arch) {
    builtin.Arch.i386 => @import("arch/x86/arch.zig"),
    else => unreachable,
};
