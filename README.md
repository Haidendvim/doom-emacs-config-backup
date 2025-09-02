# Doom Emacs Configuration - Disaster Recovery Backup

Complete Doom Emacs setup for macOS ARM with C/C++ development and debugging support.

## 📋 What's Included

- **Doom Emacs configuration** (`doom-config/`)
- **C++ CMake project templates** (`templates/`)
- **Shell configuration** (`zshrc-backup`)
- **Automated installation scripts** (`install.sh`, `restore.sh`)
- **Debugging setup** with LLDB and DAP integration
- **Complete disaster recovery** instructions

## 🎯 Features Configured

### Core Doom Modules
- **Completion**: `vertico` + `corfu` with orderless matching
- **UI**: Doom themes, modeline, treemacs, workspaces
- **Editor**: Evil mode, snippets, file templates, folding
- **Terminal**: vterm (best terminal emulation)
- **Version Control**: Magit with diff highlighting

### Development Setup
- **C/C++ Language Support**: 
  - LSP via clangd with clang-tidy integration
  - Tree-sitter syntax highlighting
  - Intelligent code completion and navigation
- **Debugging**: 
  - DAP (Debug Adapter Protocol) with LLDB
  - Visual debugging with breakpoints, watches, stack traces
  - Native macOS ARM debugging support
- **Build System**: 
  - CMake integration with automatic compile_commands.json
  - Project templates for instant setup
  - Build automation functions

### Additional Languages
- **Shell scripting** (bash/zsh)
- **Markdown** with live preview
- **Web development** (HTML/CSS/JS)
- **Emacs Lisp** development
- **Org mode** for documentation

## 🔧 Prerequisites for Fresh Install

### Required Software (Auto-installed)
```bash
# Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core development tools
brew install emacs git ripgrep fd cmake libtool
```

### System Requirements
- **macOS**: 10.15+ (optimized for ARM Macs)
- **Xcode Command Line Tools**: `xcode-select --install`
- **Homebrew**: Latest version
- **Git**: For cloning repositories
- **Internet**: For downloading packages

## 🚀 Quick Restore (Automated)

### One-Command Restoration
```bash
git clone https://github.com/Haidendvim/doom-emacs-config-backup.git
cd doom-emacs-config-backup
./install.sh
```

This will:
1. Install all required dependencies via Homebrew
2. Install Emacs and Doom Emacs
3. Restore your exact configuration
4. Set up C++ development environment
5. Configure shell functions and aliases

## 📖 Manual Restoration Steps

### 1. Install Core Dependencies
```bash
# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install emacs git ripgrep fd cmake libtool

# Install LLVM for debugging (includes clangd and lldb-dap)
brew install llvm
```

### 2. Install Doom Emacs
```bash
# Clone Doom Emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d

# Install Doom
~/.emacs.d/bin/doom install
```

### 3. Restore Configuration
```bash
# Restore Doom config
cp -r doom-config/* ~/.config/doom/

# Restore templates
cp -r templates/* ~/Templates/

# Update shell configuration (review before applying!)
cat zshrc-backup >> ~/.zshrc
```

### 4. Apply Configuration
```bash
# Sync Doom with new configuration
doom sync

# Verify installation
doom doctor
```

## 🛠️ Development Workflow

### Creating New C++ Projects
```bash
# Create new project (uses template)
newcpp MyAwesomeProject ~/Projects

# Navigate and build
cd ~/Projects/MyAwesomeProject
buildcpp  # Builds with LSP support automatically

# Open in Doom Emacs
emacs .
```

### Debugging Workflow
1. **Set breakpoints**: `SPC m d b` on desired lines
2. **Start debugging**: `SPC m d d` → Select "C++ Debug (lldb)"
3. **Step through code**: 
   - `SPC m d n` - Next line (step over)
   - `SPC m d i` - Step into function
   - `SPC m d o` - Step out of function
   - `SPC m d c` - Continue execution
4. **Inspect variables**: `SPC m d v` on variable names
5. **Add watches**: `SPC m d w` for persistent variable monitoring

### Project Structure
```
MyProject/
├── CMakeLists.txt          # Build configuration
├── compile_commands.json   # LSP database (symlink)
├── src/
│   └── main.cpp           # Source files
├── include/               # Header files
├── build/                 # Build output (gitignored)
├── tests/                 # Unit tests
└── README.md             # Project documentation
```

