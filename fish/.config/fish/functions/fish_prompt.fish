function fish_prompt --description 'Write out the prompt'

    # setup git prompt
    function display_git_branch
      set -l git_dir (git rev-parse --git-dir 2> /dev/null)

      # only try to print branch when in a git repo
      if test -n "$git_dir"
        set -l branch (git status | head -1 | string split ' ')[-1]
        set -l git_status (git status -s)

        if test -n "$git_status"
          echo -n -s ' ' (set_color red) $branch (set_color normal)
        else
          echo "$fish_git_not_dirty_color"
          echo -n -s ' ' (set_color cyan) $branch (set_color normal)
        end
      end
    end
	
    set -l last_status $status

    if test $last_status -ne 0
        printf "%s(%d)%s " (set_color red --bold) $last_status (set_color normal)
    end

    set -l color_cwd
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end

    echo -n -s "$USER" ' ' (set_color $color_cwd) (prompt_pwd) (display_git_branch) (set_color normal) "$suffix "
end
