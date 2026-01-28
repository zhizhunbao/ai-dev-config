#!/bin/bash
#
# Initialize a new project with AI development configuration
#
# Usage:
#   ./init-project.sh <project-path> [platform]
#
# Arguments:
#   project-path  - Path to the target project directory
#   platform      - AI platform to configure (claude|cursor|windsurf|kiro|all)
#                   Default: all
#
# Example:
#   ./init-project.sh ~/projects/my-app all
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_ROOT="$(dirname "$SCRIPT_DIR")"
SHARED_SOURCE="$CONFIG_ROOT/.shared"

# Arguments
PROJECT_PATH="$1"
PLATFORM="${2:-all}"

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  AI Dev Config - Project Initializer  ${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# Validate arguments
if [ -z "$PROJECT_PATH" ]; then
    echo -e "${RED}Error: Project path is required${NC}"
    echo "Usage: $0 <project-path> [platform]"
    exit 1
fi

# Validate source exists
if [ ! -d "$SHARED_SOURCE" ]; then
    echo -e "${RED}Error: .shared directory not found at $SHARED_SOURCE${NC}"
    exit 1
fi

# Validate platform
case "$PLATFORM" in
    claude|cursor|windsurf|kiro|all)
        ;;
    *)
        echo -e "${RED}Error: Invalid platform '$PLATFORM'${NC}"
        echo "Valid options: claude, cursor, windsurf, kiro, all"
        exit 1
        ;;
esac

# Create project directory if not exists
if [ ! -d "$PROJECT_PATH" ]; then
    echo -e "${YELLOW}Creating project directory: $PROJECT_PATH${NC}"
    mkdir -p "$PROJECT_PATH"
fi

# Convert to absolute path
PROJECT_PATH="$(cd "$PROJECT_PATH" && pwd)"

# Copy .shared directory
echo -e "${GREEN}Copying .shared directory...${NC}"
DEST_SHARED="$PROJECT_PATH/.shared"
if [ -d "$DEST_SHARED" ]; then
    echo -e "  ${YELLOW}.shared already exists, skipping...${NC}"
else
    cp -r "$SHARED_SOURCE" "$DEST_SHARED"
    echo -e "  ${GREEN}Done!${NC}"
fi

# Create .agent directory with symlinks
echo -e "${GREEN}Creating .agent directory with symlinks...${NC}"
AGENT_DIR="$PROJECT_PATH/.agent"
mkdir -p "$AGENT_DIR"

for dir in skills agents workflows templates; do
    LINK_PATH="$AGENT_DIR/$dir"
    TARGET_PATH="../.shared/$dir"

    if [ -L "$LINK_PATH" ] || [ -d "$LINK_PATH" ]; then
        echo -e "  ${YELLOW}$dir link already exists, skipping...${NC}"
    else
        ln -s "$TARGET_PATH" "$LINK_PATH"
        echo -e "  ${GREEN}Created symlink: $dir -> .shared/$dir${NC}"
    fi
done

# Create platform-specific configurations
echo -e "${GREEN}Creating platform configurations...${NC}"
RULES_SOURCE="$DEST_SHARED/rules.md"

create_platform_config() {
    local filename="$1"
    local platform_name="$2"
    local filepath="$PROJECT_PATH/$filename"

    if [ -f "$filepath" ]; then
        echo -e "  ${YELLOW}$filename already exists, skipping...${NC}"
    else
        # Create parent directory if needed
        mkdir -p "$(dirname "$filepath")"
        cp "$RULES_SOURCE" "$filepath"
        echo -e "  ${GREEN}Created $filename for $platform_name${NC}"
    fi
}

case "$PLATFORM" in
    claude)
        create_platform_config "CLAUDE.md" "Claude Code"
        ;;
    cursor)
        create_platform_config ".cursorrules" "Cursor"
        ;;
    windsurf)
        create_platform_config ".windsurfrules" "Windsurf"
        ;;
    kiro)
        create_platform_config ".kiro/steering/project.md" "Kiro"
        ;;
    all)
        create_platform_config "CLAUDE.md" "Claude Code"
        create_platform_config ".cursorrules" "Cursor"
        create_platform_config ".windsurfrules" "Windsurf"
        create_platform_config ".kiro/steering/project.md" "Kiro"
        ;;
esac

# Create/update .gitignore
echo -e "${GREEN}Updating .gitignore...${NC}"
GITIGNORE_PATH="$PROJECT_PATH/.gitignore"
GITIGNORE_ADDITIONS="
# AI Dev Config
.dev-state.yaml
*.local.yaml"

if [ -f "$GITIGNORE_PATH" ]; then
    if ! grep -q "AI Dev Config" "$GITIGNORE_PATH"; then
        echo "$GITIGNORE_ADDITIONS" >> "$GITIGNORE_PATH"
        echo -e "  ${GREEN}Added AI Dev Config entries to .gitignore${NC}"
    else
        echo -e "  ${YELLOW}.gitignore already configured, skipping...${NC}"
    fi
else
    echo "$GITIGNORE_ADDITIONS" > "$GITIGNORE_PATH"
    echo -e "  ${GREEN}Created .gitignore${NC}"
fi

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  Initialization Complete!              ${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "Project structure:"
echo -e "  $PROJECT_PATH"
echo -e "  ├── .shared/          (skills, agents, workflows)"
echo -e "  ├── .agent/           (symlinks to .shared)"
[ "$PLATFORM" = "all" ] || [ "$PLATFORM" = "claude" ] && echo -e "  ├── CLAUDE.md         (Claude Code config)"
[ "$PLATFORM" = "all" ] || [ "$PLATFORM" = "cursor" ] && echo -e "  ├── .cursorrules      (Cursor config)"
[ "$PLATFORM" = "all" ] || [ "$PLATFORM" = "windsurf" ] && echo -e "  ├── .windsurfrules    (Windsurf config)"
[ "$PLATFORM" = "all" ] || [ "$PLATFORM" = "kiro" ] && echo -e "  └── .kiro/            (Kiro config)"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "  1. cd $PROJECT_PATH"
echo -e "  2. Start development with /full-dev command"
echo ""
