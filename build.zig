const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const module = b.addModule("vulkan-headers", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.addWriteFiles().add("empty.c", ""),
    });

    const lib = b.addLibrary(.{
        .name = "vulkan-headers",
        .root_module = module,
        .linkage = .static,
    });

    inline for (.{ "vk_video", "vulkan" }) |subdir| {
        lib.installHeadersDirectory(b.path("include/" ++ subdir), subdir, .{});
    }
    b.installArtifact(lib);
}
