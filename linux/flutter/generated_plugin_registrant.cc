//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <audioplayers_linux/audioplayers_linux_plugin.h>
#include <pdfrx/pdfrx_plugin.h>
#include <tflite_flutter_plus/tflite_flutter_plus_plugin.h>
#include <url_launcher_linux/url_launcher_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) audioplayers_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "AudioplayersLinuxPlugin");
  audioplayers_linux_plugin_register_with_registrar(audioplayers_linux_registrar);
  g_autoptr(FlPluginRegistrar) pdfrx_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PdfrxPlugin");
  pdfrx_plugin_register_with_registrar(pdfrx_registrar);
  g_autoptr(FlPluginRegistrar) tflite_flutter_plus_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TfliteFlutterPlusPlugin");
  tflite_flutter_plus_plugin_register_with_registrar(tflite_flutter_plus_registrar);
  g_autoptr(FlPluginRegistrar) url_launcher_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "UrlLauncherPlugin");
  url_launcher_plugin_register_with_registrar(url_launcher_linux_registrar);
}
