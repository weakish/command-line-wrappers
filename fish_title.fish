function fish_title
	set -l git_branch (git branch ^/dev/null| fgrep '*' | sed 's/^\* //')
        # 0 for clean repository or non repository.
        set -l is_dirty (git status -s --ignore-submodules=dirty ^/dev/null | wc -l)
        echo $git_branch
        if test $is_dirty -ne 0
            echo " ✗ "
        end
end
