TOPTARGETS := all clean

TERMINAL = bin bash vim mc python tmux 
XWIN = x11
EXTRA := alacritty cgg gcp terminology todo

PACKS := $(TERMINAL) $(XWIN)


# TODO
# ssh
# git
# gnome
# irssi
# mutt
# htop
# packages installer !!


$(TOPTARGETS): $(PACKS)
$(PACKS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(PACKS)

debinstall:
	grep -v "#" packages.txt | xargs sudo apt-get install -y 


