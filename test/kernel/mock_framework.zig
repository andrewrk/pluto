// Zig version: 0.4.0

const std = @import("std");
const builtin = @import("builtin");
const AutoHashMap = std.AutoHashMap;
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const GlobalAllocator = std.debug.global_allocator;
const LinkedList = std.LinkedList;
const warn = std.debug.warn;

const DataElementType = enum {
    U4,
    U8,
    U16,
    U32,
    FN_OVOID,
    FN_OU16,
    FN_IU16_OU8,
    FN_IU4_IU4_OU8,
    FN_IU8_IU8_OU16,
    FN_IU16_IU8_OVOID,
    FN_IU16_IU16_OVOID,
};

const ActionType = enum {
    TestValue,
    ConsumeFunctionCall,
    RepeatFunctionCall,
};

const DataElement = union (DataElementType) {
    U4: u4,
    U8: u8,
    U16: u16,
    U32: u32,
    FN_OVOID: fn()void,
    FN_OU16: fn()u16,
    FN_IU16_OU8: fn(u16)u8,
    FN_IU4_IU4_OU8: fn(u4, u4)u8,
    FN_IU8_IU8_OU16: fn(u8, u8)u16,
    FN_IU16_IU8_OVOID: fn(u16, u8)void,
    FN_IU16_IU16_OVOID: fn(u16, u16)void,
};

const Action = struct {
    action: ActionType,
    data: DataElement,
};

const ActionList = LinkedList(Action);
const NamedActionMap = AutoHashMap([]const u8, ActionList);

