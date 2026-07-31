#!/bin/sh

# Portable previewer for vifm's 'previewprg'.  Rich previews are optional:
# every handler falls back to tools normally available on macOS and Linux.

target=${1-}
max_lines=${VIFM_PREVIEW_LINES:-300}

case "$max_lines" in
    ''|*[!0-9]*) max_lines=300 ;;
esac
if [ "$max_lines" -lt 1 ] 2>/dev/null; then
    max_lines=300
fi

os_name=${VIFM_PREVIEW_OS:-$(uname -s 2>/dev/null || printf 'Unknown')}
case "$os_name" in
    Darwin|Linux) ;;
    *) os_name=Other ;;
esac

have() {
    command -v "$1" >/dev/null 2>&1
}

limit_output() {
    sed -n "1,${max_lines}p"
}

absolute_path() {
    case "$target" in
        /*) printf '%s\n' "$target" ;;
        *) printf '%s/%s\n' "$PWD" "$target" ;;
    esac
}

print_metadata() {
    case "$os_name" in
        Darwin)
            stat -f 'Name: %N%nType: %HT%nSize: %z bytes%nMode: %Sp (%Mp%Lp)%nOwner: %Su:%Sg%nModified: %Sm' \
                -t '%Y-%m-%d %H:%M:%S %z' -- "$target" 2>/dev/null || \
                stat -- "$target" 2>/dev/null
            ;;
        Linux)
            stat --printf='Name: %n\nType: %F\nSize: %s bytes\nMode: %A (%a)\nOwner: %U:%G\nModified: %y\n' \
                -- "$target" 2>/dev/null || stat -- "$target" 2>/dev/null
            ;;
        *)
            stat -- "$target" 2>/dev/null || ls -ld -- "$target" 2>/dev/null
            ;;
    esac
}

print_file_summary() {
    print_metadata
    printf '\nDescription: %s\nMIME type: %s\n' "$file_description" "$mime_type"
}

print_macos_metadata() {
    [ "$os_name" = Darwin ] || return 1
    have mdls || return 1

    mdls \
        -name kMDItemKind \
        -name kMDItemContentType \
        -name kMDItemFSSize \
        -name kMDItemPixelWidth \
        -name kMDItemPixelHeight \
        -name kMDItemDurationSeconds \
        -name kMDItemAuthors \
        -name kMDItemTitle \
        -- "$(absolute_path)" 2>/dev/null | sed '/: could not find .*\.$/d'
}

append_macos_metadata() {
    macos_metadata_output=$(print_macos_metadata)
    if [ -n "$macos_metadata_output" ]; then
        printf '\nmacOS metadata:\n%s\n' "$macos_metadata_output"
    fi
}

strip_markup() {
    if have perl; then
        perl -0777 -pe '
            s{<(?:br|w:br|w:tab|text:tab)\b[^>]*>}{\n}gi;
            s{</(?:p|div|li|h[1-6]|w:p|text:p|text:h)>}{\n}gi;
            s{<[^>]+>}{}g;
            s/&nbsp;/ /gi; s/&amp;/&/gi; s/&lt;/</gi; s/&gt;/>/gi;
            s/&quot;/"/gi; s/[ \t]+\n/\n/g; s/\n{3,}/\n\n/g;
        '
    else
        sed 's/<[^>]*>/ /g; s/&nbsp;/ /g; s/&amp;/\&/g; s/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g'
    fi
}

preview_text() {
    if have bat; then
        bat --color=always --style=numbers --paging=never -- "$target" 2>/dev/null | limit_output
    elif have batcat; then
        batcat --color=always --style=numbers --paging=never -- "$target" 2>/dev/null | limit_output
    elif have pygmentize; then
        if pygmentize -L styles 2>/dev/null | grep -Eq '(^|[ ,])darktrial([ ,:]|$)'; then
            preview_style=darktrial
        else
            preview_style=monokai
        fi
        pygmentize -O "style=$preview_style" -f console256 -g "$target" 2>/dev/null | limit_output
    else
        sed -n "1,${max_lines}p" "$target" 2>/dev/null
    fi
}

preview_directory() {
    print_metadata

    if [ "$os_name" = Darwin ] && [ -f "$target/Contents/Info.plist" ] && have plutil; then
        printf '\nApplication bundle:\n'
        plutil -p -- "$target/Contents/Info.plist" 2>/dev/null | limit_output
    fi

    printf '\nContents:\n'
    if have eza; then
        eza -la --color=always --group-directories-first "$target" 2>/dev/null | limit_output
    elif have exa; then
        exa -la --color=always --group-directories-first "$target" 2>/dev/null | limit_output
    else
        case "$os_name" in
            Darwin)
                CLICOLOR=1 CLICOLOR_FORCE=1 ls -laG -- "$target" 2>/dev/null | limit_output
                ;;
            Linux)
                if ls --color=always -d . >/dev/null 2>&1; then
                    if ls --group-directories-first -d . >/dev/null 2>&1; then
                        ls -la --color=always --group-directories-first -- "$target" 2>/dev/null | limit_output
                    else
                        ls -la --color=always -- "$target" 2>/dev/null | limit_output
                    fi
                else
                    ls -la -- "$target" 2>/dev/null | limit_output
                fi
                ;;
            *)
                ls -la -- "$target" 2>/dev/null | limit_output
                ;;
        esac
    fi
}

preview_image() {
    if have chafa; then
        chafa "$target" 2>/dev/null | limit_output
        return
    fi
    if have viu; then
        viu -t "$target" 2>/dev/null | limit_output
        return
    fi
    if have img2txt; then
        img2txt "$target" 2>/dev/null | limit_output
        return
    fi

    print_file_summary
    case "$os_name" in
        Darwin)
            if have sips; then
                printf '\nImage properties:\n'
                sips -g format -g pixelWidth -g pixelHeight -g space "$target" 2>/dev/null | limit_output
            else
                append_macos_metadata
            fi
            ;;
        Linux)
            if have identify; then
                printf '\nImage properties:\n'
                identify "$target" 2>/dev/null | limit_output
            fi
            ;;
    esac
}

preview_pdf() {
    if have pdftotext; then
        pdftotext -nopgbrk "$target" - 2>/dev/null | limit_output
    elif have mutool; then
        mutool draw -F txt "$target" 2>/dev/null | limit_output
    else
        print_file_summary
        append_macos_metadata
    fi
}

preview_ooxml() {
    archive_member=$1
    have unzip || return 1
    unzip -Z1 "$target" 2>/dev/null | grep -Fqx "$archive_member" || return 1
    unzip -p "$target" "$archive_member" 2>/dev/null | strip_markup | limit_output
}

preview_document() {
    case "$lower_name" in
        *.docx)
            if have docx2txt; then
                docx2txt "$target" - 2>/dev/null | limit_output
            elif have pandoc; then
                pandoc -t plain "$target" 2>/dev/null | limit_output
            elif [ "$os_name" = Darwin ] && have textutil; then
                textutil -convert txt -stdout -- "$target" 2>/dev/null | limit_output
            elif ! preview_ooxml word/document.xml; then
                print_file_summary
            fi
            ;;
        *.odt)
            if have odt2txt; then
                odt2txt "$target" 2>/dev/null | limit_output
            elif have pandoc; then
                pandoc -t plain "$target" 2>/dev/null | limit_output
            elif [ "$os_name" = Darwin ] && have textutil; then
                textutil -convert txt -stdout -- "$target" 2>/dev/null | limit_output
            elif ! preview_ooxml content.xml; then
                print_file_summary
            fi
            ;;
        *.doc|*.rtf)
            if [ "$os_name" = Darwin ] && have textutil; then
                textutil -convert txt -stdout -- "$target" 2>/dev/null | limit_output
            elif have antiword && [ "${lower_name##*.}" = doc ]; then
                antiword "$target" 2>/dev/null | limit_output
            elif have pandoc; then
                pandoc -t plain "$target" 2>/dev/null | limit_output
            else
                print_file_summary
            fi
            ;;
        *)
            print_file_summary
            ;;
    esac
}

preview_ebook() {
    if have ebook-meta; then
        ebook-meta "$target" 2>/dev/null | limit_output
        printf '\n'
    fi

    if have pandoc; then
        pandoc -t plain "$target" 2>/dev/null | limit_output
    elif [ "${lower_name##*.}" = epub ] && have unzip; then
        unzip -p "$target" '*.xhtml' '*.html' '*.htm' 2>/dev/null | strip_markup | limit_output
    elif ! have ebook-meta; then
        print_file_summary
    fi
}

preview_html() {
    if have w3m; then
        w3m -dump -T text/html "$target" 2>/dev/null | limit_output
    elif have lynx; then
        lynx -dump -stdin <"$target" 2>/dev/null | limit_output
    elif have elinks; then
        elinks -dump "$target" 2>/dev/null | limit_output
    elif have pandoc; then
        pandoc -f html -t plain "$target" 2>/dev/null | limit_output
    else
        strip_markup <"$target" 2>/dev/null | limit_output
    fi
}

preview_delimited() {
    separator=$1
    if have column; then
        column -s "$separator" -t "$target" 2>/dev/null | limit_output
    else
        preview_text
    fi
}

preview_media() {
    if have mediainfo; then
        mediainfo "$target" 2>/dev/null | limit_output
    elif have exiftool; then
        exiftool "$target" 2>/dev/null | limit_output
    elif have ffprobe; then
        ffprobe -hide_banner "$target" 2>&1 | limit_output
    else
        print_file_summary
        append_macos_metadata
    fi
}

preview_archive() {
    case "$lower_name" in
        *.dmg)
            if [ "$os_name" = Darwin ] && have hdiutil; then
                hdiutil imageinfo "$target" 2>/dev/null | limit_output
                return
            fi
            ;;
        *.pkg)
            if [ "$os_name" = Darwin ] && have pkgutil; then
                pkgutil --payload-files "$target" 2>/dev/null | limit_output
                return
            fi
            ;;
        *.deb)
            if [ "$os_name" = Linux ] && have dpkg-deb; then
                dpkg-deb --contents "$target" 2>/dev/null | limit_output
                return
            fi
            ;;
        *.rpm)
            if [ "$os_name" = Linux ] && have rpm; then
                rpm -qpl "$target" 2>/dev/null | limit_output
                return
            fi
            ;;
    esac

    if have bsdtar && bsdtar -tf "$target" >/dev/null 2>&1; then
        bsdtar -tf "$target" 2>/dev/null | limit_output
    elif have tar && tar -tf "$target" >/dev/null 2>&1; then
        tar -tf "$target" 2>/dev/null | limit_output
    elif have unzip && unzip -tqq "$target" >/dev/null 2>&1; then
        unzip -l "$target" 2>/dev/null | limit_output
    elif have 7z && 7z t "$target" >/dev/null 2>&1; then
        7z l "$target" 2>/dev/null | limit_output
    elif have unrar && unrar t "$target" >/dev/null 2>&1; then
        unrar lb "$target" 2>/dev/null | limit_output
    else
        print_file_summary
    fi
}

preview_binary() {
    print_file_summary
    append_macos_metadata

    printf '\nFirst 1 KiB (hex):\n'
    if have xxd; then
        xxd -l 1024 "$target" 2>/dev/null | limit_output
    elif have hexdump; then
        hexdump -C -n 1024 "$target" 2>/dev/null | limit_output
    elif have od; then
        od -A x -t x1 -N 1024 "$target" 2>/dev/null | limit_output
    fi
}

if [ -z "$target" ]; then
    printf 'Usage: %s FILE\n' "${0##*/}" >&2
    exit 2
