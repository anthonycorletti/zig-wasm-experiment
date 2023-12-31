const std = @import("std");
const testing = std.testing;

extern fn print(i32) void;

export fn add(a: i32, b: i32) i32 {
    print(a + b);
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}
