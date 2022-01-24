# dotfiles

This is my collection of user/application settings ("dotfiles") and personal scripts. 
They are mostly adapted to my personal needs, and some scripts make a few assumptions about the environment that may not necessarily be considered "standard", so it is *not recommended* to just copy-paste them as-is.

Nevertheless, I try to keep them as clean and non-WTF as possible, and people are invited to take a look at them, get ideas for their own dotfiles, and drop comments, suggestions, questions and bug reports if something seems odd.

## Prerequisites
The following packages should be installed
- neovim
- starship
- vim-plug
- node

# Npiperelay specific branch
Download https://github.com/jstarks/npiperelay and put it in the Path.
```
# Install socat
apt install socat
# Download
wget https://github.com/jstarks/npiperelay/releases/download/v0.1.0/npiperelay_windows_amd64.zip
# Unzip
unzip npiperelay_windows_amd64.zip
# Move
mv npiperelay.exe /usr/local/bin/
```
# Make executable
```
chmod +x /usr/local/bin/npiperelay.exe
```

