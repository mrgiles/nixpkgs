{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  mesonEmulatorHook,
  ninja,
  pkg-config,
  gtk-doc,
  docbook-xsl-nons,
  docbook_xml_dtd_43,
  wayland-protocols,
  wayland-scanner,
  wayland,
  gtk4,
  gobject-introspection,
  vala,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gtk4-layer-shell";
  version = "1.1.0";

  outputs = [
    "out"
    "dev"
    "devdoc"
  ];
  outputBin = "devdoc";

  src = fetchFromGitHub {
    owner = "wmww";
    repo = "gtk4-layer-shell";
    rev = "v${finalAttrs.version}";
    hash = "sha256-UGhFeaBBIfC4ToWdyoX+oUzLlqJsjF++9U7mtszE0y0=";
  };

  strictDeps = true;

  depsBuildBuild = [
    pkg-config
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gobject-introspection
    gtk-doc
    docbook-xsl-nons
    docbook_xml_dtd_43
    vala
    wayland-scanner
  ] ++ lib.optionals (!stdenv.buildPlatform.canExecute stdenv.hostPlatform) [ mesonEmulatorHook ];

  buildInputs = [
    gtk4
    wayland
    wayland-protocols
  ];

  mesonFlags = [
    "-Ddocs=true"
    "-Dexamples=true"
  ];

  meta = with lib; {
    description = "Library to create panels and other desktop components for Wayland using the Layer Shell protocol and GTK4";
    mainProgram = "gtk4-layer-demo";
    license = licenses.mit;
    maintainers = with maintainers; [ donovanglover ];
    platforms = platforms.linux;
  };
})
