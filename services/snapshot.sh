#!/usr/bin/env bash
# grim -g "$(slurp)" - | satty --filename -  --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
# grim -g "$(slurp)" - | swappy -f - -o ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png

# screenshotfile=$(mktemp --suffix .png --dry-run)
# echo $screenshotfile

# grim -g "$(slurp)" "$screenshotfile"
# status=$?

# if [ $status -eq 0 ]; then
# 	screenshotfilecopy=$(mktemp --suffix .png)
# 	cp "$screenshotfile" "$screenshotfilecopy"
# 	echo $screenshotfilecopy
# 	convert "$screenshotfile" -resize 200x200 "$screenshotfilecopy"
#     notify-send -i "$screenshotfilecopy" ""
#     wl-copy < "$screenshotfile"
# else
#     notify-send -i "Screenshot aborted"
#     rm "$screenshotfile"
# fi

if [ "$1" == "--full-screen" ]; then
	grim
elif [ "$1" == "--edit" ]; then
	grim -g "$(slurp)" - | swappy -f -
else
	rm -f /tmp/screen.jpg 
	grim -g "$(slurp)" - | tee /tmp/screen.jpg 
	wl-copy < /tmp/screen.jpg 
	# notify-send -i /tmp/screen.jpg "Grim" "Copied to clipboard."
	ACTION=$(dunstify -i /tmp/screen.jpg --action="editAction,edit" "Screenshot taken" "Click to edit.")
	echo $ACTION

	case "$ACTION" in
		"editAction")
			swappy -f /tmp/screen.jpg
			;;
		"2")
			dunstify "Copied to clipboard." -i "$HOME/.scripts/diodon.svg"
			;;
	esac
fi
	
