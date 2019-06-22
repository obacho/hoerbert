file=$1
#ffmpeg -i "$file" -b:a 128k "${file::-4}".mp3;
ffmpeg -i "$file" "${file::-4}".mp3;
mkdir old
mv "$file" old
