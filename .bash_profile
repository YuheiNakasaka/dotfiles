alias ll='ls -la'
PATH="$PATH":/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin

PATH=$HOME/.rbenv/bin:$PATH
PATH=/usr/local/bin:$PATH  #既存のPATH設定を移動
eval "$(rbenv init -)"

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"
