#!/bin/sh

pip install -r requirements.txt

sudo mkdir -p /opt/yt-like/

sudo cp ./like.py /opt/yt-like/

sudo cp ./like /usr/local/bin/

sudo chmod +x /usr/local/bin/like

sudo chown -R $(whoami):$(whoami) /opt/yt-like/

cd /opt/yt-like/

python3 -m venv venv

source /opt/yt-like/venv/bin/activate

deactivate

echo -e "\n\nNOW YOU CAN DELETE THIS REPO\n"

exit
