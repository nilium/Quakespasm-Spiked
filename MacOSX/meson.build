add_languages('objc')

sources += files(
  'AppController.m',
  'QuakeArgument.m',
  'QuakeArguments.m',
  'ScreenInfo.m',
  'SDLApplication.m',
  'SDLMain.m',
)

dependencies += dependency('appleframeworks', modules : ['IOKit', 'OpenGL'])
pak_dir = 'Contents/Resources/game' / get_option('game_dir')

plist_data = configuration_data({
  'EXECUTABLE_NAME' : get_option('exe_name'),
  'PRODUCT_NAME' : get_option('product_name'),
  'PACKAGE_RDNS_NAME' : get_option('package_rdns_name'),
  'VERSION' : meson.project_version(),
})

configure_file(
  configuration : plist_data,
  input : 'Info.plist',
  output : 'Info.plist',
  install : true,
  install_dir : 'Contents',
)
install_subdir('English.lproj', install_dir : 'Contents/Resources')
