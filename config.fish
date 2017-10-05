# rbenv init
status --is-interactive; and source (rbenv init -|psub)

source ~/.config/fish/kragle.fish

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
set -g fish_user_paths "/usr/local/opt/icu4c/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/icu4c/sbin" $fish_user_paths
set fish_user_paths ~/.npm-packages/bin

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
