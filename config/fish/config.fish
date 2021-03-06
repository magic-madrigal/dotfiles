# Disable fish greeting
set fish_greeting ""

# rbenv init
status --is-interactive; and source (rbenv init -|psub)

# pyenv init
status --is-interactive; and source (pyenv init -|psub)

# hub settings
alias git=hub

# node Settings
set -g fish_user_paths "$HOME/.npm-packages/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/node@8/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/node@8/bin" $fish_user_paths

# airline theme
set -g theme_powerline_fonts yes

# git prompt settings
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_describe_style 'branch'
set __fish_git_prompt_showcolorhints 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_show_informative_status 'yes'

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status

  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  __fish_git_prompt

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n ' → '
end

# Github Creds
source ~/.config/fish/github.fish

# other configs
source ~/.config/fish/artifactory.fish
source ~/.config/fish/zendesk.fish

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

