# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="	git://repo.or.cz/qgit4/redivivus.git"

[[ ${PV} == 9999 ]] && git_eclass=git-2

inherit eutils ${git_eclass} qmake-utils
echo $git_eclass
unset git_eclass


DESCRIPTION="Qt4 GUI for git repositories"
HOMEPAGE="http://libre.tibirna.org/projects/qgit/wiki/QGit"

[[ ${PV} == 9999 ]] || SRC_URI="http://dev.gentoo.org/~pesa/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="
        dev-qt/qtcore:5
        dev-qt/qtgui:5
        dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}
        dev-vcs/git
        !dev-vcs/qgit:2
"

#S=${WORKDIR}/redivivus

src_prepare() {
        default

        # respect CXXFLAGS
        sed -i -e '/CONFIG\s*+=/s/debug_and_release//' \
                -e '/QMAKE_CXXFLAGS.*+=/d' \
                src/src.pro || die
}

src_configure() {
        eqmake5
}

src_install() {
        dobin bin/qgit
        doicon src/resources/qgit.png
        make_desktop_entry qgit QGit qgit
        einstalldocs
}
