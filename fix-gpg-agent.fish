function fix-gpg-agent
	pkill gpg-agent
    # Record socket info in `~/.gnupg/agent.info`.
    gpg-agent --daemon --enable-ssh-support --write-env-file "$HOME/.gnupg/agent.info"
    set -x GPG_AGENT_INFO (cat $HOME/.gnupg/agent.info  | grep -F 'GPG_AGENT_INFO=' | grep -E -o '/[-A-Za-z0-9/.:]+')
end
