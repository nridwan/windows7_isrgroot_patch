const std = @import("std");
const builtin = @import("builtin");
const testing = std.testing;
const process = std.process;
const fs = std.fs;
const ChildProcess = std.ChildProcess;

var a: *std.mem.Allocator = undefined;

fn printCmd(cwd: []const u8, argv: []const []const u8) void {
    std.log.warn("cd {s} && ", .{cwd});
    for (argv) |arg| {
        std.log.warn("{s} ", .{arg});
    }
    std.log.warn("\n", .{});
}

fn exec(cwd: []const u8, argv: []const []const u8) !ChildProcess.ExecResult {
    const result = ChildProcess.exec(.{
        .allocator = a.*, 
        .argv = argv, 
        .cwd = cwd,
    }) catch |err| {
        std.log.warn("The following command failed:\n", .{});
        printCmd(cwd, argv);
        return err;
    };
    switch (result.term) {
        .Exited => |code| {
            if (code != 0) {
                std.log.warn("The following command exited with error code {any}:\n", .{code});
                printCmd(cwd, argv);
                std.log.warn("stderr:\n{s}\n", .{result.stderr});
                return error.CommandFailed;
            }
        },
        else => {
            std.log.warn("The following command terminated unexpectedly:\n", .{});
            printCmd(cwd, argv);
            std.log.warn("stderr:\n{s}\n", .{result.stderr});
            return error.CommandFailed;
        },
    }
    return result;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    a = &arena.allocator();
    {
        var cert: []const u8 = undefined;
        comptime {
            cert = @embedFile("./isrgrootx1.crt");
        }
        const file = try std.fs.cwd().createFile("temp.crt", .{});
        defer file.close();
        _ = try file.write(cert);
    }
    _ = try exec(".", &.{ "certutil.exe", "-f", "-addstore", "root", "temp.crt" });
    _ = try std.os.unlink("temp.crt");
    try stdout.print("Press enter to continue: ", .{});
    _ = try stdin.readUntilDelimiterAlloc(a.*, '\n', 100);
}
