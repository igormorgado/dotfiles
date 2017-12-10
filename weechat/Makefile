mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
weechatfiles = alias.conf aspell.conf autosort.conf charset.conf colorize_nicks.conf exec.conf irc.conf logger.conf plugins.conf relay.conf script.conf sec.conf trigger.conf weechat.conf xfer.conf


all: weechat
clean: weechatclean

weechat:
	@mkdir -p ${HOME}/.weechat
	$(foreach f,$(weechatfiles),ln -sf $(dir $(mkfile_path))$(f) ${HOME}/.weechat/$(f);)

weechatclean:
	@rm -rf ~/.weechat

