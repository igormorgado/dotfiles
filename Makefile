TOPTARGETS := all clean

PACKS := bin bash vim mc tmux python x11

# TODO
# ssh
# git
# gnome
# irssi
# mutt
# htop
# packages installer !!

EXTRA := alacritty cgg gcp terminology todo

$(TOPTARGETS): $(PACKS)
$(PACKS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: $(TOPTARGETS) $(PACKS)

debinstall:
	grep -v "#" packages.txt | xargs sudo apt-get install -y 


