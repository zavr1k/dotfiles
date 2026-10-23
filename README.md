# dotfiles

Deployed with [mise dotfiles](https://mise.jdx.dev/dotfiles.html). The
`[dotfiles]` entries live in `mise/.config/mise/config.toml`.

## New machine

```sh
brew install mise
git clone <repo> ~/dotfiles
mkdir -p ~/.config/mise
ln -s ../../dotfiles/mise/.config/mise/config.toml ~/.config/mise/config.toml
mise dot diff    # review what will change
mise dot apply   # add --force to replace existing real files
```

mise reads `[dotfiles]` from its own config, so that config has to be linked
by hand once. After that it manages its own link.

## Everyday use

- `mise dot status -v` — state of every entry
- `mise dot apply` — create missing links
- `mise dot add <file>` — start managing a new file (not for already linked paths)
