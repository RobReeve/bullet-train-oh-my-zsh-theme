# FreeAgent puts the powerline style in zsh !

if [ "$BULLETTRAIN_DATE_FORMAT" = "" ]; then
  BULLETTRAIN_DATE_FORMAT=%D{%Y-%m-%d}
fi

if [ "$BULLETTRAIN_RIGHT_B" = "" ]; then
  BULLETTRAIN_RIGHT_B=%D{%H:%M:%S}
elif [ "$BULLETTRAIN_RIGHT_B" = "none" ]; then
  BULLETTRAIN_RIGHT_B=""
fi

if [ "$BULLETTRAIN_RIGHT_A" = "mixed" ]; then
  BULLETTRAIN_RIGHT_A=%(?."$BULLETTRAIN_DATE_FORMAT".%F{red}✘ %?)
elif [ "$BULLETTRAIN_RIGHT_A" = "exit-status" ]; then
  BULLETTRAIN_RIGHT_A=%(?.%F{green}✔ %?.%F{red}✘ %?)
elif [ "$BULLETTRAIN_RIGHT_A" = "date" ]; then
  BULLETTRAIN_RIGHT_A="$BULLETTRAIN_DATE_FORMAT"
fi

if [ "$BULLETTRAIN_HIDE_USER_NAME" = "" ] && [ "$BULLETTRAIN_HIDE_HOST_NAME" = "" ]; then
    BULLETTRAIN_USER_NAME="%n@%M"
elif [ "$BULLETTRAIN_HIDE_USER_NAME" != "" ] && [ "$BULLETTRAIN_HIDE_HOST_NAME" = "" ]; then
    BULLETTRAIN_USER_NAME="@%M"
elif [ "$BULLETTRAIN_HIDE_USER_NAME" = "" ] && [ "$BULLETTRAIN_HIDE_HOST_NAME" != "" ]; then
    BULLETTRAIN_USER_NAME="%n"
else
    BULLETTRAIN_USER_NAME=""
fi

BULLETTRAIN_CURRENT_PATH="%d"

if [ "$BULLETTRAIN_FULL_CURRENT_PATH" = "" ]; then
  BULLETTRAIN_CURRENT_PATH="%1~"
fi

if [ "$BULLETTRAIN_GIT_CLEAN" = "" ]; then
  BULLETTRAIN_GIT_CLEAN="✔"
fi

if [ "$BULLETTRAIN_GIT_DIRTY" = "" ]; then
  BULLETTRAIN_GIT_DIRTY="✘"
fi

if [ "$BULLETTRAIN_GIT_ADDED" = "" ]; then
  BULLETTRAIN_GIT_ADDED="%F{green}✚%F{black}"
fi

if [ "$BULLETTRAIN_GIT_MODIFIED" = "" ]; then
  BULLETTRAIN_GIT_MODIFIED="%F{blue}✹%F{black}"
fi

if [ "$BULLETTRAIN_GIT_DELETED" = "" ]; then
  BULLETTRAIN_GIT_DELETED="%F{red}✖%F{black}"
fi

if [ "$BULLETTRAIN_GIT_UNTRACKED" = "" ]; then
  BULLETTRAIN_GIT_UNTRACKED="%F{yellow}✭%F{black}"
fi

if [ "$BULLETTRAIN_GIT_RENAMED" = "" ]; then
  BULLETTRAIN_GIT_RENAMED="➜"
fi

if [ "$BULLETTRAIN_GIT_UNMERGED" = "" ]; then
  BULLETTRAIN_GIT_UNMERGED="═"
fi

ZSH_THEME_GIT_PROMPT_PREFIX=" \ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" $BULLETTRAIN_GIT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN=" $BULLETTRAIN_GIT_CLEAN"