pub fn Mock() type {
    return struct {
        const Self = @This();

        named_actions: NamedActionMap,

        pub fn init() Self {
            return Self {
                .named_actions = AutoHashMap([]const u8, ActionList).init(GlobalAllocator),
            };
        }

        pub fn addTestParam(self: *Self, comptime fun_name: []const u8, comptime T: type, param: T) void {
            if (!self.named_actions.contains(fun_name)) {
                // Add the a new mapping
                expect(self.named_actions.put(fun_name, LinkedList(Action).init()) catch unreachable == null);
            }

            if (self.named_actions.get(fun_name)) |actions_kv| {
                var action_list = actions_kv.value;
                const data_element = switch (T) {
                    u4 => DataElement { .U4 = param },
                    u8 => DataElement { .U8 = param },
                    u16 => DataElement { .U16 = param },
                    u32 => DataElement { .U32 = param },
                    else => @compileError("Type not supported: " ++ @typeName(T)),
                };
                const action = Action {
                    .action = ActionType.TestValue,
                    .data = data_element
                };
                var a = action_list.createNode(action, GlobalAllocator) catch unreachable;
                action_list.append(a);
                // Need to re-assign the value as it isn't updated when we just append for some reason
                actions_kv.value = action_list;
            } else {
                // Shouldn't get here as we would have just added a new mapping
                // But just in case ;)
                warn("No function name: " ++ fun_name ++ "\n");
                expect(false);
            }
        }

        pub fn addTestParams(self: *Self, comptime fun_name: []const u8, params: ...) void {
            comptime var i: u32 = u32(0);
            inline while (i < params.len) {
                self.addTestParam(fun_name, @typeOf(params[i]), params[i]);
                i += 1;
            }
        }

        pub fn addTestFunction(self: *Self, comptime fun_name: []const u8, function: var) void {
            if (!self.named_actions.contains(fun_name)) {
                // Add the a new mapping
                expect(self.named_actions.put(fun_name, ActionList.init()) catch unreachable == null);
            }

            const optional_actions_kv = self.named_actions.get(fun_name);
            if (optional_actions_kv) |actions_kv| {
                var action_list = actions_kv.value;
                const data_element = switch (@typeOf(function)) {
                    fn()void => DataElement { .FN_OVOID = function },
                    fn()u16 => DataElement { .FN_OU16 = function },
                    fn(u16)u8 => DataElement { .FN_IU16_OU8 = function },
                    fn(u4, u4)u8 => DataElement { .FN_IU4_IU4_OU8 = function },
                    fn(u8, u8)u16 => DataElement { .FN_IU8_IU8_OU16 = function },
                    fn(u16, u8)void => DataElement { .FN_IU16_IU8_OVOID = function },
                    fn(u16, u16)void => DataElement { .FN_IU16_IU16_OVOID = function },
                    else => @compileError("Type not supported: " ++ @typeName(@typeOf(function))),
                };
                const action = Action {
                    .action = ActionType.ConsumeFunctionCall,
                    .data = data_element
                };
                var a = action_list.createNode(action, GlobalAllocator) catch unreachable;
                action_list.append(a);
                // Need to re-assign the value as it isn't updated when we just append for some reason
                actions_kv.value = action_list;
            } else {
                // Shouldn't get here as we would have just added a new mapping
                // But just in case ;)
                warn("No function name: " ++ fun_name ++ "\n");
                expect(false);
            }
        }

        pub fn addRepeatFunction(self: *Self, comptime fun_name: []const u8, function: var) void {
            if (!self.named_actions.contains(fun_name)) {
                // Add the a new mapping
                expect(self.named_actions.put(fun_name, ActionList.init()) catch unreachable == null);
            } else {
                // Can only have one repeat function as will be a one to one match
                warn("One repeat function for " ++ fun_name ++ " only\n");
                expect(false);
            }

            const optional_actions_kv = self.named_actions.get(fun_name);
            if (optional_actions_kv) |actions_kv| {
                var action_list = actions_kv.value;
                const data_element = switch (@typeOf(function)) {
                    fn()void => DataElement { .FN_OVOID = function },
                    fn()u16 => DataElement { .FN_OU16 = function },
                    fn(u16)u8 => DataElement { .FN_IU16_OU8 = function },
                    fn(u4, u4)u8 => DataElement { .FN_IU4_IU4_OU8 = function },
                    fn(u8, u8)u16 => DataElement { .FN_IU8_IU8_OU16 = function },
                    fn(u16, u8)void => DataElement { .FN_IU16_IU8_OVOID = function },
                    fn(u16, u16)void => DataElement { .FN_IU16_IU16_OVOID = function },
                    else => @compileError("Type not supported: " ++ @typeName(@typeOf(function))),
                };
                const action = Action {
                    .action = ActionType.RepeatFunctionCall,
                    .data = data_element
                };
                var a = action_list.createNode(action, GlobalAllocator) catch unreachable;
                action_list.append(a);
                // Need to re-assign the value as it isn't updated when we just append for some reason
                actions_kv.value = action_list;
            } else {
                // Shouldn't get here as we would have just added a new mapping
                // But just in case ;)
                warn("No function name: " ++ fun_name ++ "\n");
                expect(false);
            }
        }

        pub fn finish(self: *Self) void {
            // Make sure the expected list is empty
            var it = self.named_actions.iterator();
            var count: usize = 0;
            while (it.next()) |next| {
                var action_list = next.value;
                var optional_action_node = action_list.popFirst();
                if (optional_action_node) |action_node| {
                    const action = action_node.data;
                    switch (action.action) {
                        ActionType.TestValue, ActionType.ConsumeFunctionCall => {
                            // These need to be all consumed
                            warn("Unused testing value: Type: {}, value: {}:{} for function '{}'\n",
                                action.action, DataElementType(action.data), @enumToInt(action.data), next.key);
                            expect(false);
                        },
                        ActionType.RepeatFunctionCall => {
                            // As this is a repeat action, the function will still be here
                            // So need to free it
                            action_list.destroyNode(action_node, GlobalAllocator);
                            next.value = action_list;
                        },
                    }
                }
                count += 1;
            }
            self.named_actions.deinit();
        }

        fn getDataType(comptime T: type) DataElementType {
            return switch (T) {
                u4 => DataElementType.U4,
                u8 => DataElementType.U8,
                u16 => DataElementType.U16,
                u32 => DataElementType.U32,
                fn()void => DataElementType.FN_OVOID,
                fn()u16 => DataElementType.FN_OU16,
                fn(u16)u8 => DataElementType.FN_IU16_OU8,
                fn(u4, u4)u8 => DataElementType.FN_IU4_IU4_OU8,
                fn(u8, u8)u16 => DataElementType.FN_IU8_IU8_OU16,
                fn(u16, u8)void => DataElementType.FN_IU16_IU8_OVOID,
                fn(u16, u16)void => DataElementType.FN_IU16_IU16_OVOID,
                else => @compileError("Type not supported: " ++ @typeName(T)),
            };
        }

        fn getDataValue(comptime T: type, element: DataElement) T {
            return switch (T) {
                u4 => element.U4,
                u8 => element.U8,
                u16 => element.U16,
                u32 => element.U32,
                fn()void => element.FN_OVOID,
                fn()u16 => element.FN_OU16,
                fn(u16)u8 => element.FN_IU16_OU8,
                fn(u4, u4)u8 => element.FN_IU4_IU4_OU8,
                fn(u8, u8)u16 => element.FN_IU8_IU8_OU16,
                fn(u16, u8)void => element.FN_IU16_IU8_OVOID,
                fn(u16, u16)void => element.FN_IU16_IU16_OVOID,
                else => @compileError("Type not supported: " ++ @typeName(T)),
            };
        }

        fn expectTest(comptime ET: type, expected_value: ET, element_value: DataElement) void {
            if (ET == void) {
               // Can't test void as it has no value
               warn("Can not test a value for void\n");
               expect(false);
            }

            const expect_type = getDataType(ET);

            // Test that the types match
            expectEqual(expect_type, DataElementType(element_value));

            // Types match, so can use the expected type to get the actual data
            const actual_value = getDataValue(ET, element_value);

            // Test the values
            expectEqual(expected_value, actual_value);
        }

        fn expectGetValue(comptime fun_name: []const u8, action_list: *ActionList, comptime DataType: type) DataType {
            if (DataType == void) {
                return;
            }
            const optional_action_node = action_list.*.popFirst();
            var ret: DataType = undefined;
            if (optional_action_node) |action_node| {
                const action = action_node.data;
                const expect_type = getDataType(DataType);

                ret = getDataValue(DataType, action.data);

                expectEqual(DataElementType(action.data), expect_type);

                // Free the node
                action_list.*.destroyNode(action_node, GlobalAllocator);
            } else {
                warn("No more test values for the return of function: " ++ fun_name ++ "\n");
                expect(false);
            }
            return ret;
        }

        fn getFunctionType(comptime RetType: type, params: ...) type {
            if (params.len == 0) return fn()RetType;
            if (params.len == 1) return fn(@typeOf(params[0]))RetType;
            if (params.len == 2) return fn(@typeOf(params[0]), @typeOf(params[1]))RetType;
        }

        pub fn performAction(self: *Self, comptime fun_name: []const u8, comptime RetType: type, params: ...) RetType {
            var retValue: RetType = undefined;
            if (self.named_actions.get(fun_name)) |kv_actions_list| {
                var action_list = kv_actions_list.value;
                // Peak the first action to test the action type
                const optional_action_node = action_list.first;
                if (optional_action_node) |action_node| {
                    const action = action_node.data;
                    retValue = switch (action.action) {
                        ActionType.TestValue => ret: {
                            comptime var i: u32 = u32(0);
                            inline while (i < params.len) {
                                // Now pop the action as we are going to use it
                                // Have already checked that it is not null
                                const test_node = action_list.popFirst().?;
                                const test_action = test_node.data;
                                const param = params[i];
                                const param_type = @typeOf(params[i]);

                                expectTest(param_type, param, test_action.data);

                                // Free the node
                                action_list.destroyNode(test_node, GlobalAllocator);

                                i += 1;
                            }
                            break :ret expectGetValue(fun_name, &action_list, RetType);
                        },
                        ActionType.ConsumeFunctionCall => ret: {
                            // Now pop the action as we are going to use it
                            // Have already checked that it is not null
                            const test_node = action_list.popFirst().?;
                            const test_element = test_node.data.data;

                            // Work out the type of the function to call from the params and return type
                            // At compile time
                            //const expected_function = getFunctionType(RetType, params);
                            // Waiting for this:
                            // error: compiler bug: unable to call var args function at compile time. https://github.com/ziglang/zig/issues/313
                            // to be resolved
                            const expected_function = switch (params.len) {
                                0 => fn()RetType,
                                1 => fn(@typeOf(params[0]))RetType,
                                2 => fn(@typeOf(params[0]), @typeOf(params[1]))RetType,
                                else => @compileError("Couldn't generate function type for " ++ params.len ++ "parameters\n"),
                            };

                            // Get the corresponding DataElementType
                            const expect_type = getDataType(expected_function);

                            // Test that the types match
                            expectEqual(expect_type, DataElementType(test_element));

                            // Types match, so can use the expected type to get the actual data
                            const actual_function = getDataValue(expected_function, test_element);

                            // Free the node
                            action_list.destroyNode(test_node, GlobalAllocator);

                            // The data element will contain the function to call
                            const r = switch (params.len) {
                                0 => @noInlineCall(actual_function),
                                1 => @noInlineCall(actual_function, params[0]),
                                2 => @noInlineCall(actual_function, params[0], params[1]),
                                else => @compileError(params.len ++ " or more parameters not supported"),
                            };

                            break :ret r;
                        },
                        ActionType.RepeatFunctionCall => ret: {
                            // Do the same for ActionType.ConsumeFunctionCall but instead of
                            // popping the function, just peak
                            const test_element = action.data;
                            const expected_function = switch (params.len) {
                                0 => fn()RetType,
                                1 => fn(@typeOf(params[0]))RetType,
                                2 => fn(@typeOf(params[0]), @typeOf(params[1]))RetType,
                                else => @compileError("Couldn't generate function type for " ++ params.len ++ "parameters\n"),
                            };

                            // Get the corresponding DataElementType
                            const expect_type = getDataType(expected_function);

                            // Test that the types match
                            expectEqual(expect_type, DataElementType(test_element));

                            // Types match, so can use the expected type to get the actual data
                            const actual_function = getDataValue(expected_function, test_element);

                            // The data element will contain the function to call
                            const r = switch (params.len) {
                                0 => @noInlineCall(actual_function),
                                1 => @noInlineCall(actual_function, params[0]),
                                2 => @noInlineCall(actual_function, params[0], params[1]),
                                else => @compileError(params.len ++ " or more parameters not supported"),
                            };

                            break :ret r;
                        },
                    };
                    // Re-assign the action list as this would have changed
                    kv_actions_list.value = action_list;
                } else {
                    warn("No action list elements for function: " ++ fun_name ++ "\n");
                    expect(false);
                }
            } else {
                warn("No function name: " ++ fun_name ++ "\n");
                expect(false);
            }

            return retValue;
        }
    };
}
