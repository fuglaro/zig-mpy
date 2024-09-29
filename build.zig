const std = @import("std");

pub fn build(b: *std.Build) void {

    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // This should be changed to your target architecture.
    // It is currently set for the rp2350.
    // NOTE: you will also have change Makefile to switch targets.
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .thumb,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
        .os_tag = .freestanding,
        .abi = .eabi,
    });

    const optimize = std.builtin.OptimizeMode.ReleaseSmall;

    const root = b.addObject(.{
        .name = "root",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
        .pic = true,
    });
    const rootlib = b.addInstallLibFile(root.getEmittedBin(), "root.o");
    b.default_step.dependOn(&rootlib.step);

    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/root.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}
