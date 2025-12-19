# Add Nix profile binaries
fish_add_path $HOME/.nix-profile/bin
fish_add_path /nix/var/nix/profiles/default/bin

# Add fallback system paths (for safety)
fish_add_path /usr/local/bin
fish_add_path /usr/bin
fish_add_path /bin
fish_add_path /usr/sbin
fish_add_path /sbin

# Add Homebrew paths (if you use Homebrew too)
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# Cargo path
fish_add_path $HOME/.cargo/env.fish

# Starship prompt
starship init fish | source

zoxide init fish | source

atuin init fish | source

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

alias ls="eza -lah --icons"

set -x ZELLIJ_AUTO_EXIT true
set -x ZELLIJ_AUTO_ATTACH true

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end

set -x DYLD_LIBRARY_PATH /usr/local/oracle $DYLD_LIBRARY_PATH
set -x OCI_LIB_DIR /usr/local/oracle
set -x OCI_INC_DIR /usr/local/oracle/sdk/include
