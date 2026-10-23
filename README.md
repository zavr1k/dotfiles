# dotfiles

Раскладываются через [mise dotfiles](https://mise.jdx.dev/dotfiles.html).
Записи `[dotfiles]` лежат в `mise/.config/mise/config.toml`.

## Новая машина

```sh
brew install mise
git clone git@github.com:zavr1k/dotfiles.git ~/dotfiles
mkdir -p ~/.config/mise
ln -s ~/dotfiles/mise/.config/mise/config.toml ~/.config/mise/config.toml
mise dot diff    # посмотреть, что изменится
mise dot apply   # с --force заменит уже существующие обычные файлы
```

mise берёт записи `[dotfiles]` из своего же конфига, поэтому ссылку на него
один раз нужно создать вручную. Дальше mise сам следит за этой ссылкой.

## Повседневное

- `mise dot status -v` — состояние всех записей
- `mise dot apply` — создать недостающие ссылки
- `mise dot add <file>` — начать управлять новым файлом (не для уже слинкованных путей)
