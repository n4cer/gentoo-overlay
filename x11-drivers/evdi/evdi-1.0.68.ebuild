# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 linux-mod

DESCRIPTION="Extensible Virtual Display Interface"
HOMEPAGE="https://github.com/DisplayLink/evdi"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

EGIT_REPO_URI="git://github.com/DisplayLink/evdi.git"
EGIT_COMMIT="v${PV}"

DEPEND="x11-libs/libdrm
	sys-kernel/linux-headers"
RDEPEND="x11-libs/libdrm"

MODULE_NAMES="evdi(video:${S}/module)"

#https://jira.hossie.de/browse/GOV-15
CONFIG_CHECK="FB_VIRTUAL ~!INTEL_IOMMU"

pkg_setup() {
	linux-mod_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/evdi-1.0.68-linux-4.5.0.patch"
}

src_compile() {
	linux-mod_src_compile
	cd "${S}/library"
	sed -i 's#<drm/drm\.h#<libdrm/drm.h#g' ../module/evdi_ioctl.h
	default
}

src_install() {
	linux-mod_src_install
	dolib.so library/libevdi.so
}
