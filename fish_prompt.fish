function fish_prompt
  set --local last_status $status
  set --local red (set_color -o red) 
  if test $last_status -ne 0
    set error_exit "$red($last_status) "
  end
	echo -n "$error_exit; "
end
