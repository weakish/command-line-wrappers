function cndns
    set chnroute /pool/repos/contrib/ChinaDNS/chnroute.txt
    sudo chinadns -v -m -p 5053 -c $chnroute
end
