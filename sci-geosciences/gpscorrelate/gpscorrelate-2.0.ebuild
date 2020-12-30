# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop toolchain-funcs

DESCRIPTION="Tool for adjusting EXIF tags of your photos with a recorded GPS trace"
HOMEPAGE="https://dfandrich.github.io/gpscorrelate"
SRC_URI="https://github.com/dfandrich/gpscorrelate/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="doc gtk"

BDEPEND="
	app-text/docbook-xml-dtd:4.2
	dev-libs/libxslt
	virtual/pkgconfig
"
DEPEND="
	dev-libs/libxml2:2
	media-gfx/exiv2:=
	gtk? ( x11-libs/gtk+:3 )
"
DEPEND="${DEPEND}"

src_compile() {
	tc-export CC CXX
	local opts="gpscorrelate doc/gpscorrelate.1"
	use gtk && opts+=" gpscorrelate-gui BUILD_GUI=1"
	emake ${opts}
}

src_install() {
	dobin ${PN}
	if use gtk; then
		dobin ${PN}-gui
		doicon ${PN}-gui.svg
		domenu ${PN}.desktop
	fi
	if use doc; then
		rm doc/gpscorrelate-manpage.xml* || die
		local DOCS=()
		local HTML_DOCS=( doc/. )
		einstalldocs
	fi
	doman doc/${PN}.1
}
