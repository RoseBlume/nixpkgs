{ lib
, stdenv
, fetchFromGitHub
, wrapQtAppsHook
, pkg-config
, qmake
, qtwayland
, qtsvg
, postgresql
}:

stdenv.mkDerivation rec {
  pname = "pgmodeler";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "pgmodeler";
    repo = "pgmodeler";
    rev = "v${version}";
    sha256 = "sha256-SlAYl2x1qdBBwLboO59h1uifF7Q71oX3JyhWwUogdb0=";
  };

  nativeBuildInputs = [ pkg-config qmake wrapQtAppsHook ];
  qmakeFlags = [ "pgmodeler.pro" "CONFIG+=release" ];

  # todo: libpq would suffice here. Unfortunately this won't work, if one uses only postgresql.lib here.
  buildInputs = [ postgresql qtsvg qtwayland ];

  meta = with lib; {
    description = "A database modeling tool for PostgreSQL";
    homepage = "https://pgmodeler.io/";
    license = licenses.gpl3;
    maintainers = [ maintainers.esclear ];
    platforms = platforms.linux;
  };
}
