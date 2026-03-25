EAPI=8

inherit desktop

MY_PV="${PV//.}"
DESCRIPTION="Feature packed cross-platform music tracker (binary)"
HOMEPAGE="https://github.com/kawaiiDango/pano-scrobbler"
SRC_URI="
	amd64? ( https://github.com/kawaiiDango/pano-scrobbler/releases/download/${MY_PV}/pano-scrobbler-linux-x64.tar.gz -> pano-scrobbler-linux-x64-${PV}.tar.gz )
	arm64? ( https://github.com/kawaiiDango/pano-scrobbler/releases/download/${MY_PV}/pano-scrobbler-linux-arm64.tar.gz -> pano-scrobbler-linux-arm64-${PV}.tar.gz )
"
LICENSE="GPL-3.0-or-later"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip mirror"
IUSE="+login"
DEPEND=""
RDEPEND="
    ${DEPEND}
    login? ( net-libs/webkit-gtk:4.1/0 )
"
BDEPEND=""
S="${WORKDIR}"

src_prepare() {
    eapply_user
    # Patch desktop entry
    sed -i 's/^Name=.*/Name=Pano Scrobbler (bin)/' "${WORKDIR}/pano-scrobbler.desktop"
    sed -i 's/^Exec=.*/Exec=\/usr\/bin\/pano-scrobbler-bin %U/' "${WORKDIR}/pano-scrobbler.desktop"
    sed -i 's/^Icon=.*/Icon=pano-scrobbler-bin/' "${WORKDIR}/pano-scrobbler.desktop"
    mv "${WORKDIR}/pano-scrobbler.desktop" "${WORKDIR}/pano-scrobbler-bin.desktop"
    mv "${WORKDIR}/pano-scrobbler.svg" "${WORKDIR}/pano-scrobbler-bin.svg"
}

src_install() {
    # Main executable
    exeinto "${DESTDIR}/opt/pano-scrobbler-bin"
    exeopts -m755
    doexe "${WORKDIR}/pano-scrobbler"
    # Libraries
    exeopts -m644
    doexe "${WORKDIR}/"*.so
    exeinto "${DESTDIR}/opt/pano-scrobbler-bin/lib"
    doexe "${WORKDIR}/lib/"*.so
    # Symlink main executable
    dosym "${DESTDIR}/opt/pano-scrobbler-bin/pano-scrobbler" "/usr/bin/pano-scrobbler-bin"
    # Desktop
    domenu "${WORKDIR}/pano-scrobbler-bin.desktop"
    # Icon
    doicon "${WORKDIR}/pano-scrobbler-bin.svg"
}
