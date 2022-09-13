function gl
    switch $argv[1]
    case history
        git history $argv[2..-1]
    case diff
        git diff HEAD $argv[2..-1]
    case rename
        mv $argv[2] $argv[3]
        command gl track $argv[3]
    case tag
        switch $argv[2]
            case '-c'
                git tag -a $argv[3..-1]
            case '*'
                command gl $argv
        end
    case commit
        command gl $argv; and git commit --amend --no-edit
    case '*'
        command gl $argv
    end
end