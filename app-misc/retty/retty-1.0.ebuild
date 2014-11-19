# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="retty is a tiny tool that lets you attach processes running on other terminals."
HOMEPAGE="http://pasky.or.cz/~pasky/dev/retty/"
SRC_URI="http://pasky.or.cz/~pasky/dev/retty/retty-1.0.tar.bz2"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	epatch "${FILESDIR}/make.patch"

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	
	dodoc README || die
}

