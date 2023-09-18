extern fn print(i32) void;

export fn add(a: i32, b: i32) i32 {
    print(a + b);
    return a + b;
}
