# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils eutils

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/tora-tool/tora.git"
	inherit git-r3
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
fi

DESCRIPTION="TOra - Toolkit For Oracle"
HOMEPAGE="http://torasql.com/"
IUSE="debug mysql oracle oci8-instant-client postgres"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""

DEPEND="
	oci8-instant-client? ( dev-db/oracle-instantclient-basic )
	postgres? ( dev-db/postgresql )
    dev-libs/boost
	dev-libs/ferrisloki
	dev-qt/qtgui:5
	dev-qt/qtsql:5[mysql?,postgres?]
	dev-qt/qtxmlpatterns:5
	virtual/pkgconfig
	x11-libs/qscintilla
"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ( use oracle || use oci8-instant-client ) && [ -z "$ORACLE_HOME" ] ; then
		eerror "ORACLE_HOME variable is not set."
		eerror
		eerror "You must install Oracle >= 8i client for Linux in"
		eerror "order to compile TOra with Oracle support."
		eerror
		eerror "Otherwise specify -oracle in your USE variable."
		eerror
		eerror "You can download the Oracle software from"
		eerror "http://otn.oracle.com/software/content.html"
		die
	fi
}

src_prepare() {
    #epatch_user
    eapply_user
	sed -i \
		-e "/COPYING/ d" \
		CMakeLists.txt || die "Removal of COPYING file failed"
	grep -rlZ '$$ORIGIN' . | xargs -0 sed -i 's|:$$ORIGIN[^:"]*||' || \
		die 'Removal of $$ORIGIN failed'
}

src_configure() {
	local mycmakeargs=()
	if use oracle || use oci8-instant-client ; then
		mycmakeargs=(-DENABLE_ORACLE=ON)
	else
		mycmakeargs=(-DENABLE_ORACLE=OFF)
	fi

	if use debug ; then
        mycmakeargs=(-DCMAKE_BUILD_TYPE=Debug)
	else
        mycmakeargs=(-DCMAKE_BUILD_TYPE=Release)
	fi

	mycmakeargs+=(
		-DWANT_RPM=OFF
		-DWANT_BUNDLE=OFF
		-DWANT_BUNDLE_STANDALONE=OFF
		-DWANT_INTERNAL_QSCINTILLA=ON
		-DWANT_INTERNAL_LOKI=OFF
		-DLOKI_LIBRARY="$(pkg-config --variable=libdir ferrisloki)/libferrisloki.so"
		-DLOKI_INCLUDE_DIR="$(pkg-config --variable=includedir ferrisloki)/FerrisLoki"
		-DENABLE_PGSQL="$(usex postgres)"
		# path variables
		-DTORA_DOC_DIR=share/doc/${PF}
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	doicon src/icons/${PN}.xpm
	domenu src/${PN}.desktop
}
