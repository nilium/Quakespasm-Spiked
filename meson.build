project(
  'quakespasm-spiked',
  'c',
  meson_version : '>= 1.3.0',
  version : '0.96.0',
  default_options : {
    'warning_level' : '3',
    'c_std' : 'gnu2y',
  },
)

cmake = import('cmake')

compiler = meson.get_compiler('c')
machine = host_machine
is_darwin = machine.system() == 'darwin'
is_windows = machine.system() == 'windows'
is_linux = machine.system() == 'linux'
is_unix = machine.system() in ['linux', 'freebsd', 'openbsd', 'netbsd', 'dragonfly']

ogg = subproject('ogg')
vorbis = subproject('vorbis')
flac = subproject('flac')
sdl = subproject(
  'sdl2',
  default_options : {
    'use_atomic' :                 'enabled',
    'use_audio' :                  'enabled',
    'use_cpuinfo' :                'disabled',
    'use_events' :                 'enabled',
    'use_file' :                   'disabled',
    'use_filesystem' :             'disabled',
    'use_haptic' :                 'enabled',
    'use_hidapi' :                 'enabled',
    'use_joystick' :               'enabled',
    'use_loadso' :                 'enabled',
    'use_locale' :                 'enabled',
    'use_power' :                  'auto',
    'use_render' :                 'enabled',
    'use_sensor' :                 'enabled',
    'system_iconv' :               'auto',
    'use_threads' :                'enabled',
    'use_timers' :                 'enabled',
    'use_video' :                  'enabled',

    'use_video_x11' :              is_unix ? 'enabled' :  'disabled',
    'use_video_wayland' :          is_linux ? 'enabled' : 'disabled',
    'use_video_wayland_libdecor' : is_linux ? 'enabled' : 'disabled',
    'use_video_opengl' :           'enabled',
    'use_video_openglesv2' :       'disabled',
    'use_video_vulkan' :           (is_linux or is_windows) ? 'enabled' : 'disabled',
    'use_video_offscreen' :        'disabled',
  },
)
xmp = subproject('xmp')
mad = subproject('mad')

dependencies = [
  dependency('ogg'),
  dependency('vorbis'),
  dependency('vorbisfile'),
  dependency('flac'),
  dependency('sdl2'),
  dependency('xmp', fallback : ['xmp', 'libxmp_dep']),
  dependency('mad'),
  dependency('zlib', fallback : 'zlib-ng', default_options: { 'zlib-compat' : true }),
]

sources = []
c_args = []

pak_dir = get_option('game_dir')

if is_darwin
  subdir('MacOSX')
elif is_windows
  subdir('Windows')
elif is_unix
  subdir('Linux')
endif
subdir('Quake')
