function vault_open --description 'Unlock and mount the local LUKS vault'
    set -l vault_image /mnt/data/igor/vault.img
    set -l vault_dir "$HOME/vault"
    set -l vault_name vault

    if not test -f "$vault_image"
        echo "Vault image not found: $vault_image" >&2
        return 1
    end

    if mountpoint -q -- "$vault_dir"
        echo "Something is already mounted at $vault_dir" >&2
        return 1
    end

    if test -e "/dev/mapper/$vault_name"
        echo "Vault mapper is already open: /dev/mapper/$vault_name" >&2
        return 1
    end

    mkdir -p -m 700 -- "$vault_dir"
    or return $status

    sudo cryptsetup open --type luks "$vault_image" "$vault_name"
    or return $status

    sudo mount -- "/dev/mapper/$vault_name" "$vault_dir"
    or begin
        set -l mount_status $status
        sudo cryptsetup close "$vault_name"
        return $mount_status
    end

    echo "Vault mounted at $vault_dir"
end
