const time = @import("datetime");
const std = @import("std");

pub fn main() !void {
    const now = time.Datetime.now();
    std.debug.print("{d}", .{now.miliTime()});
}
