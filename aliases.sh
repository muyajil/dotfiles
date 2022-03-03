alias jn="jupyter notebook"
alias vs="code ."
alias jl="jupyter-lab"
alias dps="docker ps --format \"table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.RunningFor}}\t{{.Ports}}\""
alias dc="docker-compose"
alias yt-pl-dl="yt-dlp --extract-audio --audio-format mp3 -o \"%(playlist_index)s - %(title)s.%(ext)s\" --cookies-from-browser chrome --yes-playlist"
alias yt-dl-mv="yt-dlp -f \"bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best\"  --cookies-from-browser chrome"