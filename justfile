default_app := 'Quakespasm'

help:
    just --list

[macos]
setup $app=default_app:
    mkdir -p "tmp/${app}.app"
    meson setup build --prefix={{ quote(justfile_directory() / ('tmp/' + app +  '.app')) }} --bindir=Contents/MacOS --reconfigure

compile:
    meson compile -C build

install:
    meson install -C build

clean:
    ninja -C build clean

[macos]
build app=default_app: (setup app) (compile) (install)

