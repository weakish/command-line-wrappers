function proxy_on
	set --global --export http_proxy '127.0.0.1:8787'
    set --global --export HTTPS_PROXY $http_proxy
end
