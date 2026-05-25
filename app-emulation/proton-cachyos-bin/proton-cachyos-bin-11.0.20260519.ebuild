EAPI=8

MY_PV=$(ver_rs 2 -)
DESCRIPTION="Compatibility tool for Steam Play based on Wine and additional components (binary)"
HOMEPAGE="https://github.com/CachyOS/proton-cachyos"
SRC_URI="https://github.com/CachyOS/proton-cachyos/releases/download/cachyos-${MY_PV}-slr/proton-cachyos-${MY_PV}-slr-x86_64_v3.tar.xz"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip mirror"
IUSE=""
DEPEND=""
RDEPEND=""
BDEPEND=""
S="${WORKDIR}"
PROTON_DIR="usr/share/steam/compatibilitytools.d/${PN}"

src_prepare() {
    eapply_user
    # Remove versioning
    sed -i -r 's|"proton-cachyos-.*"|"Proton-CachyOS"|' "${WORKDIR}/proton-cachyos-${MY_PV}-slr-x86_64_v3/compatibilitytool.vdf"
}

src_install() {
    insinto "${DESTDIR}/${PROTON_DIR}"
    insopts -m755
    doins -r "${WORKDIR}/proton-cachyos-${MY_PV}-slr-x86_64_v3"/*
}
