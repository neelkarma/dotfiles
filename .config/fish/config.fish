# better manpager
set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

if status is-interactive;
  # aliases
  alias ls="eza -la"
  alias cd="z"
  alias c="clear"

  # init scripts
  zoxide init fish | source
  starship init fish | source
  thefuck --alias | source

  # yazi wrapper
  function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
  end

  # fetch script
  echo
  fastfetch
end
