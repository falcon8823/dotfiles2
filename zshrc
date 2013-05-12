###############################################
# キーバインド                                #
###############################################
# viライクキーバインド
#bindkey -v
# Emacsライクキーバインド
#bindkey -e

###############################################
# 補完関係                                    #
###############################################
# 標準の補完設定
autoload -U compinit
compinit

# ディレクトリ名を入力するだけでカレントディレクトリを変更
setopt auto_cd

# タブキー連打で補完候補を順に表示
setopt auto_menu

# 自動修正機能(候補を表示)
#setopt correct

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types

# パスの最後に付くスラッシュを自動的に削除しない
setopt noautoremoveslash

# = 以降でも補完できるようにする( --prefix=/usr 等の場合)
setopt magic_equal_subst

# 補完候補リストの日本語を正しく表示
setopt print_eight_bit

# 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# lsコマンドの補完候補にも色付き表示
#eval `dircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

###############################################
# 履歴関係                                    #
###############################################
# ヒストリー機能
HISTFILE=~/.zsh_history      # ヒストリファイルを指定
HISTSIZE=10000               # ヒストリに保存するコマンド数
SAVEHIST=10000               # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
unsetopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
#setopt hist_ignore_space    # 先頭がスペースの場合、ヒストリに追加しない

# cd - と入力してTabキーで今までに移動したディレクトリを一覧表示
setopt auto_pushd

# ディレクトリスタックに重複する物は古い方を削除
setopt pushd_ignore_dups

# コマンド履歴の検索機能の設定
# ^[  は「エスケープ」
# viなら    Ctrl-v ESC
# Emacsなら Ctrl-q ESC
# viで編集する場合
# 上2行は Ctrl-v を押下した後、希望のキーを押下
# 下2行は「エスケープS」の後にキーの端末コードを入力
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
#bindkey "OA" history-beginning-search-backward-end
#bindkey "OB" history-beginning-search-forward-end
#bindkey "[A" history-beginning-search-backward-end
#bindkey "B" history-beginning-search-forward-end
# 複数行コマンドの場合、上記の設定だと少々不都合
# tcshの様にする場合は以下のようにする
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# インクリメンタルサーチの設定
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

# 全履歴の一覧を出力する
function history-all { history -E 1 }



###############################################
# プロンプト関係                              #
###############################################
# プロンプトに escape sequence (環境変数) を通す
setopt prompt_subst

# ^[  は「エスケープ」
PROMPT="%B%{[36m%}%n@%m %c %#%{[m%}%b " # 通常のプロンプト
PROMPT2="%B%_>%b "                          # forやwhile/複数行入力時などに表示されるプロンプト
SPROMPT="%r is correct? [n,y,a,e]: "        # 入力ミスを確認する場合に表示されるプロンプト
RPROMPT="%1(v|%F{green}%1v%f|)"

setopt transient_rprompt                    # 右プロンプトに入力がきたら消す

# ターミナルのタイトル
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

###############################################
# VCS関係                                     #
###############################################
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '[%b|%a] %c%u'
fi

precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

###############################################
# その他                                      #
###############################################
# ファイル作成時のパーミッション
umask 022

setopt no_beep               # ビープ音を消す
#setopt nolistbeep           # 補完候補表示時などにビープ音を鳴らさない

#setopt interactive_comments # コマンドラインで # 以降をコメントとする

setopt numeric_glob_sort     # 辞書順ではなく数値順でソート

setopt no_multios            # zshのリダイレクト機能を制限する

unsetopt promptcr            # 改行コードで終らない出力もちゃんと出力する
#setopt ignore_eof           # Ctrl-dでログアウトしない

setopt no_hup                # ログアウト時にバックグラウンドジョブをkillしない
setopt no_checkjobs          # ログアウト時にバックグラウンドジョブを確認しない
setopt notify                # バックグラウンドジョブが終了したら(プロンプトの表示を待たずに)すぐに知らせる

setopt rm_star_wait         # rm * を実行する前に確認
#setopt rm_star_silent        # rm * を実行する前に確認しない
#setopt no_clobber           # リダイレクトで上書きを禁止
unsetopt no_clobber          # リダイレクトで上書きを許可

#setopt chase_links          # シンボリックリンクはリンク先のパスに変換してから実行
#setopt print_exit_value     # 戻り値が 0 以外の場合終了コードを表示
#setopt single_line_zle      # デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる

# カーソル位置から前方削除(Ctrl-u)
bindkey '^U' backward-kill-line

# Ctrl-h で単語ごとに削除
bindkey "^h" backward-kill-word
# / を単語の一部とみなさない記号の環境変数から削除
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#function chpwd() { ls }     # cd の後 ls も実行

# 補完される前にオリジナルのコマンドまで展開してチェックする
unsetopt complete_aliases

# alias setting
[ -f ~/dotfiles2/zshrc.alias ] && source ~/dotfiles2/zshrc.alias

case "${OSTYPE}" in
# Mac(Unix)
darwin*)
	# ここに設定
	[ -f ~/dotfiles2/zshrc.osx ] && source ~/dotfiles2/zshrc.osx
	;;
# Linux
linux*)
	# ここに設定
	[ -f ~/dotfiles2/zshrc.linux ] && source ~/dotfiles2/zshrc.linux
	;;
esac

## local固有設定
#
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

export EDITOR=vim
