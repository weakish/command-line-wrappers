function add-path --description 'A neat way to avoid the mess with PATH.'

  # via  https://coderwall.com/p/hicrzq/manipulating-path-variable-in-fish-shell
  set -gx PATH $PATH $argv[1]
end
