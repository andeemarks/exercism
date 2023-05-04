const std = @import("std");
const bufPrint = std.fmt.bufPrint;

pub fn twoFer(_: []u8, name: ?[]const u8) anyerror![]u8 {
    return "One for " ++ name ++ ", one for me.";
}
