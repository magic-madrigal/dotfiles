function sc --wraps claude --description 'Run `claude agents` from ~/Repos/sanai-app without changing the current directory'
    env -C ~/Repos/sanai-app claude agents $argv
end
