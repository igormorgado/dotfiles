function backup_photography --description 'Back up Darktable photos and camera videos'
    set -l backup_mount /run/media/igor/PHOTOS_1
    set -l destination $backup_mount/fotografia

    if not mountpoint -q $backup_mount
        echo "Warning: backup drive is not mounted at $backup_mount" >&2
        return 1
    end

    if not test -d $destination
        echo "Warning: backup destination does not exist: $destination" >&2
        return 1
    end

    set -l rsync_opts \
        -av \
        --delete \
        --modify-window=4 \
        --progress \
        '--exclude=darktable_exported/***'

    rsync $rsync_opts \
        ~/Pictures/Darktable/ \
        $destination/Darktable/

    rsync $rsync_opts \
        ~/Videos/s5m2x/ \
        $destination/videos/
end