## 🔑 Key Bindings Reference

### File Navigation
- `SPC f f` - Find file
- `SPC f r` - Recent files
- `SPC p p` - Switch projects
- `SPC p f` - Find file in project

### Code Navigation (LSP)
- `g d` - Go to definition
- `g r` - Find references
- `g i` - Go to implementation
- `SPC c a` - Code actions
- `SPC c r` - Rename symbol

### Debugging (DAP)
| Key | Action | Description |
|-----|--------|-------------|
| `SPC m d b` | Breakpoint | Toggle breakpoint |
| `SPC m d d` | Debug | Start debugging |
| `SPC m d n` | Next | Step over |
| `SPC m d i` | Step In | Step into function |
| `SPC m d o` | Step Out | Step out of function |
| `SPC m d c` | Continue | Continue execution |
| `SPC m d q` | Quit | Stop debugging |
| `SPC m d v` | Inspect | Inspect variable |

### Build & Make
- `SPC c c` - Compile project
- `SPC c C` - Recompile
- `SPC o t` - Open terminal (vterm)

## 🧪 Testing Your Setup

### Quick Test Project
```bash
# Create and test a project
newcpp TestSetup ~/Projects
cd ~/Projects/TestSetup
buildcpp
emacs .

# In Emacs:
# 1. Open src/main.cpp
# 2. Set breakpoint on line with "int x = 42" (SPC m d b)
# 3. Start debugging (SPC m d d)
# 4. Step through code (SPC m d n)
# 5. Inspect variables (SPC m d v)
```

## 📦 Package List

### Core Packages (Auto-installed)
- **LSP**: `lsp-mode`, `lsp-ui` for language server integration
- **DAP**: `dap-mode`, `dap-ui` for debugging
- **C/C++**: `cc-mode` with clangd integration
- **Completion**: `corfu`, `cape`, `vertico` for smart completion
- **Navigation**: `projectile`, `consult`, `embark`
- **Git**: `magit`, `diff-hl` for version control
- **Terminal**: `vterm` for integrated terminal

### Build Tools
- **CMake**: Project generation and building
- **clangd**: LSP server for C/C++
- **lldb-dap**: Debug adapter protocol for LLDB
- **clang-tidy**: Static analysis integration

## 🔄 Maintenance Commands

### Regular Maintenance
```bash
doom doctor           # Check for issues
doom upgrade          # Update Doom Emacs
doom sync             # Sync after config changes
doom clean            # Clean orphaned packages
```

### Shell Functions Available
```bash
newcpp ProjectName ~/Path    # Create new C++ project
buildcpp                     # Build current CMake project
rebuildcpp                   # Clean and rebuild project
```

## 🐛 Troubleshooting

### Common Issues

**LSP not working:**
```bash
# Ensure compile_commands.json exists
cd your_project && ls -la compile_commands.json
# If missing: buildcpp (rebuilds with LSP support)
```

**Debugging not starting:**
```bash
# Check debug binary exists and has symbols
file build/bin/YourProject
nm build/bin/YourProject | grep -i debug
```

**Packages not loading:**
```bash
doom sync            # Re-sync packages
doom doctor          # Check for issues
```

**Shell functions not available:**
```bash
source ~/.zshrc      # Reload shell config
```

## 💾 Backup Information

**Created**: `date +%Y-%m-%d`  
**Doom Version**: 3.0.0-pre  
**Emacs Version**: 30.2  
**Platform**: macOS ARM (Apple Silicon)  
**Dependencies**: All Homebrew-based for easy restoration

## 🔐 Security Notes

- All tools installed via official Homebrew formulas
- No custom compilation required
- Configuration uses standard Doom conventions
- Templates include proper .gitignore files
- No sensitive information stored in config

## 📚 Documentation Links

- [Doom Emacs Documentation](https://docs.doomemacs.org/)
- [DAP Mode Documentation](https://emacs-lsp.github.io/dap-mode/)
- [LSP Mode Documentation](https://emacs-lsp.github.io/lsp-mode/)
- [CMake Documentation](https://cmake.org/documentation/)
- [LLDB Documentation](https://lldb.llvm.org/)

---

*This configuration provides a complete, professional C/C++ development environment with modern tooling, debugging support, and disaster recovery capabilities.*
