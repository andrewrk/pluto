const vga = @import("../../../src/kernel/vga.zig");
const arch = @import("../../../src/kernel/arch.zig").internals;

const expectEqual = @import("std").testing.expectEqual;

test "entryColour" {
    var fg: u4 = vga.COLOUR_BLACK;
    var bg: u4 = vga.COLOUR_BLACK;
    var res: u8 = vga.entryColour(fg, bg);
    expectEqual(u8(0x00), res);
    
    fg = vga.COLOUR_LIGHT_GREEN;
    bg = vga.COLOUR_BLACK;
    res = vga.entryColour(fg, bg);
    expectEqual(u8(0x0A), res);
    
    fg = vga.COLOUR_BLACK;
    bg = vga.COLOUR_LIGHT_GREEN;
    res = vga.entryColour(fg, bg);
    expectEqual(u8(0xA0), res);
    
    fg = vga.COLOUR_BROWN;
    bg = vga.COLOUR_LIGHT_GREEN;
    res = vga.entryColour(fg, bg);
    expectEqual(u8(0xA6), res);
}

test "entry" {
    var colour: u8 = vga.entryColour(vga.COLOUR_BROWN, vga.COLOUR_LIGHT_GREEN);
    expectEqual(u8(0xA6), colour);
    
    // Character '0' is 0x30
    var video_entry: u16 = vga.entry('0', colour);
    expectEqual(u16(0xA630), video_entry);
    
    video_entry = vga.entry(0x55, colour);
    expectEqual(u16(0xA655), video_entry);
}

test "updateCursor out of bounds" {
    var x: u16 = 0;
    var y: u16 = 0;
    const max_cursor: u16 = (vga.HEIGHT - 1) * vga.WIDTH + (vga.WIDTH - 1);
    
    var expected_upper: u8 = @truncate(u8, (max_cursor >> 8) & 0x00FF);
    var expected_lower: u8 = @truncate(u8, max_cursor & 0x00FF);
    
    x = vga.WIDTH;
    y = 0;
    
    // Mocking out the arch.outb calls for changing the hardware cursor:
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_LOW,
        vga.PORT_DATA, expected_lower,
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_HIGH,
        vga.PORT_DATA, expected_upper);
    
    vga.updateCursor(x, y);
    arch.freeTest();
    
    x = 0;
    y = vga.HEIGHT;
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_LOW,
        vga.PORT_DATA, expected_lower,
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_HIGH,
        vga.PORT_DATA, expected_upper);
    vga.updateCursor(x, y);
    arch.freeTest();
    
    x = vga.WIDTH;
    y = vga.HEIGHT;
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_LOW,
        vga.PORT_DATA, expected_lower,
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_HIGH,
        vga.PORT_DATA, expected_upper);
    vga.updateCursor(x, y);
    arch.freeTest();
    
    x = vga.WIDTH - 1;
    y = vga.HEIGHT;
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_LOW,
        vga.PORT_DATA, expected_lower,
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_HIGH,
        vga.PORT_DATA, expected_upper);
    vga.updateCursor(x, y);
    arch.freeTest();
    
    x = vga.WIDTH;
    y = vga.HEIGHT - 1;
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_LOW,
        vga.PORT_DATA, expected_lower,
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_HIGH,
        vga.PORT_DATA, expected_upper);
    vga.updateCursor(x, y);
    arch.freeTest();
}

test "updateCursor in bounds" {
    var x: u16 = 0x000A;
    var y: u16 = 0x000A;
    const expected: u16 = y * vga.WIDTH + x;
    
    var expected_upper: u8 = @truncate(u8, (expected >> 8) & 0x00FF);
    var expected_lower: u8 = @truncate(u8, expected & 0x00FF);
    
    // Mocking out the arch.outb calls for changing the hardware cursor:
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_LOW,
        vga.PORT_DATA, expected_lower,
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_HIGH,
        vga.PORT_DATA, expected_upper);
    vga.updateCursor(x, y);
    arch.freeTest();
}

test "getCursor all" {
    var expect: u16 = u16(10);
    
    // Mocking out the arch.outb and arch.inb calls for getting the hardware cursor:
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_LOW);
    
    arch.addTestParams("inb",
        vga.PORT_DATA, u8(10));
    
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_HIGH);
    
    arch.addTestParams("inb",
        vga.PORT_DATA, u8(0));
    
    var actual: u16 = vga.getCursor();
    expectEqual(expect, actual);
    arch.freeTest();
    
    expect = u16(0xBEEF);
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_LOW);
    
    arch.addTestParams("inb",
        vga.PORT_DATA, u8(0xEF));
    
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_LOCATION_HIGH);
    
    arch.addTestParams("inb",
        vga.PORT_DATA, u8(0xBE));
    
    actual = vga.getCursor();
    expectEqual(expect, actual);
    arch.freeTest();
}

test "enableCursor all" {
    // Need to init the cursor start and end positions, so call the vga.init() to set this up
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_MAXIMUM_SCAN_LINE,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_END,
        vga.PORT_ADDRESS, vga.REG_CURSOR_START,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_MIDDLE,
        vga.PORT_ADDRESS, vga.REG_CURSOR_END,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_END,
        // Mocking out the arch.outb calls for enabling the cursor:
        // These are the default cursor positions from vga.init()
        vga.PORT_ADDRESS, vga.REG_CURSOR_START,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_MIDDLE,
        vga.PORT_ADDRESS, vga.REG_CURSOR_END,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_END);
    
    vga.init();
    vga.enableCursor();
    
    arch.freeTest();
}

test "disableCursor all" {
    // Mocking out the arch.outb calls for disabling the cursor:
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_START,
        vga.PORT_DATA, vga.CURSOR_DISABLE);
    vga.disableCursor();
    arch.freeTest();
}

test "setCursorShape UNDERLINE" {
    // Mocking out the arch.outb calls for setting the cursor shape to underline:
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_START,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_MIDDLE,
        vga.PORT_ADDRESS, vga.REG_CURSOR_END,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_END);
    
    vga.setCursorShape(vga.CursorShape.UNDERLINE);
    expectEqual(vga.CURSOR_SCANLINE_MIDDLE, vga.getCursorStart());
    expectEqual(vga.CURSOR_SCANLINE_END, vga.getCursorEnd());
    
    arch.freeTest();
}

test "setCursorShape BLOCK" {
    // Mocking out the arch.outb calls for setting the cursor shape to block:
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_CURSOR_START,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_START,
        vga.PORT_ADDRESS, vga.REG_CURSOR_END,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_END);
    
    vga.setCursorShape(vga.CursorShape.BLOCK);
    expectEqual(vga.CURSOR_SCANLINE_START, vga.getCursorStart());
    expectEqual(vga.CURSOR_SCANLINE_END, vga.getCursorEnd());
    
    arch.freeTest();
}

test "init all" {
    // Mocking out the arch.outb calls for setting the cursor max scan line and the shape to block:
    arch.initTest();
    arch.addTestParams("outb",
        vga.PORT_ADDRESS, vga.REG_MAXIMUM_SCAN_LINE,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_END,
        vga.PORT_ADDRESS, vga.REG_CURSOR_START,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_MIDDLE,
        vga.PORT_ADDRESS, vga.REG_CURSOR_END,
        vga.PORT_DATA, vga.CURSOR_SCANLINE_END);
    
    vga.init();
    expectEqual(vga.CURSOR_SCANLINE_MIDDLE, vga.getCursorStart());
    expectEqual(vga.CURSOR_SCANLINE_END, vga.getCursorEnd());
    
    arch.freeTest();
}
