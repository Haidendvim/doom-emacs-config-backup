# Configuration Manifest

## System Information
- **Platform**: macOS ARM (Apple Silicon)
- **Created**: $(date +%Y-%m-%d\ %H:%M:%S)
- **Backup Location**: ~/doom-emacs-config-backup

## Software Versions
- **Emacs**: 30.2
- **Doom Emacs**: 3.0.0-pre
- **clangd**: $(clangd --version 2>/dev/null | head -n1 || echo "Version check failed")
- **CMake**: $(cmake --version | head -n1)
- **LLDB**: $(lldb --version | head -n1)

## Enabled Doom Modules

### :completion
- `(corfu +orderless)` - Modern completion framework
- `vertico` - Vertical completion UI

### :ui
- `doom` - Doom themes and aesthetics
- `doom-dashboard` - Startup dashboard
- `hl-todo` - Highlight TODO keywords
- `modeline` - Custom modeline
- `treemacs` - File tree sidebar
- `workspaces` - Workspace management

### :editor
- `(evil +everywhere)` - Vim emulation
- `file-templates` - File templates
- `fold` - Code folding
- `snippets` - Code snippets

### :tools
- `(debugger +lsp)` - DAP debugging with LSP
- `lsp` - Language Server Protocol
- `magit` - Git interface
- `make` - Build system integration
- `tree-sitter` - Syntax parsing

### :lang
- `(cc +lsp)` - C/C++ with LSP support
- `csharp` - C# development
- `emacs-lisp` - Emacs Lisp development
- `markdown` - Markdown editing
- `org` - Org mode
- `sh` - Shell script editing
- `web` - Web development

### :term
- `vterm` - Terminal emulation

## Custom Configuration

### C/C++ Development
- **LSP Server**: clangd with clang-tidy integration
- **Debug Adapter**: lldb-dap for native debugging
- **Build System**: CMake with export compile commands
- **Code Style**: Linux style with 4-space indentation

### Key Bindings Added
- `SPC m d *` - Complete debugging suite
- Custom local leader bindings for C/C++ mode

### Shell Functions
- `newcpp` - Create new C++ CMake project
- `buildcpp` - Build current project with LSP support
- `rebuildcpp` - Clean and rebuild project

## File Structure
```
doom-emacs-config-backup/
├── README.md                    # Complete documentation
├── MANIFEST.md                 # This file
├── install.sh                  # Full installation script
├── restore.sh                  # Quick config restoration
├── doom-config/                # Doom Emacs configuration
│   ├── init.el                # Module configuration
│   ├── config.el              # Custom configuration
│   └── packages.el            # Package definitions
├── templates/                  # Project templates
│   └── cpp-cmake-project/     # C++ project template
│       ├── CMakeLists.txt     # CMake template
│       ├── create_project.sh  # Project creation script
│       └── DEBUGGING_GUIDE.md # Debugging documentation
└── zshrc-backup               # Shell configuration backup
```

## Restore Commands

### Full Installation (Clean System)
```bash
git clone https://github.com/Haidendvim/doom-emacs-config-backup.git
cd doom-emacs-config-backup
./install.sh
```

### Quick Config Restore (Existing Doom)
```bash
./restore.sh
```

### Manual Restoration
See README.md for step-by-step manual instructions.
