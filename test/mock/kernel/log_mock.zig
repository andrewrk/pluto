const serial = @import("serial.zig");
const fmt = @import("std").fmt;
const Mock = @import("mock_framework.zig").Mock;

pub const Level = enum {
    INFO,
    DEBUG,
    WARNING,
    ERROR,
};

var mock: Mock() = undefined;

fn logCallback(context: void, str: []const u8) anyerror!void {}

pub fn log(comptime level: Level, comptime format: []const u8, args: ...) void {
    //return mock.performAction("log", void, level, format, args);
}

pub fn logInfo(comptime format: []const u8, args: ...) void {
    //return mock.performAction("logInfo", void, format, args);
}

pub fn logDebug(comptime format: []const u8, args: ...) void {
    //return mock.performAction("logDebug", void, format, args);
}

pub fn logWarning(comptime format: []const u8, args: ...) void {
    //return mock.performAction("logWarning", void, format, args);
}

pub fn logError(comptime format: []const u8, args: ...) void {
    //return mock.performAction("logError", void, format, args);
}

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