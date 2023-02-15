export DOTFILES_PATH="/home/lr56c/.dotfiles"
export DOTLY_PATH="$DOTFILES_PATH/modules/dotly"
export DOTLY_THEME="codely"

source "$DOTFILES_PATH/shell/init.sh"

EXPORTED_PATH=$(
  IFS=":"
  echo "${path[*]}"
)
export PATH="$PATH:$EXPORTED_PATH"

themes_paths=(
  "$DOTFILES_PATH/shell/bash/themes"
  "$DOTLY_PATH/shell/bash/themes"
)
@feature:terminal
for THEME_PATH in ${themes_paths[@]}; do
  THEME_PATH="${THEME_PATH}/$DOTLY_THEME.sh"
  [ -f "$THEME_PATH" ] && source "$THEME_PATH" && THEME_COMMAND="${PROMPT_COMMAND:-}" && break
done

if [[ "$(ps -p $$ -ocomm=)" =~ (bash$) ]]; then
  __right_prompt() {
    RIGHT_PROMPT=""
    [[ -n $RPS1 ]] && RIGHT_PROMPT=$RPS1 || RIGHT_PROMPT=$RPROMPT
    if [[ -n $RIGHT_PROMPT ]]; then
      n=$(($COLUMNS - ${#RIGHT_PROMPT}))
      printf "%${n}s$RIGHT_PROMPT\\r"
    fi

    if
      [[ -n "${THEME_COMMAND:-}" ]] &&
      declare -F "${THEME_COMMAND:-}" &> /dev/null
    then
      "${THEME_COMMAND:-}"
    fi
  }
  export PROMPT_COMMAND="__right_prompt"
fi

for bash_file in "$DOTLY_PATH"/shell/bash/completions/_*; do
  source "$bash_file"
done

if [ -n "$(ls -A "$DOTFILES_PATH/shell/bash/completions/")" ]; then
  for bash_file in "$DOTFILES_PATH"/shell/bash/completions/_*; do
    source "$bash_file"
  done
fi


#eval "$(oh-my-posh init bash --config ~/.oh-my-posh/takuya.omp.json)"

#export JAVA_HOME="/home/lr56c/.jdks/temurin-11.0.16.1"
export jetbrains="/home/lr56c/.local/share/JetBrains/Toolbox/scripts"
export cargo="/home/lr56c/.cargo"
export v="/home/lr56c/v"
export flutter="/home/lr56c/snap/flutter/common/flutter"
#export CHROME_EXECUTABLE="/opt/google/chrome/chrome"
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH="$PATH:$JAVA_HOME/bin:$cargo/bin:$jetbrains:$v:$flutter/bin"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm