function fish_prompt
  if test $status -ne 0
    set_color -o red
    echo -n "$red; "
  else
    echo -n "; "
  end
end
