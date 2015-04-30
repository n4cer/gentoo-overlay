# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="drive is a tiny program to pull or push Google Drive files."
HOMEPAGE="https://github.com/odeke-em/drive"
SRC_URI="https://github.com/odeke-em/drive/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/go-1.2
		dev-vcs/git
		dev-vcs/mercurial"
RDEPEND=""

src_prepare() {
	export GOPATH="${PWD}"
	
	mkdir -p src/github.com/odeke-em/drive/
	ln -s ../../../../config src/github.com/odeke-em/drive/config
	ln -s ../../../../src src/github.com/odeke-em/drive/src

	go get code.google.com/p/goauth2/oauth
	go get github.com/cheggaaa/pb
	go get github.com/mattn/go-isatty
	go get github.com/odeke-em/cli-spinner
	go get github.com/odeke-em/google-api-go-client/drive/v2
	go get github.com/odeke-em/log
	go get github.com/odeke-em/statos
	go get github.com/odeke-em/xon/pkger/src
	go get github.com/rakyll/command
}

src_compile() {
	cd cmd/drive
	go build -o "${PN}" main.go
}

src_install() {
	dodoc README.md
	dobin "cmd/drive/${PN}"
}
