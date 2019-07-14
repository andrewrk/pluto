// Zig version: 0.4.0

const arch = @import("arch.zig").internals;
const Mock = @import("mock_framework.zig").Mock;

pub const WIDTH: u16        = 80;
pub const HEIGHT: u16       = 25;

pub const COLOUR_BLACK: u4            = 0x00;
pub const COLOUR_BLUE: u4             = 0x01;
pub const COLOUR_GREEN: u4            = 0x02;
pub const COLOUR_CYAN: u4             = 0x03;
pub const COLOUR_RED: u4              = 0x04;
pub const COLOUR_MAGENTA: u4          = 0x05;
pub const COLOUR_BROWN: u4            = 0x06;
pub const COLOUR_LIGHT_GREY: u4       = 0x07;
pub const COLOUR_DARK_GREY: u4        = 0x08;
pub const COLOUR_LIGHT_BLUE: u4       = 0x09;
pub const COLOUR_LIGHT_GREEN: u4      = 0x0A;
pub const COLOUR_LIGHT_CYAN: u4       = 0x0B;
pub const COLOUR_LIGHT_RED: u4        = 0x0C;
pub const COLOUR_LIGHT_MAGENTA: u4    = 0x0D;
pub const COLOUR_LIGHT_BROWN: u4      = 0x0E;
pub const COLOUR_WHITE: u4            = 0x0F;

pub const CursorShape = enum {
    UNDERLINE,
    BLOCK,
};

var mock: Mock() = undefined;

pub fn entryColour(fg: u4, bg: u4) u8 {
    return mock.performAction("entryColour", u8, fg, bg);
}

pub fn entry(uc: u8, colour: u8) u16 {
    return mock.performAction("entry", u16, uc, colour);
}

pub fn updateCursor(x: u16, y: u16) void {
    return mock.performAction("updateCursor", void, x, y);
}

pub fn getCursor() u16 {
    return mock.performAction("getCursor", u16);
}

pub fn enableCursor() void {
    return mock.performAction("enableCursor", void);
}

pub fn disableCursor() void {
    return mock.performAction("disableCursor", void);
}

pub fn setCursorShape(shape: CursorShape) void {
    return mock.performAction("setCursorShape", void, shape);
}

pub fn init() void {}

pub fn addRepeatFunction(comptime fun_name: []const u8, function: var) void {
    mock.addRepeatFunction(fun_name, function);
}

pub fn addTestFunction(comptime fun_name: []const u8, function: var) void {
    mock.addRepeatFunction(fun_name, function);
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