# Copies the contents of a given file to the system or X Windows clipboard
#
# copyfile <file>
if [[ -r ~/.iterm2/it2copy ]]; then
  function copyfile {
    ~/.iterm2/it2copy "$@"
  }
else
  function copyfile {
    emulate -L zsh
    clipcopy $1
  }
fi
