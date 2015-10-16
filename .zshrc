######################################################
# 全般設定
######################################################
# 環境変数
export LANG=ja_JP.UTF-8
export LC_CTYPE='ja_JP.UTF-8'

# 色を使用できるように
autoload -Uz colors
colors

# キーバインドをemacs風に
bindkey -e

# ヒストリーの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# プロンプトの設定
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default

# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# 重複パスを登録しない
typeset -U path cdpath fpath manpath
# パスを通す
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share:$PATH
PATH=$PATH:/user/local/brew
export PATH



######################################################
# 補完
######################################################
# 補完機能を有効
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'



######################################################
# vcs_info
######################################################
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"



######################################################
# オプション
######################################################
# 日本語ファイル名を表示可能へ
setopt print_eight_bit

# beep を無効
setopt no_beep

# フローコントロールを無効
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# cd したら自動的にpushd
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# = の後はパス名として補完
setopt magic_equal_subst

# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除
setopt hist_reduce_blanks

# 補完候補が複数あるときに自動的に一覧表示
setopt auto_menu

# 高機能なワイルドカード展開を使用
setopt extended_glob


######################################################
# キーバインド
######################################################
# ^R で履歴検索をするときに * でワイルドカードを使用できるように
bindkey '^R' history-incremental-pattern-search-backward



######################################################
# エイリアス
######################################################
# ファイル表示関連
alias ll='ls -l'
alias la='ls -la'
alias cla='clear && ls -la'

# サブディレクトリまで作成
alias mkdir='mkdir -p'

# Git関連
alias gst='git status'
alias glog='git log'
alias gpull='git pull'

# sudo の後のコマンドでエイリアスを有効
alias sudo='sudo '

# gulp
alias g='gulp'
alias gw='gulp watch'
alias gs='gulp server'

# github へ移動
alias idd='cd ~/github/idd-gp'

# ミスタイプ補正
alias cleawr='clear'

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピー
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi



######################################################
# OS別設定
######################################################
case ${OSTYPE} in
    darwin*)
        # Mac
        export CLICOLOR=1
        export PATH="$PATH:$HOME/.anyenv/bin"
        eval "$(anyenv init -)"
        ;;
esac

# vim:set ft=zsh:
