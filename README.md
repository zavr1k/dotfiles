# dotfiles

Всё описано в `mise/.config/mise/config.toml`: дотфайлы (`[dotfiles]`),
brew-пакеты и приложения (`[bootstrap.packages]`), oh-my-zsh с темой и
плагинами (`[bootstrap.repos]`) и инструменты (`[tools]`). Раскладывает и
ставит всё [mise](https://mise.jdx.dev/bootstrap.html).

## Новая машина

```sh
# Homebrew (заодно поставит Xcode Command Line Tools с git)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install mise

git clone https://github.com/zavr1k/dotfiles.git ~/dotfiles
mkdir -p ~/.config/mise
ln -s ~/dotfiles/mise/.config/mise/config.toml ~/.config/mise/config.toml

mise bootstrap --dry-run   # посмотреть, что будет сделано
mise bootstrap
```

mise берёт настройки из своего же конфига, поэтому ссылку на него один раз
нужно создать вручную. Дальше mise сам следит за этой ссылкой.

Вручную после установки:

- скопировать SSH- и gpg-ключи и переключить репо на SSH:
  `git -C ~/dotfiles remote set-url origin git@github.com:zavr1k/dotfiles.git`
- выдать Karabiner разрешения в системных настройках, войти в приложения
- открыть nvim, LazyVim сам скачает плагины

## Повседневное

- `mise dot status -v` — состояние всех дотфайлов
- `mise dot apply` — создать недостающие ссылки
- `mise dot add <file>` — начать управлять новым файлом (не для уже слинкованных путей)
- `mise bootstrap plan` — чем машина отличается от конфига
- `mise run up` — обновить всё: brew-пакеты, инструменты mise, oh-my-zsh с темой и плагинами

## tmux

Конфиг лежит в `tmux/`, но не раскладывается. Чтобы вернуть: раскомментировать
запись `~/.config/tmux` в конфиге mise, вернуть `"brew:tmux"` в
`[bootstrap.packages]` и выполнить `mise bootstrap`.
