const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    _ = b.addModule("leftpad", .{
        .source_file = .{ .path = "src/main.zig" },
    });

    const optimize = b.standardOptimizeOption(.{});

    const main_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .optimize = optimize,
    });

    const run_tests = b.addRunArtifact(main_tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_tests.step);
}
