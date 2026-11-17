project('mad', 'c', license : 'GPL-2.0-or-later')

mod = import('unstable-external_project')

run_command('autoreconf', '-i', check : true, console : true)

mad = mod.add_project(
  'configure',
  configure_options : [
    '--prefix=@PREFIX@',
    '--libdir=@PREFIX@/@LIBDIR@',
    '--includedir=@PREFIX@/@INCLUDEDIR@',
    '--disable-shared',
    '--enable-static',
  ],
  depends : [
    dependency('flac'),
  ],
)


mad_dep = mad.dependency('mad')
meson.override_dependency('mad', mad_dep)
