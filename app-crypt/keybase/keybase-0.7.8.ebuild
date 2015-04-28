# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Client for keybase.io"
HOMEPAGE="https://keybase.io/"
SRC_URI="https://github.com/keybase/node-client/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=net-libs/nodejs-0.10.30
	>=app-crypt/gnupg-2.0.26-r3"

S=${WORKDIR}/node-client-${PV}

src_compile() { :; }

src_install() {
	insinto "/opt/${PN}"
	doins -r .
	fperms +x "/opt/${PN}/bin/main.js"
	make_wrapper keybase ./main.js /opt/keybase/bin
}
