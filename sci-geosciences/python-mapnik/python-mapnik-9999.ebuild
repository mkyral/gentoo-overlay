# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 git-2

DESCRIPTION="Python bindings for Mapnik"
HOMEPAGE="https://github.com/mapnik/python-mapnik"
EGIT_REPO_URI="https://github.com/mapnik/python-mapnik.git"

# for compatibility with v3.0.12
EGIT_COMMIT="ea5fd113504bd789fdd450ba5abf0474bd841106"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/boost-1.48[threads,python]
	>=sci-geosciences/mapnik-3.0.5"

DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/python-mapnik-9999-novars.patch" )

python_compile() {
	BOOST_PYTHON_LIB="boost_python-$(echo $EPYTHON | sed 's/python//')" distutils-r1_python_compile
}

python_install() {
	BOOST_PYTHON_LIB="boost_python-$(echo $EPYTHON | sed 's/python//')" distutils-r1_python_install
}
