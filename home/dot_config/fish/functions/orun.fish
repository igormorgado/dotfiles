#!/usr/bin/env fish

function orun --description "Run osa"
    sudo osa -n -d -l /var/run/osa/kl_(date +%Y%m%d%H%M).log /dev/input/event11
end
