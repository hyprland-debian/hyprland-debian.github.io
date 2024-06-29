1. This is **NOT** an official repo of Hyprland.
2. It works only on Debian Unstable (Sid). There's a chance that it works on other distros but it hasn't been tested.
3. The repo is served using GitHub Pages.

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

Internals:

1. There are 4 Debian packages in this repo at the moment (`hyprcursor`, `hyprutils`, `hyprwayland-scanner` and `hyprland`), all of them depend on some other packages from official Debian Unstable repo. Most of these dependencies probably don't exist in the latest stable branch of Debian.
2. Each packages is built in a separate repo on CI (for example, [this is the repo of `hyprland`](https://github.com/hyprland-debian/hyprland-deb))

Flow:

1. You push to `debian-hyprland/<package>-deb` repo
2. CI builds it inside `debian:unstable` Docker container
3. CI creates a new release with attached `*.deb` file
4. CI triggers `refresh` workflow in this repo
5. This repo pulls all packages from `debian-hyprland` organisation
6. It updates Debian repository index files (like `Packages` and `Release`) and signs them
7. It pushes it back to the `master` branch.
8. GitHub pages updates `hyprland-debian.github.io` with new static content.
9. End user that has this repo in sources runs `apt update && apt upgrade` and receives all updates
