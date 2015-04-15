# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Client for keybase.io"
HOMEPAGE="https://keybase.io/"
SRC_URI="https://github.com/keybase/node-client/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=net-libs/nodejs-0.10.30
	>=app-crypt/gnupg-2.0.26-r3"

src_unpack() {
	unpack "${P}.tar.gz"
	mv "node-client-${PV}" "${P}"
}

src_install() {
	insinto "/opt/${PN}"
	doins -r . || die
	chmod +x "${D}/opt/keybase/bin/main.js" || die
	make_wrapper keybase ./main.js /opt/keybase/bin
}
