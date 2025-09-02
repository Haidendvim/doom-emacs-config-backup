# C++ Debugging with Doom Emacs

## Quick Setup for New Projects

1. Create a new project:
   ```bash
   newcpp MyProject ~/Projects
   cd ~/Projects/MyProject
   ```

2. Build the project:
   ```bash
   mkdir build && cd build
   cmake .. && make
   cd .. && ln -sf build/compile_commands.json .
   ```

3. Open in Doom Emacs:
   ```bash
   emacs .
   ```

## Key Bindings for C/C++ Debugging

| Key Binding | Function | Description |
|-------------|----------|-------------|
| `SPC m d b` | Toggle Breakpoint | Set/remove breakpoint at current line |
| `SPC m d d` | Start Debug | Start debugging session |
| `SPC m d l` | Debug Last | Repeat last debug configuration |
| `SPC m d r` | Debug Recent | Show recent debug configurations |
| `SPC m d s` | Restart Debug | Restart debugging session |
| `SPC m d q` | Quit Debug | Stop debugging session |
| `SPC m d n` | Next Line | Step over (next line) |
| `SPC m d i` | Step In | Step into function |
| `SPC m d o` | Step Out | Step out of function |
| `SPC m d c` | Continue | Continue execution |
| `SPC m d v` | Inspect Variable | Inspect variable at point |
| `SPC m d w` | Add Watch | Add variable to watch list |

## Debug Workflow

1. **Set breakpoints**: Navigate to line and press `SPC m d b`
2. **Start debugging**: Press `SPC m d d` and select "C++ Debug (lldb)"
3. **Navigate**: Use `SPC m d n/i/o/c` to step through code
4. **Inspect**: Use `SPC m d v` to inspect variables
5. **Watch**: Use `SPC m d w` to add variables to watch window

## DAP UI Windows

- **Locals**: Shows local variables and their values
- **Breakpoints**: Lists all breakpoints
- **Stack**: Shows call stack
- **REPL**: Interactive debugging console

## Requirements

- CMakeLists.txt with `CMAKE_EXPORT_COMPILE_COMMANDS ON`
- Debug symbols: `CMAKE_BUILD_TYPE Debug` and `-g` flag
- Symlink: `ln -sf build/compile_commands.json .` in project root

## Troubleshooting

- If LSP doesn't work: Ensure `compile_commands.json` symlink exists
- If debugging fails: Check that binary is built with debug symbols (`-g`)
- If breakpoints don't hit: Ensure you're debugging the debug build, not release
- For CMake issues: Delete `build/` directory and recreate
