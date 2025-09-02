#!/bin/bash

# Quick Restoration Script
# For when you just need to restore configuration to existing Doom Emacs

set -e

echo "🔄 Restoring Doom Emacs configuration..."
echo "========================================"

# Backup existing configuration
if [ -d ~/.config/doom ]; then
    echo "⚠️  Backing up existing configuration..."
    mv ~/.config/doom ~/.config/doom.backup.$(date +%Y%m%d_%H%M%S)
fi

# Restore configuration
echo "📂 Restoring Doom configuration..."
mkdir -p ~/.config
cp -r doom-config ~/.config/doom

# Restore templates
echo "📋 Restoring project templates..."
mkdir -p ~/Templates
cp -r templates/* ~/Templates/
chmod +x ~/Templates/cpp-cmake-project/create_project.sh

# Sync Doom
echo "🔄 Syncing Doom configuration..."
~/.emacs.d/bin/doom sync

echo ""
echo "✅ Configuration restored successfully!"
echo ""
echo "🚀 Next steps:"
echo "  1. Restart Emacs if it's running"
echo "  2. Run 'doom doctor' to check for issues"
echo "  3. Test with: newcpp TestProject ~/Projects"
