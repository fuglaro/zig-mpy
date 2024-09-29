const std = @import("std");
const testing = std.testing;

// TODO: Zig needs support for PIC compilation on ARM.
//var inc = [_]i32{0} ** 1;

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

export fn increment() i32 {
    //inc[0] += 1;
    return 1; //inc[0];
}

export fn factorial_helper(n: i32) i32 {
    var result: i32 = 1;
    var i: i32 = 1;
    while (i <= n) : (i += 1)
        result *= i;
    return result;
}

test "basic adds functionality" {
    try testing.expect(add(3, 7) == 10);
}

test "basic factorial_helper functionality" {
    std.debug.assert(factorial_helper(0) == 1);
    std.debug.assert(factorial_helper(1) == 1);
    std.debug.assert(factorial_helper(10) == 3628800);
}
