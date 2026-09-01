# .zshenv — sourced by EVERY zsh (interactive, login, and non-interactive script
# shells alike). Only PATH entries that must survive a non-interactive shell belong
# here; everything else stays in .zshrc.
#
# Why this file exists (2026-08-09): agent tooling from ~/agent-os is invoked by
# bare name (`maw hey …`, `memory-index-gen --write`) from contexts that do NOT
# source .zshrc — an AI agent's tool shell, a `zsh -c` one-liner, a launchd job.
# Putting the PATH entry only in .zshrc made those contexts fail with
# "command not found" while an interactive shell found it fine.
#
# Two repo dirs on purpose:
#   ~/agent-os/shared/symlink/bin  engine-neutral tier — maw, memory-index-gen,
#                        feedback-index-gen — usable by Claude and Codex alike
#   ~/agent-os/claude/symlink/bin
#                        Claude-only tools that parse Claude's own transcript
#                        format: session-facts, daily-trend, memory-read-report,
#                        agent-dispatch-stats, eval-probe-score
# Guarded so repeated sourcing (nested shells) cannot duplicate entries.

for _agent_os_bin in "$HOME/agent-os/shared/symlink/bin" "$HOME/agent-os/claude/symlink/bin"; do
  case ":$PATH:" in
    *":$_agent_os_bin:"*) ;;
    *) [ -d "$_agent_os_bin" ] && PATH="$_agent_os_bin:$PATH" ;;
  esac
done
unset _agent_os_bin
export PATH
