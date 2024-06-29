## This is the root repository

1. This is **NOT** an official repo of Hyprland.
2. It works only with Debian Unstable (Sid). There's a chance that it works with other distros but it hasn't been tested.
3. The repo is served using GitHub Pages

Installation:

```sh
# import GPG key
curl -s --compressed "https://hyprland-debian.github.io/public.gpg" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/hyprland-debian.gpg > /dev/null

# add a new sources.list that:
#   1. points to this repo
#   2. uses the key from the command above
echo "deb [signed-by=/etc/apt/trusted.gpg.d/hyprland-debian.gpg] https://hyprland-debian.github.io ./" | sudo tee /etc/apt/sources.list.d/hyprland-debian.list > /dev/null

# update
sudo apt update

# install
sudo apt install hyprland
```