fi

# Keep option-like relative file names from being parsed as command options.
case "$target" in
    -*) target=./$target ;;
esac

if [ ! -e "$target" ] && [ ! -L "$target" ]; then
    printf 'Cannot preview %s: file does not exist.\n' "$target" >&2
    exit 1
fi

if [ -L "$target" ]; then
    link_target=$(readlink "$target" 2>/dev/null || printf '?')
    printf 'Symbolic link: %s -> %s\n\n' "$target" "$link_target"
    if [ ! -e "$target" ]; then
        print_metadata
        exit 0
    fi
fi

if [ -d "$target" ]; then
    preview_directory
    exit 0
fi

if [ ! -f "$target" ]; then
    print_metadata
    if have file; then
        file -- "$target" 2>/dev/null
    fi
    exit 0
fi

if [ ! -r "$target" ]; then
    print_metadata
    printf '\nFile is not readable.\n' >&2
    exit 1
fi

lower_name=$(printf '%s' "${target##*/}" | tr '[:upper:]' '[:lower:]')
if have file; then
    mime_type=$(file -b --mime-type -- "$target" 2>/dev/null || printf 'application/octet-stream')
    file_description=$(file -b -- "$target" 2>/dev/null || printf 'unknown')
else
    mime_type=application/octet-stream
    file_description=unknown
