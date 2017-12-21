TOPTARGETS := all clean

TERMINAL = bin bash vim mc python tmux git pinfo
XWIN = x11
EXTRA := alacritty cgg gcp terminology todo

PACKS := $(TERMINAL)


# TODO
# ssh
# gnome
# weechat
# mutt
# htop
# packages installer !!


$(TOPTARGETS): $(PACKS)
$(PACKS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

all: $(TERMINAL) $(XWIN)

.PHONY: $(TOPTARGETS) $(PACKS)

debinstall:
	grep -v "#" packages.txt | xargs sudo apt-get install -y 


