version=$(printf "master\nlatest\n0.15.2\n0.15.1\n0.14.1\n0.14.0\n0.13.0" | fzf)
if [[ "$version" != "" ]]; then
	echo "Launching Zig Shell ($version)"
	if [[ "$version" == "latest" ]]; then
		nix shell "github:mitchellh/zig-overlay"
	else
	nix shell "github:mitchellh/zig-overlay#\"$version\""
	fi
	echo "Make sure you use 'exit' to exit the shell"
fi
	
