ogg = subproject('ogg')
vorbis = subproject('vorbis')
flac = subproject('flac')
xmp = subproject('xmp')
mad = subproject('mad')

sdl = subproject(
  'sdl2',
  default_options : {
    'use_atomic':                 'enabled',
    'use_audio':                  'enabled',
    'use_cpuinfo':                'disabled',
    'use_events':                 'enabled',
    'use_file':                   'disabled',
    'use_filesystem':             'disabled',
    'use_haptic':                 'enabled',
    'use_hidapi':                 'enabled',
    'use_joystick':               'enabled',
    'use_loadso':                 'enabled',
    'use_locale':                 'enabled',
    'use_power':                  'auto',
    'use_render':                 'enabled',
    'use_sensor':                 'enabled',
    'system_iconv':               'auto',
    'use_threads':                'enabled',
    'use_timers':                 'enabled',
    'use_video':                  'enabled',

    'use_video_x11':              is_unix ? 'enabled' :  'disabled',
    'use_video_wayland':          is_linux ? 'enabled' : 'disabled',
    'use_video_wayland_libdecor': is_linux ? 'enabled' : 'disabled',
    'use_video_opengl':           'enabled',
    'use_video_openglesv2':       'disabled',
    'use_video_vulkan':           (is_linux or is_windows) ? 'enabled' : 'disabled',
    'use_video_offscreen':        'disabled',
  },
)

luau_options = cmake.subproject_options()
luau_options.add_cmake_defines({
  'LUAU_BUILD_CLI' : 'OFF',
  'LUAU_BUILD_TESTS' : 'OFF',
  'LUAU_BUILD_SHARE' : 'OFF',
  'LUAU_EXTERN_C' : 'ON',
})
luau = cmake.subproject('luau', options : luau_options)

dependencies += [
  dependency('ogg'),
  dependency('vorbis'),
  dependency('vorbisfile'),
  dependency('flac'),
  dependency('sdl2'),
  dependency('xmp', fallback : ['xmp', 'libxmp_dep']),
  dependency('mad'),
  dependency('zlib', fallback : 'zlib-ng', default_options: { 'zlib-compat': true }),
  luau.dependency('Luau.VM'),
  luau.dependency('Luau.Compiler'),
]

if is_unix
  dependencies += dependency('m')
endif

sources += files(
  # Music
  'bgmusic.c',
	'snd_codec.c',
	'snd_flac.c',
	'snd_wave.c',
	'snd_vorbis.c',
	'snd_opus.c',
	'snd_mp3.c',
	'snd_mp3tag.c',
	'snd_mikmod.c',
	'snd_modplug.c',
	'snd_xmp.c',
	'snd_umx.c',

	# Sound
	'snd_voip.c',
  'snd_dma.c',
  'snd_mix.c',
  'snd_mem.c',
	'snd_sdl.c',

  # Input
  'in_sdl.c',

  # Graphics
	'gl_refrag.c',
	'gl_rlight.c',
	'gl_rmain.c',
	'gl_fog.c',
	'gl_rmisc.c',
	'r_part.c',
	'r_part_fte.c',
	'r_world.c',
	'gl_screen.c',
	'gl_sky.c',
	'gl_warp.c',
  'gl_vidsdl.c',
	'gl_draw.c',
	'image.c',
	'gl_texmgr.c',
	'gl_mesh.c',
	'r_sprite.c',
	'r_alias.c',
	'r_brush.c',
	'gl_model.c',

  # Network
  'net_bsd.c',
  'net_udp.c',
  # Quake
	'strlcat.c',
	'strlcpy.c',
	'net_dgrm.c',
	'net_loop.c',
	'net_main.c',
	'chase.c',
	'cl_demo.c',
	'cl_input.c',
	'cl_main.c',
	'cl_parse.c',
	'cl_tent.c',
	'console.c',
	'keys.c',
	'menu.c',
	'sbar.c',
	'view.c',
	'wad.c',
	'cmd.c',
	'common.c',
	'mdfour.c',
	'fs_zip.c',
	'crc.c',
	'cvar.c',
	'cfgfile.c',
	'host.c',
	'host_cmd.c',
	'mathlib.c',
	'pr_cmds.c',
	'pr_ext.c',
	'pr_edict.c',
	'pr_exec.c',
	'pmove.c',
	'pmovetst.c',
	'sv_main.c',
	'sv_move.c',
	'sv_phys.c',
	'sv_user.c',
	'world.c',
	'zone.c',
  # Main
  'main_sdl.c',
)

if is_darwin
  sources += files(
    'pl_osx.m',
    'sys_sdl_unix.c',
  )
endif

c_args += [
  '-DDO_USERDIRS=1',
  '-D_FILE_OFFSET_BITS=64',
  '-DGL_SILENCE_DEPRECATION=1',
  '-DUSE_SDL2=1',
  '-DUSE_CODEC_WAVE=1',
  '-DUSE_CODEC_VORBIS=1',
  '-DUSE_CODEC_FLAC=1',
  '-DUSE_CODEC_XMP=1',
  '-DUSE_ZLIB=1',
  '-DNO_SDL_CONFIG=1',
  '-DLUA_API=extern',
  '-DLUACODE_API=extern',
]

subdir('ice')

version_parts = meson.project_version().split('.')
version_suffix = get_option('version_suffix')
if version_suffix != ''
  c_args += ['-DQUAKESPASM_VER_SUFFIX=' + version_suffix]
endif

configure_file(
  # build_subdir : 'Quake',
  configuration : {
    'QUAKESPASM_VERSION_MAJOR' : version_parts[0],
    'QUAKESPASM_VERSION_MINOR' : version_parts[1],
    'QUAKESPASM_VERSION_PATCH' : version_parts[2],
    'QUAKESPASM_VERSION_SUFFIX' : version_suffix,
    'MAX_PATH_LEN' : get_option('max_path_len'),
    'GAME_NAME'     : get_option('game_dir'),
  },
  input : 'quakebuild.h.in',
  output : 'quakebuild.h',
)

exe = executable(
  get_option('exe_name'),
  sources,
  dependencies : dependencies,
  c_args : c_args,
  objc_args : c_args,
  install : true,
)

# install_data('assets/pak0.pak', install_dir : pak_dir)
install_data('quakespasm.pak', install_dir : pak_dir)
custom_target(
  'pak1',
  command : ['pop.py', '@OUTPUT@'],
  output : 'pak1.zip',
  install : true,
  install_dir : pak_dir,
)
