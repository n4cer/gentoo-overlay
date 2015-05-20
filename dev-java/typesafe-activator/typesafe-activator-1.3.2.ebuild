# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils user versionator

DESCRIPTION="Typesafe Activator and sbt get you started with the Typesafe Reactive Platform"
HOMEPAGE="https://www.typesafe.com"

SRC_URI="minimal? ( http://downloads.typesafe.com/typesafe-activator/${PV}/typesafe-activator-${PV}-minimal.zip )
	!minimal? ( http://downloads.typesafe.com/typesafe-activator/${PV}/typesafe-activator-${PV}.zip )"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="minimal"

DEPEND=">=virtual/jdk-1.6"

RDEPEND=">=virtual/jre-1.6"

if use minimal ; then
	S="${WORKDIR}/activator-${PV}-minimal"
else
	S="${WORKDIR}/activator-${PV}"
fi

pkg_setup() {
	enewgroup typesafedevelopers
}

src_install() {
	dodir "/opt"
	cp -a "${S}/" "${D}/opt/${PN}"

	fowners -R root:typesafedevelopers /opt/${PN}
	fperms -R 770 /opt/${PN}
	make_wrapper "activator" "/opt/${PN}/activator"
	elog "You must be in the typesafedevelopers group to use typesafe-activator."
}
