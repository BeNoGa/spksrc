COMMANDS="jdupes less lessecho lesskey tree ed2k-link edonr256-hash edonr512-hash ghost-hash has160-hash magnet-link"
COMMANDS+="rhash sfv-hash tiger-hash tth-hash whirlpool-hash rename nano rnano"

service_postinst ()
{
    for cmd in $COMMANDS
    do
        if [ -e "${SYNOPKG_PKGDEST}/bin/$cmd" ]; then
            ln -s "${SYNOPKG_PKGDEST}/bin/$cmd" "/usr/local/bin/$cmd"
        fi
    done

    # Set custom links for midnight commander
    ln -s ${SYNOPKG_PKGDEST}/bin/mc-utf8 /usr/local/bin/mc
    ln -s ${SYNOPKG_PKGDEST}/bin/mc-utf8 /usr/local/bin/mcedit
    ln -s ${SYNOPKG_PKGDEST}/bin/mc-utf8 /usr/local/bin/mcdiff
    ln -s ${SYNOPKG_PKGDEST}/bin/mc-utf8 /usr/local/bin/mcview

    # rename requires perl modules to be linked into local installation
    ln -s "${SYNOPKG_PKGDEST}/share/perl5/File/Rename.pm" "/usr/local/share/perl5/vendor_perl/File/Rename.pm"
    mkdir "/usr/local/share/perl5/vendor_perl/File/Rename"
    ln -s "${SYNOPKG_PKGDEST}/share/perl5/File/Rename/Options.pm" "/usr/local/share/perl5/vendor_perl/File/Rename/Options.pm"
}

service_postuninst ()
{
    for cmd in $COMMANDS
        do
        if [ -e "/usr/local/bin/$cmd" ]; then
            rm -f "/usr/local/bin/$cmd"
        fi
    done

    # Remove custom links for midnight commander
    rm -f /usr/local/bin/mc
    rm -f /usr/local/bin/mcedit
    rm -f /usr/local/bin/mcdiff
    rm -f /usr/local/bin/mcview

    # Remove rename's perl modules from the local installation
    if [ -e "/usr/local/share/perl5/vendor_perl/File/Rename.pm" ]; then
        rm -f "/usr/local/share/perl5/vendor_perl/File/Rename.pm"
    fi
    if [ -e "/usr/local/share/perl5/vendor_perl/File/Rename/Options.pm" ]; then
        rm -f "/usr/local/share/perl5/vendor_perl/File/Rename/Options.pm"
        rmdir "/usr/local/share/perl5/vendor_perl/File/Rename"
    fi
}
