#!/usr/bin/env bash
# Append agent task icon to tokyonight window-status-format.
# Called after TPM/plugins have loaded so the tokyonight format is already set.
set -euo pipefail

ICON='#(~/.config/tmux/tmux-status/window_task_icon.sh "#{window_id}" "#{@unread}" "#{@watching}" "#{@watch_failed}" "#{window_active}")'

current=$(tmux show -gwv window-status-format 2>/dev/null || true)
if [[ -n "$current" ]] && [[ "$current" != *"window_task_icon"* ]]; then
  tmux set -gw window-status-format "${current}${ICON} "
fi

current_focus=$(tmux show -gwv window-status-current-format 2>/dev/null || true)
if [[ -n "$current_focus" ]] && [[ "$current_focus" != *"window_task_icon"* ]]; then
  tmux set -gw window-status-current-format "${current_focus}${ICON} "
fi
