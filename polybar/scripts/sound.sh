case $1 in
  up)
    wpctl set-volume @DEFAULT_SINK@ 5%+
    volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')
    printf "%d%%\n" $(awk "BEGIN {print int($volume * 100)}")
    polybar-msg hook audio 1
		;;
  down)
    wpctl set-volume @DEFAULT_SINK@ 5%-
    volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')
    printf "%d%%\n" $(awk "BEGIN {print int($volume * 100)}")
    polybar-msg hook audio 1
		;;
  mute)
    wpctl set-mute @DEFAULT_SINK@ toggle
    polybar-msg hook audio 1
		;;
  *)
    volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2}')
    printf "%d%%\n" $(awk "BEGIN {print int($volume * 100)}")
    polybar-msg hook audio 1
		;;
esac
