# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils gnome2-utils xdg
DESCRIPTION="Free, Open Source and Cross Platform messaging and emailing app"
HOMEPAGE="http://rambox.pro/"
SRC_URI="https://github.com/saenzramiro/rambox/releases/download/${PV}/Rambox-${PV}-linux-x64.tar.gz
	x86? ( https://github.com/saenzramiro/rambox/releases/download/${PV}/Rambox-${PV}-linux-ia32.tar.gz )"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-3"
DEPEND=""
RDEPEND="dev-libs/expat
	dev-libs/libappindicator
	dev-libs/nss
	gnome-base/gconf
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/libpng
	net-print/cups
	net-libs/gnutls
	sys-libs/zlib
	x11-libs/gtk+
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/libXtst"

src_unpack() {
	unpack ${A}
	if use x86; then
	    S="${WORKDIR}/Rambox-${PV}-linux-ia32"
	else
	    S="${WORKDIR}/Rambox-${PV}-linux-x64"
	fi
}

src_install() {
	local destdir="/opt/${PN}"
	insinto $destdir
	doins -r locales resources
	doins	chrome_100_percent.pak \
		chrome_200_percent.pak \
		resources.pak \
		icudtl.dat \
		natives_blob.bin \
		v8_context_snapshot.bin \
		snapshot_blob.bin \
		libEGL.so \
		libGLESv2.so \
		libVkICD_mock_icd.so \
		libffmpeg.so
	exeinto $destdir
	doexe rambox
	doicon -s 128 "$FILESDIR"/ico/rambox.png
	dosym $destdir/rambox /usr/bin/rambox-bin
	make_desktop_entry rambox-bin Rambox "rambox" Network
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
