EAPI=8

MY_PV=$(ver_rs 1- -)
DESCRIPTION="Compatibility tool for Steam Play based on Wine and additional components (binary)"
HOMEPAGE="https://github.com/GloriousEggroll/proton-ge-custom"
SRC_URI="https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${MY_PV}/GE-Proton${MY_PV}.tar.gz"
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
    sed -i -r 's|"GE-Proton.*"|"Proton-GE"|' "${WORKDIR}/GE-Proton${MY_PV}/compatibilitytool.vdf"
}

src_install() {
    insinto "${DESTDIR}/${PROTON_DIR}"
    insopts -m755
    doins -r "${WORKDIR}/GE-Proton${MY_PV}"/*
}
