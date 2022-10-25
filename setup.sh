#!/bin/sh

sudo mkdir -p /opt/yt-like/

sudo cp ./like.py /opt/yt-like/

sudo cp ./like /usr/local/bin/

sudo cp ./requirements.txt /opt/yt-like/

sudo chmod +x /usr/local/bin/like

sudo chown -R $(whoami):$(whoami) /opt/yt-like/

cd /opt/yt-like/

python3 -m venv venv

source /opt/yt-like/venv/bin/activate

pip install -r requirements.txt

deactivate

echo -e "\n\nNOW YOU CAN DELETE THIS REPO\n"

exit 0
