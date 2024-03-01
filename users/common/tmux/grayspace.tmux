#!/bin/sh
grayspace_black="#191919"
grayspace_blue="#7aabbf"
grayspace_yellow="#bf9a59"
grayspace_red="#bf4a4a"
grayspace_white="#cccccc"
grayspace_green="#8bbf54"
grayspace_visual_grey="#666666"
grayspace_comment_grey="#999999"

get() {
   local option=$1
   local default_value=$2
   local option_value="$(tmux show-option -gqv "$option")"

   if [ -z "$option_value" ]; then
      echo "$default_value"
   else
      echo "$option_value"
   fi
}

set_() {
   local option=$1
   local value=$2
   tmux set-option -gq "$option" "$value"
}

setw() {
   local option=$1
   local value=$2
   tmux set-window-option -gq "$option" "$value"
}

set_ "status" "on"
set_ "status-justify" "left"

set_ "status-left-length" "100"
set_ "status-right-length" "100"
set_ "status-right-attr" "none"

set_ "message-fg" "$grayspace_white"
set_ "message-bg" "$grayspace_black"

set_ "message-command-fg" "$grayspace_white"
set_ "message-command-bg" "$grayspace_black"

set_ "status-attr" "none"
set_ "status-left-attr" "none"

setw "window-status-fg" "$grayspace_black"
setw "window-status-bg" "$grayspace_black"
setw "window-status-attr" "none"

setw "window-status-activity-bg" "$grayspace_black"
setw "window-status-activity-fg" "$grayspace_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set_ "window-style" "fg=$grayspace_comment_grey"
set_ "window-active-style" "fg=$grayspace_white"

set_ "pane-border-fg" "$grayspace_white"
set_ "pane-border-bg" "$grayspace_black"
set_ "pane-active-border-fg" "$grayspace_green"
set_ "pane-active-border-bg" "$grayspace_black"

set_ "display-panes-active-colour" "$grayspace_yellow"
set_ "display-panes-colour" "$grayspace_blue"

set_ "status-bg" "$grayspace_black"
set_ "status-fg" "$grayspace_white"

set_ "@prefix_highlight_fg" "$grayspace_black"
set_ "@prefix_highlight_bg" "$grayspace_green"
set_ "@prefix_highlight_copy_mode_attr" "fg=$grayspace_black,bg=$grayspace_green"
set_ "@prefix_highlight_output_prefix" "  "

is_zoomed="#{?window_zoomed_flag,[Z],}"
status_widgets=$(get "@grayspace_widgets" "$is_zoomed")
datetime_format=$(get "@grayspace_date_format" "%Y-%m-%d %R")
#mode_widget=""

# tmux-mode-indicator styles
set_ "@mode_indicator_prefix_mode_style" "fg=$grayspace_blue,bg=$grayspace_black"
set_ "@mode_indicator_copy_mode_style" "fg=$grayspace_yellow,bg=$grayspace_black"
set_ "@mode_indicator_sync_mode_style" "fg=$grayspace_red,bg=$grayspace_black"
set_ "@mode_indicator_empty_mode_style" "fg=$grayspace_black,bg=$grayspace_black"
set_ "@mode_indicator_prefix_prompt" "^A"
set_ "@mode_indicator_copy_prompt" "COPY"
set_ "@mode_indicator_sync_prompt" "SYNC"
set_ "@mode_indicator_empty_prompt" ""

set_ "status-right" "#{tmux_mode_indicator} #[fg=$grayspace_white,bg=$grayspace_black,nounderscore,noitalics]${datetime_format} #[fg=$grayspace_visual_grey,bg=$grayspace_black]#[fg=$grayspace_visual_grey,bg=$grayspace_visual_grey]#[fg=$grayspace_white,bg=$grayspace_visual_grey]${status_widgets} #[fg=$grayspace_green,bg=$grayspace_visual_grey,nobold,nounderscore,noitalics]#[fg=$grayspace_black,bg=$grayspace_green,bold] #h #[fg=$grayspace_yellow, bg=$grayspace_green]#[fg=$grayspace_red,bg=$grayspace_yellow]"
set_ "status-left" "#[fg=$grayspace_black,bg=$grayspace_green,bold] #S #{prefix_highlight}#[fg=$grayspace_green,bg=$grayspace_black,nobold,nounderscore,noitalics]"

set_ "window-status-format" "#[fg=$grayspace_black,bg=$grayspace_black,nobold,nounderscore,noitalics]#[fg=$grayspace_white,bg=$grayspace_black] #I  #W #[fg=$grayspace_black,bg=$grayspace_black,nobold,nounderscore,noitalics]"
set_ "window-status-current-format" "#[fg=$grayspace_black,bg=$grayspace_visual_grey,nobold,nounderscore,noitalics]#[fg=$grayspace_white,bg=$grayspace_visual_grey,nobold] #I  #W #[fg=$grayspace_visual_grey,bg=$grayspace_black,nobold,nounderscore,noitalics]"
