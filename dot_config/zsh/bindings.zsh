bindkey -r "^P"
bindkey -r "^N"
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
for key ('^[[A' '^P') bindkey ${key} history-substring-search-up
for key ('^[[B' '^N') bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
