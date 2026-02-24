# Global Claude Code Instructions

## Git Commands

Never use `git -C <path>` to specify the working directory. The session is already running in the correct directory, so just run git commands directly (e.g., `git log` instead of `git -C /path/to/repo log`). Using `-C` causes allowlist detection issues.
