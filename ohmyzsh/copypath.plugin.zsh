# Copies the path of given directory or file to the system or X Windows clipboard.
# Copy current directory if no parameter.
if [[ -r ~/.iterm2/it2copy ]]; then
  function copypath {
    # If no argument passed, use current directory
    local file="${1:-.}"

    # If argument is not an absolute path, prepend $PWD
    [[ "$file" = /* ]] || file="$PWD/$file"

    # Copy the absolute path without resolving symlinks
    # If clipcopy fails, exit the function with an error
    ~/.iterm2/it2copy <<<"$file" || return 1

    echo ${(%):-"%B${file:a}%b copied to clipboard."}
  }
else
  function copypath {
    # If no argument passed, use current directory
    local file="${1:-.}"

    # If argument is not an absolute path, prepend $PWD
    [[ $file = /* ]] || file="$PWD/$file"

    # Copy the absolute path without resolving symlinks
    # If clipcopy fails, exit the function with an error
    print -n "${file:a}" | clipcopy || return 1

    echo ${(%):-"%B${file:a}%b copied to clipboard."}
  }
fi
