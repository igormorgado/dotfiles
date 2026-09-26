function vault_close --description 'Unmount and lock the local LUKS vault'
    set -l vault_dir "$HOME/vault"
    set -l vault_name vault
    set -l vault_mapper "/dev/mapper/$vault_name"

    if mountpoint -q -- "$vault_dir"
        if not test -e "$vault_mapper"
            echo "Refusing to unmount $vault_dir: $vault_mapper is not open" >&2
            return 1
        end

        set -l mounted_source (findmnt -n -o SOURCE --mountpoint "$vault_dir")
        set -l mounted_device (readlink -f -- "$mounted_source")
        set -l vault_device (readlink -f -- "$vault_mapper")
        if test "$mounted_device" != "$vault_device"
            echo "Refusing to unmount $vault_dir: it is not the vault" >&2
            return 1
        end

        sudo umount -- "$vault_dir"
        or return $status
    end

    if test -e "$vault_mapper"
        sudo cryptsetup close "$vault_name"
        or return $status
    end

    echo 'Vault closed'
end
