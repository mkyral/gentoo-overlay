# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit git-r3 qmake-utils

MY_P=${PN}-${PV%0}

EGIT_REPO_URI="https://gitlab.labs.nic.cz/turris/spectator.git"

DESCRIPTION="Desktop application to monitor router Turris"
HOMEPAGE="https://gitlab.labs.nic.cz/turris/spectator"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
      >=dev-qt/qtcore-5.2.1
      >=dev-qt/qtdeclarative-5.2.1
      >=dev-qt/qtgui-5.2.1
      >=dev-qt/qtnetwork-5.2.1
      >=dev-qt/qtprintsupport-5.2.1
      >=dev-qt/qttranslations-5.2.1
      >=dev-qt/qtwidgets-5.2.1
      >=dev-qt/qtxml-5.2.1
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
        git-r3_src_unpack
}

src_configure() {
  eqmake5 PREFIX=/usr ${PN}.pro
}

src_compile() {
        emake
}

src_install() {
        emake INSTALL_ROOT="${D}" install
}
