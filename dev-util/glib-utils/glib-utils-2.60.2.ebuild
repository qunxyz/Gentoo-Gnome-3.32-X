# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_5,3_6,3_7} )
GNOME_ORG_MODULE="glib"

SRC_URI=""
DESCRIPTION="Build utilities for GLib using projects"
HOMEPAGE="https://www.gtk.org/"

LICENSE="LGPL-2.1+"
SLOT="0" # /usr/bin utilities that can't be parallel installed by their nature
IUSE=""

KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x64-cygwin ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"

RDEPEND="
	!<dev-libs/glib-2.56.2:2
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
"
