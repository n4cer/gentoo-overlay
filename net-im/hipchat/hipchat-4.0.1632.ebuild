# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
inherit eutils unpacker

DESCRIPTION="A Hipchat client"
HOMEPAGE="http://www.hipchat.com/"

SRC_URI="https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client/pool/HipChat4-${PV}-Linux.deb"

LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND="media-libs/gst-plugins-base:0.10"

S=${WORKDIR}

src_install() {
	doins -r *
	fperms -R 0755 \
		/opt/HipChat4/bin/ \
		/opt/HipChat4/lib/HipChat.bin \
		/opt/HipChat4/lib/QtWebEngineProcess.bin
}
