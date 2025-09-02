#!/bin/bash

# Doom Emacs Configuration - Complete Installation Script
# For disaster recovery and fresh system setup

set -e  # Exit on any error

echo "🚀 Starting Doom Emacs complete installation..."
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}📋 Step $1:${NC} $2"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is designed for macOS. Exiting."
    exit 1
fi

print_step "1" "Checking system requirements"

# Check for Xcode Command Line Tools
if ! command -v xcode-select &> /dev/null; then
    print_warning "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
    echo "Please run this script again after Xcode Command Line Tools installation completes."
    exit 1
fi
print_success "Xcode Command Line Tools found"

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for ARM Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi
print_success "Homebrew available"

print_step "2" "Installing core dependencies"

# Install required packages
brew_packages=(
    "emacs"
    "git" 
    "ripgrep"
    "fd"
    "cmake"
    "libtool"
    "llvm"  # Includes clangd and lldb-dap
)

for package in "${brew_packages[@]}"; do
    if brew list "$package" &>/dev/null; then
        print_success "$package already installed"
    else
        echo "Installing $package..."
        brew install "$package"
        print_success "$package installed"
    fi
done

print_step "3" "Setting up PATH configurations"

# Backup existing zshrc
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
    print_success "Backed up existing ~/.zshrc"
fi

# Add necessary PATH configurations
echo "# Doom Emacs Configuration" >> ~/.zshrc
echo 'export PATH="$HOME/.emacs.d/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="/opt/homebrew/opt/libtool/libexec/gnubin:$PATH"' >> ~/.zshrc

# Add shell functions
cat >> ~/.zshrc << 'SHELL_EOF'

# C++ CMake project functions
alias newcpp="~/Templates/cpp-cmake-project/create_project.sh"

buildcpp() {
    if [ ! -f "CMakeLists.txt" ]; then
        echo "❌ No CMakeLists.txt found in current directory"
        return 1
    fi
    
    echo "🔨 Building C++ project..."
    mkdir -p build && cd build
    cmake .. && make
    cd ..
    
    # Create symlink for LSP if it doesn't exist
    if [ ! -L "compile_commands.json" ]; then
        ln -sf build/compile_commands.json .
        echo "🔗 Created compile_commands.json symlink for LSP"
    fi
    
    echo "✅ Build complete!"
}

rebuildcpp() {
    if [ ! -f "CMakeLists.txt" ]; then
        echo "❌ No CMakeLists.txt found in current directory"
        return 1
    fi
    
    echo "🧹 Cleaning and rebuilding..."
    rm -rf build
    buildcpp
}
SHELL_EOF

print_success "Shell configuration updated"

print_step "4" "Installing Doom Emacs"

# Remove any existing Emacs configuration
if [ -d ~/.emacs.d ]; then
    print_warning "Existing ~/.emacs.d found. Backing up..."
    mv ~/.emacs.d ~/.emacs.d.backup.$(date +%Y%m%d_%H%M%S)
fi

if [ -d ~/.config/doom ]; then
    print_warning "Existing ~/.config/doom found. Backing up..."
    mv ~/.config/doom ~/.config/doom.backup.$(date +%Y%m%d_%H%M%S)
fi

# Clone Doom Emacs
echo "Cloning Doom Emacs..."
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
print_success "Doom Emacs cloned"

# Install Doom
echo "Installing Doom Emacs (this may take a few minutes)..."
~/.emacs.d/bin/doom install --force
print_success "Doom Emacs installed"

print_step "5" "Restoring configuration"

# Restore Doom configuration
mkdir -p ~/.config
cp -r doom-config ~/.config/doom
print_success "Doom configuration restored"

# Restore templates
mkdir -p ~/Templates
cp -r templates/* ~/Templates/
chmod +x ~/Templates/cpp-cmake-project/create_project.sh
print_success "Project templates restored"

print_step "6" "Syncing Doom configuration"

# Sync Doom with restored configuration
~/.emacs.d/bin/doom sync
print_success "Doom configuration synced"

print_step "7" "Running diagnostics"

# Run Doom doctor to check for issues
~/.emacs.d/bin/doom doctor

print_step "8" "Creating test project"

# Create a test project to verify everything works
mkdir -p ~/Projects
cd ~/Projects
if [ ! -d "TestDoomSetup" ]; then
    ~/Templates/cpp-cmake-project/create_project.sh TestDoomSetup .
    cd TestDoomSetup
    mkdir -p build && cd build && cmake .. && make
    cd .. && ln -sf build/compile_commands.json .
    print_success "Test project created and built"
else
    print_warning "Test project already exists"
fi

echo ""
echo "=================================================="
echo -e "${GREEN}🎉 Installation Complete!${NC}"
echo "=================================================="
echo ""
echo "📋 What's Ready:"
echo "  ✅ Doom Emacs 3.0.0-pre with Emacs 30.2"
echo "  ✅ C/C++ development with clangd LSP"
echo "  ✅ Visual debugging with LLDB/DAP"
echo "  ✅ CMake integration and templates"
echo "  ✅ Shell functions and aliases"
echo "  ✅ Test project ready for testing"
echo ""
echo "🚀 Next Steps:"
echo "  1. Restart your terminal (to load new PATH)"
echo "  2. Test with: cd ~/Projects/TestDoomSetup && emacs ."
echo "  3. Install icon fonts: M-x nerd-icons-install-fonts (in Emacs)"
echo "  4. Start coding with 'newcpp ProjectName ~/Projects'"
echo ""
echo "📚 Documentation:"
echo "  - Key bindings: See README.md in this repository"
echo "  - Debugging guide: templates/cpp-cmake-project/DEBUGGING_GUIDE.md"
echo "  - Doom help: SPC h d h (in Emacs)"
echo ""
echo "🎯 Quick Test:"
echo "  newcpp HelloWorld ~/Projects"
echo "  cd ~/Projects/HelloWorld && buildcpp && emacs ."
