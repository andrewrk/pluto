// Zig version: 0.4.0

// Zig version: 0.4.0

const arch = @import("arch.zig").internals;
const Mock = @import("mock_framework.zig").Mock;

pub const WIDTH: u16        = 80;
pub const HEIGHT: u16       = 25;

// The set of colours that VGA supports and can display for the foreground and background.
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

/// The set of shapes that can be displayed.
pub const CursorShape = enum {
    /// The cursor has the underline shape.
    UNDERLINE,

    /// The cursor has the block shape.
    BLOCK,
};

var mock: Mock() = undefined;

///
/// Takes two 4 bit values that represent the foreground and background colour of the text and
/// returns a 8 bit value that gives both to be displayed.
///
/// Arguments:
///     IN fg: u4 - The foreground colour.
///     IN bg: u4 - The background colour.
///
/// Return:
///     Both combined into 1 byte for the colour to be displayed.
///
pub fn entryColour(fg: u4, bg: u4) u8 {
    return mock.performAction("entryColour", u8, fg, bg);
}

///
/// Create the 2 bytes entry that the VGA used to display a character with a foreground and
/// background colour.
///
/// Arguments:
///     IN uc: u8     - The character.
///     IN colour: u8 - The foreground and background colour.
///
/// Return:
///     The VGA entry.
///
pub fn entry(uc: u8, colour: u8) u16 {
    return mock.performAction("entry", u16, uc, colour);
}

///
/// Update the hardware on screen cursor.
///
/// Arguments:
///     IN x: u16 - The horizontal position of the cursor.
///     IN y: u16 - The vertical position of the cursor.
///
/// Return:
///     The VGA entry.
///
pub fn updateCursor(x: u16, y: u16) void {
    return mock.performAction("updateCursor", void, x, y);
}

///
/// Get the hardware cursor position.
///
/// Return:
///     The linear cursor position.
///
pub fn getCursor() u16 {
    return mock.performAction("getCursor", u16);
}

///
/// Enables the blinking cursor to that is is visible.
///
pub fn enableCursor() void {
    return mock.performAction("enableCursor", void);
}

///
/// Disables the blinking cursor to that is is visible.
///
pub fn disableCursor() void {
    return mock.performAction("disableCursor", void);
}

///
/// Set the shape of the cursor. This can be and underline or block shape.
///
/// Arguments:
///     IN shape: CURSOR_SHAPE - The enum CURSOR_SHAPE that selects which shape to use.
///
pub fn setCursorShape(shape: CursorShape) void {
    return mock.performAction("setCursorShape", void, shape);
}

///
/// Initialise the VGA text mode. This sets the cursor and underline shape.
///
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