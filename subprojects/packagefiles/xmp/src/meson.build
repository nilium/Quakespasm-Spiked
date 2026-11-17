xmp_sources = files(
  'control.c',
  'dataio.c',
  'effects.c',
  'extras.c',
  'far_extras.c',
  'filetype.c',
  'filter.c',
  'flow.c',
  'flt_extras.c',
  'format.c',
  'hio.c',
  'hmn_extras.c',
  'lfo.c',
  'load.c',
  'load_helpers.c',
  'md5.c',
  'med_extras.c',
  'memio.c',
  'miniz_tinfl.c',
  'misc.c',
  'mix_all.c',
  'mix_paula.c',
  'mixer.c',
  'mkstemp.c',
  'path.c',
  'period.c',
  'player.c',
  'read_event.c',
  'rng.c',
  'scan.c',
  'smix.c',
  'tempfile.c',
  'virtual.c',
  'win32.c',
)

subdir('depackers')
subdir('loaders')

c_args = [
  '-DLIBXMP_DEFINES=_REENTRANT',
  '-DXMP_SYM_VISIBILITY',
]

if meson.get_compiler('c').get_id() == 'msvc'
  c_args = [
    '-DLIBXMP_DEFINES=_USE_MATH_DEFINES',
  ]
endif

libxmp = library(
  'xmp',
  xmp_sources,
  c_args : c_args,
  c_static_args : ['-DLIBXMP_STATIC'],
  include_directories : include_dirs,
  install : true,
)

libxmp_dep = declare_dependency(
  link_with: libxmp,
  include_directories : include_dirs,
)
