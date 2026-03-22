#!/usr/bin/env bash

read -p "Enter Project Name: " name

case "$(printf "C\nC++\nGo\nZig" | fzf --prompt='Choose Lang: ')" in
	"C")
		mkdir "$name"
		cd "$name" || exit
		mkdir bin src
		printf '#include <stdio.h>\nint main(){return 0;}' > src/main.c
		printf '# .clang-format\n\nBasedOnStyle: LLVM\n\n# Indentation\nIndentWidth: 4\nUseTab: Never\nTabWidth: 4\n\n# Brace style (K&R / Attach)\nBreakBeforeBraces: Attach\n\n# Line length\nColumnLimit: 0\n\n# Pointer alignment (aligned to type: int* x)\nPointerAlignment: Left\nReferenceAlignment: Left\n\n# Include sorting\nSortIncludes: CaseSensitive\nIncludeBlocks: Regroup\n\n# General spacing\nSpaceBeforeParens: ControlStatements\nSpaceAfterCStyleCast: false\nSpacesInParentheses: false\nSpacesInSquareBrackets: false\nSpaceBeforeSquareBrackets: false\nSpaceInEmptyParentheses: false\n\n# Alignment\nAlignConsecutiveAssignments: false\nAlignConsecutiveDeclarations: false\nAlignTrailingComments: true\n\n# Misc\nAllowShortFunctionsOnASingleLine: Inline\nAllowShortIfStatementsOnASingleLine: Never\nAllowShortLoopsOnASingleLine: false\nAllowShortBlocksOnASingleLine: Empty\nReflowComments: true\nMaxEmptyLinesToKeep: 1\n' > .clang-format
		;;
	"C++")
		echo "C++ Support Not Implemented"
		;;
esac
