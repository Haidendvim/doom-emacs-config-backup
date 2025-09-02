#!/bin/bash

# Script to create a new C++ CMake project
# Usage: ./create_project.sh <project_name> [destination_dir]

if [ $# -eq 0 ]; then
    echo "Usage: $0 <project_name> [destination_dir]"
    echo "Example: $0 MyAwesomeProject ~/Projects"
    exit 1
fi

PROJECT_NAME=$1
DEST_DIR=${2:-$(pwd)}
PROJECT_DIR="$DEST_DIR/$PROJECT_NAME"

echo "Creating C++ project: $PROJECT_NAME"
echo "Location: $PROJECT_DIR"

# Create directory structure
mkdir -p "$PROJECT_DIR"/{src,include,build,tests}

# Copy and customize CMakeLists.txt
sed "s/MyProject/$PROJECT_NAME/g" "$(dirname "$0")/CMakeLists.txt" > "$PROJECT_DIR/CMakeLists.txt"

# Create main.cpp
cat > "$PROJECT_DIR/src/main.cpp" << EOF
#include <iostream>

int main(int argc, char* argv[]) {
    std::cout << "Hello, World from $PROJECT_NAME!" << std::endl;
    
    // Debug breakpoint example
    int x = 42;
    int y = x * 2;
    
    std::cout << "x = " << x << ", y = " << y << std::endl;
    
    return 0;
}
EOF

# Create .gitignore
cat > "$PROJECT_DIR/.gitignore" << EOF
# Build directories
build/
cmake-build-*/

# Generated files
compile_commands.json

# IDE files
.vscode/
.idea/

# MacOS
.DS_Store

# Backup files
*~
*.swp
*.swo
EOF

# Create README
cat > "$PROJECT_DIR/README.md" << EOF
# $PROJECT_NAME

A C++ project with CMake build system.

## Building

\`\`\`bash
mkdir build && cd build
cmake ..
make
\`\`\`

## Running

\`\`\`bash
./bin/$PROJECT_NAME
\`\`\`

## Debugging in Doom Emacs

1. Open the project in Doom Emacs
2. Set breakpoints with \`SPC m d b\`
3. Start debugging with \`SPC m d d\`
EOF

# Initialize git repository
cd "$PROJECT_DIR"
git init
git add .
git commit -m "Initial commit"

echo "✅ Project created successfully!"
echo "📁 Location: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "1. cd $PROJECT_DIR"
echo "2. mkdir build && cd build"
echo "3. cmake .. && make"
echo "4. cd .. && ln -sf build/compile_commands.json .  # For LSP"
echo "5. Open in Doom Emacs and start debugging!"
echo ""
echo "💡 Tip: Use the project creation alias:"
echo "   alias newcpp='~/Templates/cpp-cmake-project/create_project.sh'"
