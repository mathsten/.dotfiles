#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Nord scheme by arcticicestudio

nord0="2E/34/40"
nord1="3B/42/52"
nord2="43/4C/5E"
nord3="4C/56/6A"
nord4="D8/DE/E9"
nord5="E5/E9/F0"
nord6="EC/EF/F4"
nord7="8F/BC/BB"
nord8="88/C0/D0"
nord9="81/A1/C1"
nord10="5E/81/AC"
nord11="BF/61/6A"
nord12="D0/87/70"
nord13="EB/CB/8B"
nord14="A3/BE/8C"
nord15="B4/8E/AD"

color00=$nord0
color01=$nord8	   # Base 08 - nord8 (cyan blue)
color02=$nord11    # Base 0B - nord11 (red)
color03=$nord10    # Base 0A - nord10 (blue)
color04=$nord13    # Base 0D - nord13 (yellow)
color05=$nord14    # Base 0E - nord14 (green)
color06=$nord12	   # Base 0C - nord12 (orange)
color07=$nord5     # Base 05 - nord5 (darker white)
color08=$nord3     # Base 03 - nord3 (lightest black)
color09=$color01   # Base 08 - nord8 (cyan blue)
color10=$color02 # Base 0B - nord11 (red)
color11=$color03 # Base 0A - nord10 (blue)
color12=$color04 # Base 0D - nord13 (yellow)
color13=$color05 # Base 0E - nord14 (green)
color14=$color06 # Base 0C - nord12 (orangee)
color15=$nord7 # Base 07 - nord7 (green blue)
color16=$nord9 # Base 09 - nord9 (gray blue)
color17=$nord15 # Base 0F - nord15 (magenta)
color18=$nord1 # Base 01 - nord1 (darker black)
color19=$nord2 # Base 02 - nord2 (lighter black)
color20=$nord4 # Base 04 - nord4 (darkest white)
color21=$nord6 # Base 06 - nord6 (white)
color_foreground=$color07
color_background=$color00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color05
put_template 3  $color03
put_template 4  $color04
put_template 5  $color02
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg E5E9F0 # foreground
  put_template_custom Ph 2E3440 # background
  put_template_custom Pi E5E9F0 # bold color
  put_template_custom Pj 434C5E # selection color
  put_template_custom Pk E5E9F0 # selected text color
  put_template_custom Pl E5E9F0 # cursor
  put_template_custom Pm 2E3440 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
