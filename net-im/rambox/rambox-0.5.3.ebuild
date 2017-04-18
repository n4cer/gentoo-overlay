# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Rambox is a free messaging app and combines chat and messaging services into one application."
HOMEPAGE="http://rambox.pro"

SRC_URI_AMD64="https://github.com/saenzramiro/${PN}/releases/download/${PV}/${P}-x64.tar.gz"
SRC_URI_X86="https://github.com/saenzramiro/${PN}/releases/download/${PV}/${P}-ia32.tar.gz"
SRC_URI="
	amd64? ( ${SRC_URI_AMD64} )
	x86? ( ${SRC_URI_X86} )
"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"

RESTRICT="strip mirror"

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/alsa-lib
	app-shells/bash
	dev-util/desktop-file-utils
	gnome-base/gconf
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	x11-libs/libXScrnSaver
"

S="${WORKDIR}/Rambox-${PV}"

src_install() {
	dodir "/opt/${PN}"

	insinto "/opt/${PN}/"
	doins -r "${S}"/* || die "Could not install!"

	exeinto "/opt/${PN}/"
	doexe "${S}/${PN}"

	dosym "/opt/${PN}/${PN}" /usr/bin/${PN}

	domenu "${FILESDIR}/rambox.desktop"
	doicon "${FILESDIR}/${PN}.png"
}
