#!/usr/bin/env python3
"""
AI Dev Config - Project Initializer

Initialize a new project with AI development configuration.
This script sets up .agent/ junctions pointing directly to the shared
.github/ai-dev-config/core/ directory - NO copying to project root.

Usage:
    python init-project.py <project_path> [--platform <platform>]
    
Examples:
    python init-project.py /path/to/project --platform all
    python init-project.py . --platform antigravity
"""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

# Supported platforms
PLATFORMS = ["claude", "cursor", "windsurf", "kiro", "codex", "copilot", "antigravity", "all"]

# Colors for terminal output
class Colors:
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    WHITE = '\033[97m'
    GRAY = '\033[90m'
    RESET = '\033[0m'

def print_color(message: str, color: str = Colors.RESET):
    """Print colored message to terminal."""
    print(f"{color}{message}{Colors.RESET}")

def create_junction(junction_path: Path, target_path: Path) -> bool:
    """Create a directory junction (Windows) or symlink (Unix)."""
    if junction_path.exists():
        return False
    
    if sys.platform == "win32":
        # Use cmd mklink /J for Windows junction
        result = subprocess.run(
            ["cmd", "/c", "mklink", "/J", str(junction_path), str(target_path)],
            capture_output=True,
            text=True
        )
        return result.returncode == 0
    else:
        # Use symlink for Unix
        try:
            junction_path.symlink_to(target_path, target_is_directory=True)
            return True
        except OSError:
            return False

def copy_template(adapters_source: Path, project_path: Path, platform: str, filename: str, template_name: str):
    """Copy a template file to the project."""
    file_path = project_path / filename
    template_path = adapters_source / platform / "templates" / template_name
    
    if file_path.exists():
        print_color(f"  {filename} already exists, skipping...", Colors.YELLOW)
        return
    
    if template_path.exists():
        # Create parent directory if needed
        file_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(template_path, file_path)
        print_color(f"  Created {filename}", Colors.GREEN)
    else:
        print_color(f"  Template not found for {platform}, skipping...", Colors.YELLOW)

