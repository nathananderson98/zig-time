const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const datetime_module = b.addModule("datetime", .{
        .source_file = .{ .path = "src/datetime.zig" },
    });

    const exe = b.addExecutable(.{
        .name = "datetime.zig demo",
        .root_source_file = .{ .path = "example/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.addModule("datetime", datetime_module);

    // b.installArtifact(exe);

    // const lib = b.addStaticLibrary(.{
    //     .name = "datetime",
    //     .root_source_file = .{ .path = "src/time.zig" },
    //     .target = target,
    //     .optimize = optimize,
    // });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // const main_tests = b.addTest(.{
    //     .root_source_file = .{ .path = "src/main.zig" },
    //     .target = target,
    //     .optimize = optimize,
    // });

    // const run_main_tests = b.addRunArtifact(main_tests);

    // const test_step = b.step("test", "Run library tests");
    // test_step.dependOn(&run_main_tests.step);
}
