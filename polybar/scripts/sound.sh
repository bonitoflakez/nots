case $1 in
  up)
    wpctl set-volume @DEFAULT_SINK@ 5%+
    volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')
    printf "%d%%\n" $(awk "BEGIN {print int($volume * 100)}")
    ;;
  down)
    wpctl set-volume @DEFAULT_SINK@ 5%-
    volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')
    printf "%d%%\n" $(awk "BEGIN {print int($volume * 100)}")
    ;;
  mute)
    wpctl set-mute @DEFAULT_SINK@ toggle
    volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')
    printf "%d%%\n" $(awk "BEGIN {print int($volume * 100)}")
    ;;
  *)
    volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')
    printf "%d%%\n" $(awk "BEGIN {print int($volume * 100)}")
    ;;
esac
