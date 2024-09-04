# tutorial
- [here](https://www.anand-iyer.com/blog/2018/a-simpler-way-to-manage-your-dotfiles/)

# add files
```sh
dotfiles add <file>
dotfiles commit -m "add files"
dotfiles push -u origin main
```

# new machine
```sh
mkdir -p ~/devs/dots
git clone --separate-git-dir=$HOME/devs/dots https://github.com/veevidify/dots.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
```