def init_project(project_path: Path, platform: str, config_root: Path):
    """Initialize a project with AI dev configuration."""
    core_source = config_root / "core"
    adapters_source = config_root / "adapters"
    
    print_color("========================================", Colors.CYAN)
    print_color("  AI Dev Config - Project Initializer  ", Colors.CYAN)
    print_color("========================================", Colors.CYAN)
    print()
    
    # Validate source exists
    if not core_source.exists():
        print_color(f"Error: core directory not found at {core_source}", Colors.RED)
        sys.exit(1)
    
    # Create project directory if not exists
    if not project_path.exists():
        print_color(f"Creating project directory: {project_path}", Colors.YELLOW)
        project_path.mkdir(parents=True, exist_ok=True)
    
    # NOTE: We do NOT copy core to project root!
    # Instead, .agent/ junctions point directly to .github/ai-dev-config/core/
    
    # Create .agent directory with junctions pointing to shared config
    print_color("Creating .agent directory with junctions...", Colors.GREEN)
    agent_dir = project_path / ".agent"
    agent_dir.mkdir(parents=True, exist_ok=True)
    
    junctions = ["skills", "agents", "workflows", "templates"]
    for dir_name in junctions:
        junction_path = agent_dir / dir_name
        target_path = core_source / dir_name  # Points to .github/ai-dev-config/core/
        
        if junction_path.exists():
            print_color(f"  {dir_name} junction already exists, skipping...", Colors.YELLOW)
        else:
            if create_junction(junction_path, target_path):
                print_color(f"  Created junction: .agent/{dir_name} -> .github/ai-dev-config/core/{dir_name}", Colors.GREEN)
            else:
                print_color(f"  Failed to create junction for {dir_name}", Colors.RED)
    
    # Platform-specific configurations
    print_color("Creating platform configurations...", Colors.GREEN)
    
    if platform in ["claude", "all"]:
        copy_template(adapters_source, project_path, "claude", "CLAUDE.md", "base.md")
        # Create .claude directory
        claude_dir = project_path / ".claude"
        claude_dir.mkdir(parents=True, exist_ok=True)
        # Create skills junction pointing to shared config
        claude_skills = claude_dir / "skills"
        if not claude_skills.exists():
            if create_junction(claude_skills, core_source / "skills"):
                print_color("  Created .claude/skills junction", Colors.GREEN)
    
    if platform in ["cursor", "all"]:
        copy_template(adapters_source, project_path, "cursor", ".cursorrules", "base.md")
    
    if platform in ["windsurf", "all"]:
        copy_template(adapters_source, project_path, "windsurf", ".windsurfrules", "base.md")
    
    if platform in ["kiro", "all"]:
        copy_template(adapters_source, project_path, "kiro", ".kiro/steering/project.md", "project.md")
    
    if platform in ["codex", "all"]:
        copy_template(adapters_source, project_path, "codex", "AGENTS.md", "agents.md")
    
    if platform in ["copilot", "all"]:
        copy_template(adapters_source, project_path, "copilot", ".github/copilot-instructions.md", "instructions.md")
    
    if platform == "antigravity":
        print_color("  Antigravity configured via .agent/ junctions", Colors.GREEN)
    
    # Update .gitignore
    print_color("Updating .gitignore...", Colors.GREEN)
    gitignore_path = project_path / ".gitignore"
    gitignore_additions = """
# AI Dev Config
.dev-state.yaml
*.local.yaml
"""
    
    if gitignore_path.exists():
        content = gitignore_path.read_text(encoding="utf-8")
        if "AI Dev Config" not in content:
            with gitignore_path.open("a", encoding="utf-8") as f:
                f.write(gitignore_additions)
            print_color("  Added AI Dev Config entries to .gitignore", Colors.GREEN)
    else:
        gitignore_path.write_text(gitignore_additions.strip(), encoding="utf-8")
        print_color("  Created .gitignore", Colors.GREEN)
    
    # Print summary
    print()
    print_color("========================================", Colors.CYAN)
    print_color("  Initialization Complete!              ", Colors.CYAN)
    print_color("========================================", Colors.CYAN)
    print()
    print_color("Project structure:", Colors.WHITE)
    print_color(f"  {project_path}", Colors.GRAY)
    print_color("  +-- .agent/            (junctions to .github/ai-dev-config/core/)", Colors.GRAY)
    
    if platform in ["all", "claude"]:
        print_color("  +-- CLAUDE.md          (Claude Code config)", Colors.GRAY)
        print_color("  +-- .claude/skills/    (junction to shared skills)", Colors.GRAY)
    if platform in ["all", "cursor"]:
        print_color("  +-- .cursorrules       (Cursor config)", Colors.GRAY)
    if platform in ["all", "windsurf"]:
        print_color("  +-- .windsurfrules     (Windsurf config)", Colors.GRAY)
    if platform in ["all", "kiro"]:
        print_color("  +-- .kiro/             (Kiro config)", Colors.GRAY)
    if platform in ["all", "copilot"]:
        print_color("  \\-- .github/           (Copilot config)", Colors.GRAY)
    
    print()
    print_color("Shared config location:", Colors.WHITE)
    print_color(f"  {config_root}", Colors.GRAY)
    print()
    print_color("Next steps:", Colors.YELLOW)
    print_color(f"  1. cd {project_path}", Colors.WHITE)
    print_color("  2. Customize platform config files as needed", Colors.WHITE)
    print_color("  3. Start development with your AI assistant", Colors.WHITE)
    print()

def main():
    parser = argparse.ArgumentParser(
        description="Initialize a new project with AI development configuration"
    )
    parser.add_argument(
        "project_path",
        type=str,
        help="The path to the target project directory"
    )
    parser.add_argument(
        "--platform", "-p",
        type=str,
        choices=PLATFORMS,
        default="all",
        help="The AI platform to configure (default: all)"
    )
    
    args = parser.parse_args()
    
    # Resolve paths
    project_path = Path(args.project_path).resolve()
    script_dir = Path(__file__).parent
    config_root = script_dir.parent
    
    init_project(project_path, args.platform, config_root)

if __name__ == "__main__":
    main()