ZSH_THEME_GIT_PROMPT_ADDED=" $BULLETTRAIN_GIT_ADDED"
ZSH_THEME_GIT_PROMPT_MODIFIED=" $BULLETTRAIN_GIT_MODIFIED"
ZSH_THEME_GIT_PROMPT_DELETED=" $BULLETTRAIN_GIT_DELETED"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" $BULLETTRAIN_GIT_UNTRACKED"
ZSH_THEME_GIT_PROMPT_RENAMED=" $BULLETTRAIN_GIT_RENAMED"
ZSH_THEME_GIT_PROMPT_UNMERGED=" $BULLETTRAIN_GIT_UNMERGED"
ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"

# if [ "$(git_prompt_info)" = "" ]; then
   # BULLETTRAIN_GIT_INFO_LEFT=""
   # BULLETTRAIN_GIT_INFO_RIGHT=""
# else
    if [ "$BULLETTRAIN_SHOW_GIT_ON_RIGHT" = "" ]; then
        if [ "$BULLETTRAIN_HIDE_GIT_PROMPT_STATUS" = "" ]; then
            BULLETTRAIN_GIT_INFO_LEFT=" %F{blue}%K{white}"$'\ue0b0'"%F{white}%F{black}%K{white}"$'$(git_prompt_info)$(git_prompt_status)%F{white}'
        else
            BULLETTRAIN_GIT_INFO_LEFT=" %F{blue}%K{white}"$'\ue0b0'"%F{white}%F{black}%K{white}"$'$(git_prompt_info)%F{white}'
        fi
        BULLETTRAIN_GIT_INFO_RIGHT=""
    else
        BULLETTRAIN_GIT_INFO_LEFT=""
        BULLETTRAIN_GIT_INFO_RIGHT="%F{white}"$'\ue0b2'"%F{black}%K{white}"$'$(git_prompt_info)'" %K{white}"
    fi
# fi

if [ $(id -u) -eq 0 ]; then
    BULLETTRAIN_SEC1_BG=%K{red}
    BULLETTRAIN_SEC1_FG=%F{red}
else
    BULLETTRAIN_SEC1_BG=%K{green}
    BULLETTRAIN_SEC1_FG=%F{green}
fi
BULLETTRAIN_SEC1_TXT=%F{black}
if [ "$BULLETTRAIN_DETECT_SSH" != "" ]; then
  if [ -n "$SSH_CLIENT" ]; then
    BULLETTRAIN_SEC1_BG=%K{red}
    BULLETTRAIN_SEC1_FG=%F{red}
    BULLETTRAIN_SEC1_TXT=%F{white}
  fi
fi
PROMPT="$BULLETTRAIN_SEC1_BG$BULLETTRAIN_SEC1_TXT $BULLETTRAIN_USER_NAME %k%f$BULLETTRAIN_SEC1_FG%K{blue}"$'\ue0b0'"%k%f%F{white}%K{blue} "$BULLETTRAIN_CURRENT_PATH"%F{blue}"$BULLETTRAIN_GIT_INFO_LEFT" %k"$'\ue0b0'"%f "

if [ "$BULLETTRAIN_NO_BLANK_LINE" = "" ]; then
    PROMPT="
"$PROMPT
fi

if [ "$BULLETTRAIN_DISABLE_RPROMPT" = "" ]; then
    if [ "$BULLETTRAIN_RIGHT_A" = "" ]; then
        RPROMPT="$BULLETTRAIN_GIT_INFO_RIGHT%F{white}"$'\ue0b2'"%k%F{black}%K{white} $BULLETTRAIN_RIGHT_B %f%k"
    elif [ "$BULLETTRAIN_RIGHT_B" = "" ]; then
        RPROMPT="$BULLETTRAIN_GIT_INFO_RIGHT%F{white}"$'\ue0b2'"%k%F{240}%K{white} $BULLETTRAIN_RIGHT_A %f%k"
    else
        RPROMPT="$BULLETTRAIN_GIT_INFO_RIGHT%F{white}"$'\ue0b2'"%k%F{black}%K{white} $BULLETTRAIN_RIGHT_B %f%F{240}"$'\ue0b2'"%f%k%K{240}%F{255} $BULLETTRAIN_RIGHT_A %f%k"
    fi
fi
