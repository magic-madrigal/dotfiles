set -l os (uname)

# Docker Desktop (macOS)
test -d $HOME/.docker/bin; and fish_add_path -a $HOME/.docker/bin

# Disable fish greeting
# set fish_greeting

# Homebrew Path (macOS)
test -d /opt/homebrew/bin; and set -p fish_user_paths "/opt/homebrew/bin"


# Export NVM_DIR
set -gx NVM_DIR "$HOME/.nvm"

# AWS Profile
set -gx AWS_PROFILE "magic-admin"

# k8s Tools
test -d $HOME/.kubescape/bin; and set -p fish_user_paths "$HOME/.kubescape/bin"

# tailscale
set -p fish_user_paths "/usr/local/bin"

# Mosh: end a mosh-server whose client has been gone for 7 days (default: never).
# Set for every shell, not only interactive ones: mosh starts mosh-server through
# a non-interactive `fish -c` over SSH.
set -gx MOSH_SERVER_NETWORK_TMOUT 604800

# SSH agent: over SSH keep the forwarded agent (so 1Password prompts happen on
# the machine you're sitting at); otherwise prefer 1Password's local agent,
# falling back to a plain ssh-agent
set -l op_sock "$HOME/.1password/agent.sock"
test $os = Darwin; and set op_sock "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
if set -q SSH_CONNECTION; and test -S "$SSH_AUTH_SOCK"
  # forwarded agent from the client — leave it alone
else if test -S "$op_sock"
  set -gx SSH_AUTH_SOCK "$op_sock"
else
  fish_ssh_agent
end

# rbenv init
# status --is-interactive; and source (rbenv init -|psub)

# pyenv init
# status --is-interactive; and source (pyenv init -|psub)

# abbreviations
abbr --add --global k kubectl

# hub settings
alias git=hub

# java version for SuiteCloud CLI Dev
# set -x JAVA_HOME "/usr/libexec/java_home -v 11.0.15.1"
set -g fish_user_paths "/opt/homebrew/opt/openjdk@17/bin" $fish_user_paths
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"

# node Settings
set -g fish_user_paths "$HOME/.npm-packages/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/node@8/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/node@8/bin" $fish_user_paths

# airline theme
# set -g theme_powerline_fonts yes

# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

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

  echo -n ' ❯ '
end

# Github Creds
# source ~/.config/fish/github.fish

# other configs
# source ~/.config/fish/artifactory.fish
# source ~/.config/fish/reddit.fish
# Local, untracked secret files (only sourced if present)
for f in openai azure vanta cloudflare attio github
  test -f ~/.config/fish/$f.fish; and source ~/.config/fish/$f.fish
end

if type -q brew
  set -l gcloud_inc (brew --prefix)/share/google-cloud-sdk/path.fish.inc
  test -f $gcloud_inc; and source $gcloud_inc
end

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
# [ -f /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
# [ -f /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/edmadrigal/.npm-packages/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish

# fish_add_path /usr/local/opt/bzip2/bin

# Starship Prompt Init
type -q starship; and starship init fish | source

# Atuin Init
type -q atuin; and atuin init fish | source

# the fuck?
# thefuck --alias | source

# Terminal Sunday (interactive shells only: output in non-interactive shells breaks scp/rsync)
if status is-interactive
    $HOME/.config/fish/terminal_sunday.sh 1985-08-01 Magic
end

# Created by `pipx` on 2025-06-26 07:59:55
fish_add_path -a $HOME/.local/bin

# peon-ping quick controls
function peon; bash $HOME/.claude/hooks/peon-ping/peon.sh $argv; end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

