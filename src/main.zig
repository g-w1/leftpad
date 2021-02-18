const std = @import("std");
const testing = std.testing;
const Allocator = std.mem.Allocator;
const expectEqualSlices = testing.expectEqualSlices;

// Pads str on the left with ch len times
// returning an owned slice of the result allocated with ally.
pub fn leftpad(ally: *Allocator, str: []const u8, len: usize, ch: u8) ![]const u8 {
    var s = try ally.alloc(u8, str.len + len);
    const c = if (ch == 0) ' ' else ch;
    {
        var i: usize = 0;
        while (i < len) : (i += 1) {
            s[i] = c;
        }
    }
    for (str) |cha, i| {
        s[i + len] = cha;
    }
    return s;
}

test "leftpad" {
    const allocator = testing.allocator;
    try expectLeftPad(allocator, .{ .str = "hope we dont have the npm problem", .len = 3, .ch = '.' }, "...hope we dont have the npm problem");
    try expectLeftPad(allocator, .{ .str = "hope we dont have the npm problem", .len = 5, .ch = 0 }, "     hope we dont have the npm problem");
}

fn expectLeftPad(allocator: *Allocator, input: struct { str: []const u8, len: usize, ch: u8 }, output: []const u8) !void {
    const padded = try leftpad(allocator, input.str, input.len, input.ch);
    defer allocator.free(padded);
    expectEqualSlices(u8, output, padded);
}
