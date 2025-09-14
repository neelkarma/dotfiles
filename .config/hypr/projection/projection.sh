#!/bin/sh

SCRIPT_DIR=$HOME/.config/hypr/projection

selection=$(fuzzel -d --placeholder Projection... <<EOF
Primary Only
Secondary Only
Mirror
Extend
EOF
)

case $selection in
  "Primary Only")
    cp $SCRIPT_DIR/primary-only.conf $SCRIPT_DIR/projection.conf
    ;;
  "Secondary Only")
    cp $SCRIPT_DIR/secondary-only.conf $SCRIPT_DIR/projection.conf
    ;;
  "Mirror")
    cp $SCRIPT_DIR/mirror.conf $SCRIPT_DIR/projection.conf
    ;;
  "Extend")
    cp $SCRIPT_DIR/extend.conf $SCRIPT_DIR/projection.conf
    ;;
  "")
    ;;
  *)
    notify-send "Invalid projection setting"
    ;;
esac
