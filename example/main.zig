const time = @import("datetime");
const std = @import("std");

pub fn main() !void {
    const one = 1;
    std.debug.print("{d}", .{one});
}
