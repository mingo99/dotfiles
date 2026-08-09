# zsh 配置（ZDOTDIR 模块化）

模块化 zsh 配置，参考 [radleylewis/zsh](https://github.com/radleylewis/zsh) 组织方式。整个配置自包含在本目录，复制到新机器即可迁移。

## ⚠️ 前提：必须配置 /etc/zshenv

zsh 通过环境变量 `ZDOTDIR` 决定启动文件（`.zshenv` / `.zprofile` / `.zshrc`）的位置。该变量**必须在 zsh 启动前就存在于环境中**——无法在配置文件内部自举（读取 `.zshenv` 时 ZDOTDIR 已被确定）。

因此需要把以下内容写入 `/etc/zshenv`（所有用户的 zsh 都会先读它；带存在性守卫，只对本机存在 `~/.config/zsh` 的用户生效）：

```zsh
# ZDOTDIR: user zsh config in ~/.config/zsh
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
```

创建命令：

```bash
sudo tee /etc/zshenv >/dev/null <<'EOF'
# ZDOTDIR: user zsh config in ~/.config/zsh
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -d "$XDG_CONFIG_HOME/zsh" ]]; then
    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
EOF
```

- 该文件覆盖登录 shell、ssh、cron 及 GUI 终端的所有场景
- **执行后需新开终端窗口生效**（已打开的终端不会重读启动文件）
- 不想动 `/etc/zshenv` 的替代方案：`launchctl setenv ZDOTDIR "$HOME/.config/zsh"`，但仅覆盖重启后的 GUI 终端，ssh/cron 不生效，且重启后需重新设置

## 目录结构

```
.config/zsh/
├── .zshenv       # 所有 zsh 调用（含非交互）：XDG 变量、EDITOR、LS_COLORS、STARSHIP_CONFIG、PATH
├── .zprofile     # 仅登录 shell：Homebrew 环境（brew shellenv）
├── .zshrc        # 仅交互 shell：历史、setopt、补全（compinit）、模块加载、fnm/zoxide/proxy
├── plugins.zsh   # 插件安装与加载（首次启动自动 git clone 到 plugins/，zplugin-update 更新）
├── bindings.zsh  # history-substring-search 键位绑定
├── aliases.zsh   # ls/ll/la/lt/lg 别名
├── fzf.zsh       # fzf 集成（fd 路径补全、预览、快捷键）
├── prompt.zsh    # starship 初始化
└── README.md

> WSL 专属配置（LD_LIBRARY_PATH、Windows PATH、TERM、tmux/pfetch/procs 别名）直接在 `.zshrc` 内联，运行时检测 `uname -r`，非 WSL 环境不生效。

## 独立于本目录的文件

- `~/.proxyrc` — 代理配置，存在则加载
- `~/.secretsrc` — API 密钥（chmod 600），存在则加载；**不纳入本目录、不进入 dotfiles 仓库**
```

## 插件

首次启动交互 shell 时自动克隆到 `plugins/`，之后用 `zplugin-update` 拉取更新：

- zsh-autosuggestions — 内联命令建议
- zsh-history-substring-search — 按前缀搜索历史（↑↓ / vi 模式 j/k）
- zsh-vi-mode — 完整 vi 编辑模型（操作符、可视模式、/ 历史搜索）
- fast-syntax-highlighting — 语法高亮

## 依赖（brew）

`zsh` `starship` `fzf` `fd` `bat` `lsd` `zoxide` `fnm` `vivid` `nvim` `ripgrep`

## 注意事项

- 历史文件：`$XDG_STATE_HOME/zsh/history`（即 `~/.local/state/zsh/history`）
- 补全缓存：`$XDG_CACHE_HOME/zsh/zcompdump`
- `secrets.zsh` 含明文 API key，权限必须保持 600
- 新机器迁移：复制本目录 + 配置 `/etc/zshenv` + 安装依赖即可
