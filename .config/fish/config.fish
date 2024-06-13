if status is-interactive
    # git rid of the annoying greet message
    set fish_greeting ""

    for file in ~/.config/fish/profile/*.fish
        source $file
    end

    for file in ~/.config/fish/functions/*.fish
        source $file
    end
end
