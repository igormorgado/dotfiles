TOPTARGETS := all clean

TERMINAL = term fish tmux vim git
XWIN = fonts x11
EXTRA := 

PACKS := 


# TODO
# ssh
# gnome
# htop
# packages installer !!


$(TOPTARGETS): $(PACKS)

$(PACKS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

all: $(TERMINAL) $(XWIN)

.PHONY: $(TOPTARGETS) $(PACKS)

debian:
	grep -v "#" debian_packages.txt | xargs sudo apt-get install -y 

arch:
	grep -v "#" arch_packages.txt | xargs sudo pacman -S --noconfirm


