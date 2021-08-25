TOPTARGETS := all clean

TERMINAL = fish vim
XWIN = x11 fonts
EXTRA := todo

PACKS := vim


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