fi

case "$lower_name" in
    *.json|*.ipynb)
        if have jq && jq -e . "$target" >/dev/null 2>&1; then
            jq -C . "$target" 2>/dev/null | limit_output
        else
            preview_text
        fi
        ;;
    *.plist)
        if [ "$os_name" = Darwin ] && have plutil && plutil -lint "$target" >/dev/null 2>&1; then
            plutil -p -- "$target" 2>/dev/null | limit_output
        else
            preview_text
        fi
        ;;
    *.pdf)
        preview_pdf
        ;;
    *.doc|*.docx|*.odt|*.rtf)
        preview_document
        ;;
    *.epub|*.fb2|*.mobi|*.azw3)
        preview_ebook
        ;;
    *.xhtml|*.html|*.htm)
        preview_html
        ;;
    *.csv)
        preview_delimited ','
        ;;
    *.tsv)
        preview_delimited "$(printf '\t')"
        ;;
    *.tar|*.tar.gz|*.tgz|*.tar.bz|*.tar.bz2|*.tbz|*.tbz2|*.tar.xz|*.txz|*.tar.zst|*.tzst|*.zip|*.jar|*.war|*.rar|*.7z|*.gz|*.bz|*.bz2|*.xz|*.zst|*.lz|*.lzma|*.lzo|*.cpio|*.deb|*.rpm|*.cab|*.dmg|*.pkg)
        preview_archive
        ;;
    *)
        case "$mime_type" in
            image/svg+xml)
                if have chafa || have viu || have img2txt; then
                    preview_image
                else
                    preview_text
                fi
                ;;
            image/*)
                preview_image
                ;;
            audio/*|video/*)
                preview_media
                ;;
            text/*|application/json|application/xml|application/x-shellscript|application/javascript|application/sql)
                preview_text
                ;;
            application/pdf)
                preview_pdf
                ;;
            application/zip|application/x-tar|application/x-7z-compressed|application/vnd.rar|application/x-rar|application/gzip|application/x-bzip2|application/x-xz|application/zstd)
                preview_archive
                ;;
            *)
                case "$file_description" in
                    *text*|*script*) preview_text ;;
                    *) preview_binary ;;
                esac
                ;;
        esac
        ;;
esac

exit 0
