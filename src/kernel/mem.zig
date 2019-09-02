const multiboot = @import("multiboot.zig");
const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

pub const MemProfile = struct {
    vaddr_end: [*]u8,
    vaddr_start: [*]u8,
    physaddr_end: [*]u8,
    physaddr_start: [*]u8,
    mem_kb: u32,
    fixed_alloc_size: u32
};


// The virtual/physical start/end of the kernel code
extern var KERNEL_VADDR_END: *u32;
extern var KERNEL_VADDR_START: *u32;
extern var KERNEL_PHYSADDR_END: *u32;
extern var KERNEL_PHYSADDR_START: *u32;

// The size of the fixed allocator used before the heap is set up. Set to 1MiB.
const FIXED_ALLOC_SIZE = 1024 * 1024;

pub const HeapAllocator = struct {
    allocator: Allocator,
    start: usize,
    end: usize,

    pub fn init(start_addr: usize, end_addr: usize) HeapAllocator {
        return HeapAllocator {
            .allocator = Allocator {
                .reallocFn = realloc,
                .shrinkFn = shrink
            },
            .start = start_addr,
            .end = end_addr
        };
    }

    fn realloc(self: *Allocator, old_mem: []u8, old_alignment: u29, new_byte_count: usize, new_alignment: u29) Allocator.Error![]u8 {
        return Allocator.Error.OutOfMemory; 
    }

    fn shrink(self: *Allocator, old_mem: []u8, old_alignment: u29, new_byte_count: usize, new_alignment: u29) []u8 {
        return undefined;
    }
};

pub fn initMemProfile(mb_info: *multiboot.multiboot_info_t) MemProfile {
    return MemProfile{
        .vaddr_end = @ptrCast([*]u8, &KERNEL_VADDR_END),
        .vaddr_start = @ptrCast([*]u8, &KERNEL_VADDR_START),
        .physaddr_end = @ptrCast([*]u8, &KERNEL_PHYSADDR_END),
        .physaddr_start = @ptrCast([*]u8, &KERNEL_PHYSADDR_START),
        // Total memory available including the initial 1MiB that grub doesn't include
        .mem_kb = mb_info.mem_upper + mb_info.mem_lower + 1024,
        .fixed_alloc_size = FIXED_ALLOC_SIZE,
    };
}

/// Tests

const buff_size = u32(1024);
const buff = []const u8{0} ** buff_size;

fn getTestAllocator() HeapAllocator {
    const buff_start = @ptrToInt(&buff);
    const buff_end = buff_start + buff_size;
    return HeapAllocator.init(buff_start, buff_end);
}

test "Can allocate" {
    var heap = getTestAllocator();
    var allocator = heap.allocator;
    const res = try allocator.alloc(u8, 100);
    const res_addr = @ptrToInt(&res);
    // The whole space allocated must be within the start and end
    assert(res_addr <= heap.end - 100 and res_addr >= heap.start);
}

test "Doesn't allocate too much" {
    var allocator = getTestAllocator().allocator;
    const res = allocator.alloc(u8, buff_size) catch |e| {
        return;
    };
    unreachable;
}

test "Can allocate the whole space" {
    var heap = getTestAllocator();
    const 
}
