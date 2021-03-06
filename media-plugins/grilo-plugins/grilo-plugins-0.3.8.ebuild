# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit gnome2 python-any-r1 meson

DESCRIPTION="A framework for easy media discovery and browsing"
HOMEPAGE="https://wiki.gnome.org/Projects/Grilo"

LICENSE="LGPL-2.1+"
SLOT="0.3"
KEYWORDS="~alpha amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="daap dvd examples chromaprint flickr freebox gnome-online-accounts lua subtitles test thetvdb tracker upnp-av vimeo +youtube"

# Bump gom requirement to avoid segfaults
RDEPEND="
	>=dev-libs/glib-2.44:2
	>=media-libs/grilo-0.3.6:${SLOT}=[network,playlist]
	media-libs/libmediaart:2.0
	>=dev-libs/gom-0.3.2

	dev-libs/gmime:3.0
	dev-libs/json-glib
	dev-libs/libxml2:2
	dev-db/sqlite:3

	chromaprint? ( media-plugins/gst-plugins-chromaprint:1.0 )
	daap? ( >=net-libs/libdmapsharing-2.9.12:3.0 )
	dvd? ( >=dev-libs/totem-pl-parser-3.4.1 )
	flickr? ( net-libs/liboauth )
	freebox? ( net-dns/avahi )
	gnome-online-accounts? ( >=net-libs/gnome-online-accounts-3.17.91:= )
	lua? (
		>=dev-lang/lua-5.3
		app-arch/libarchive
		dev-libs/libxml2:2
		>=dev-libs/totem-pl-parser-3.4.1 )
	subtitles? ( net-libs/libsoup:2.4 )
	thetvdb? (
		app-arch/libarchive
		dev-libs/libxml2 )
	tracker? ( >=app-misc/tracker-0.10.5:= )
	youtube? (
		>=dev-libs/libgdata-0.9.1:=
		>=dev-libs/totem-pl-parser-3.4.1 )
	upnp-av? (
		net-libs/libsoup:2.4
		net-libs/dleyna-connector-dbus
		net-misc/dleyna-server )
	vimeo? (
		>=dev-libs/totem-pl-parser-3.4.1 )
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.5
	app-text/yelp-tools
	>=dev-util/gdbus-codegen-2.44
	>=dev-util/intltool-0.40.0
	virtual/pkgconfig
	lua? ( dev-util/gperf )
	upnp-av? ( test? (
		${PYTHON_DEPS}
		$(python_gen_any_dep 'dev-python/dbusmock[${PYTHON_USEDEP}]') ) )
"

python_check_deps() {
	use upnp-av && use test && has_version "dev-python/dbusmock[${PYTHON_USEDEP}]"
}

pkg_setup() {
	use upnp-av && use test && python-any-r1_pkg_setup
}

src_configure() {
        local emesonargs=(
            -Denable-bookmarks="yes"
            -Denable-filesystem="yes"
            -Denable-gravatar="yes"
            -Denable-jamendo="yes"
            -Denable-local-metadata="yes"
            -Denable-magnatune="yes"
            -Denable-metadata-store="yes"
            -Denable-podcasts="yes"
            -Denable-raitv="yes"
            -Denable-shoutcast="no"
            -Denable-tmdb="yes"
            
            -Dchromaprint=$(usex chromaprint "yes" "no")
            -Ddmap=$(usex daap "yes" "no")
            -Doptical-media=$(usex dvd "yes" "no")
            -Dflickr=$(usex flickr "yes" "no")
            -Dfreebox=$(usex freebox "yes" "no")
            -Dlua-factory=$(usex lua "yes" "no")
            -Dopensubtitles=$(usex subtitles "yes" "no")
            -Dthetvdb=$(usex thetvdb "yes" "no")
            -Dtracker=$(usex tracker "yes" "no")
            -Ddleyna=$(usex upnp-av "yes" "no")
            -Dvimeo=$(usex vimeo "yes" "no")
            -Dyoutube=$(usex youtube "yes" "no")
        )
	meson_src_configure
}

src_install() {
	meson_src_install
}
