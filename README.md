# YT-Like
Like YouTube videos from command line. This program uses *YouTube Data API v3* to achieve that. I created this utility because I don't like to watch youtube content from their official website which is bloated, slow and creepy on users privacy. So, This way I can appreciate creators work without login again again.

# Prerequisite
* YouTube's Data API **OAuth** Credentials. Check This [Corey Schafer's](https://piped.kavin.rocks/watch?v=vQQEaSnQ_bs) Video To Get One.
* Once You Have That Rename File With **YOUR_CLIENT_SECRET_FILE.json**. And Place It In **/opt/yt-like** Directory (After Running Installation Steps).

# Installation
```bash
git clone https://github.com/FlareXes/yt-like.git && cd yt-like

chmod +x setup.sh

./setup.sh
```

**Remember That:** above steps will do everything for you but you have to move **YOUR_CLIENT_SECRET_FILE.json** at **/opt/yt-like** by yourself.

Now, run `like` command in terminal with videos url as argument, like below:
```bash
like https://youtube.com/watch?v=vQQEaSnQ_bs
```

For first time, it will open a login window so you have to login into your account (One Time Step).

# Uninstall
```
sudo rm -rf /opt/yt-like /usr/local/bin/like
```

# License
This work by [FlareXes](https://github.com/FlareXes) is Licensed Under [MIT LICENSE](LICENCE)