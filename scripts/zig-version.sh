version=$(printf "master\nlatest\n0.15.2\n0.15.1\n0.15.0" | fzf)
if version != ""; then
	nix shell "github:mitchellh/zig-overlay#$(version)"
fi
	
