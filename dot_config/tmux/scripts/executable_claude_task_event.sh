#!/usr/bin/env bash
# Bridge Claude Code lifecycle hooks to tmux pane/window state.
set -euo pipefail

event="${1:-}"
input="$(cat)"
pane_id="${TMUX_PANE:-}"

[[ -n "$pane_id" ]] || exit 0

window_id="$(tmux display-message -p -t "$pane_id" '#{window_id}' 2>/dev/null || true)"
[[ -n "$window_id" ]] || exit 0

is_active_pane() {
  tmux list-clients -F '#{pane_id}' 2>/dev/null | grep -F -m1 -x "$pane_id" >/dev/null
}

set_agent_state() {
  local status="$1"
  local summary="$2"
  local now
  now="$(date +%s)"
  tmux set-option -p -t "$pane_id" @agent_status "$status" 2>/dev/null || true
  tmux set-option -p -t "$pane_id" @agent_summary "$summary" 2>/dev/null || true
  tmux set-option -p -t "$pane_id" @agent_updated_at "$now" 2>/dev/null || true
}

mark_unread() {
  tmux set-option -p -t "$pane_id" @agent_unread 1 2>/dev/null || true
  tmux set-option -w -t "$window_id" @unread 1 2>/dev/null || true
  tmux refresh-client -S 2>/dev/null || true
}

summary=""
case "$event" in
  start)
    summary="$(jq -r '.prompt // "Claude task"' <<<"$input" 2>/dev/null | tr '\n' ' ' | cut -c1-240)"
    [[ -n "$summary" ]] || summary="Claude task"
    set_agent_state running "$summary"
    tmux set-option -p -u -t "$pane_id" @agent_unread 2>/dev/null || true
    tmux set-option -p -u -t "$pane_id" @op_question_pending 2>/dev/null || true
    tmux refresh-client -S 2>/dev/null || true
    ;;
  stop)
    # A Stop event is the completion of Claude's current turn; the CLI itself stays interactive.
    summary="$(jq -r '.last_assistant_message // "Claude task completed"' <<<"$input" 2>/dev/null | tr '\n' ' ' | cut -c1-240)"
    [[ -n "$summary" ]] || summary="Claude task completed"
    set_agent_state done "$summary"
    tmux set-option -p -u -t "$pane_id" @op_question_pending 2>/dev/null || true
    if ! is_active_pane; then
      mark_unread
    fi
    ;;
  notify)
    summary="$(jq -r '.message // .prompt // "Waiting for input"' <<<"$input" 2>/dev/null | tr '\n' ' ' | cut -c1-240)"
    [[ -n "$summary" ]] || summary="Waiting for input"
    set_agent_state question "$summary"
    if ! is_active_pane; then
      tmux set-option -p -t "$pane_id" @op_question_pending 1 2>/dev/null || true
      mark_unread
    fi
    ;;
  *)
    exit 0
    ;;
esac

exit 0
