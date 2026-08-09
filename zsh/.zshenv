# .zshenv — sourced by EVERY zsh (interactive, login, and non-interactive script
# shells alike). Only PATH entries that must survive a non-interactive shell belong
# here; everything else stays in .zshrc.
#
# Why this file exists (2026-08-09): agent tooling from ~/m/agent-os is invoked by
# bare name (`maw hey …`, `memory-index-gen --write`) from contexts that do NOT
# source .zshrc — an AI agent's tool shell, a `zsh -c` one-liner, a launchd job.
# Putting the PATH entry only in .zshrc made those contexts fail with
# "command not found" while an interactive shell found it fine.
#
# Two dirs on purpose:
#   ~/.agent-shared/bin  engine-neutral tier — maw, memory-index-gen,
#                        feedback-index-gen — usable by Claude and Codex alike
#   ~/.claude/bin        Claude-only tools that parse Claude's own transcript
#                        format: session-facts, daily-trend, memory-read-report,
#                        agent-dispatch-stats, eval-probe-score
# Guarded so repeated sourcing (nested shells) cannot duplicate entries.

for _agent_os_bin in "$HOME/.agent-shared/bin" "$HOME/.claude/bin"; do
  case ":$PATH:" in
    *":$_agent_os_bin:"*) ;;
    *) [ -d "$_agent_os_bin" ] && PATH="$_agent_os_bin:$PATH" ;;
  esac
done
unset _agent_os_bin
export PATH
