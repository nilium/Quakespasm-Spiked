help:
    just --list

[macos]
build $app='Quakespasm':
    mkdir -p "tmp/${app}.app"
    meson setup build --prefix={{ quote(justfile_directory() / ('tmp/' + app +  '.app')) }} --bindir=Contents/MacOS --reconfigure
    meson compile -C build
    meson install -C build

