# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="THe Experimental RAw Photo Editor"
HOMEPAGE="http://www.rawtherapee.com/"

EGIT_REPO_URI="https://github.com/Beep6581/RawTherapee.git"

LICENSE="GPL-3"
SLOT='0'
KEYWORDS=""
IUSE="+openmp gtk3"

DEPEND="
	gtk3? ( dev-cpp/gtkmm:3.0 ) !gtk3? ( dev-cpp/gtkmm:2.4 )
	media-libs/libcanberra
	media-libs/lcms
	media-libs/libiptcdata
	media-libs/libpng
	dev-libs/libsigc++:2
	media-libs/tiff
	media-gfx/exiv2
	openmp? ( >=sys-devel/gcc-4.9[openmp] )
	sci-libs/fftw:3.0
	sys-libs/zlib
	virtual/jpeg
	"
RDEPEND="${DEPEND}"

pre_pkg_setup() {
  use gtk3 && EGIT_BRANCH="gtk3"
}

