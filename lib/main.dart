import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/screen/widgets/custom_navigation.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  
  // await PreferencesAppTheme.init();
  WidgetsFlutterBinding.ensureInitialized();
  // Verifica y solicita los permisos necesarios.
  await _checkAndRequestPermissions();

  runApp(const ProviderScope(child: MyApp()),);
}

Future<void> _checkAndRequestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    Permission.phone,
    Permission.audio,
    Permission.manageExternalStorage // Cambia a otros permisos según tus necesidades.
  ].request();

  statuses.forEach((permission, status) {
    if (!status.isGranted) {
      // Maneja el caso en el que el permiso no está concedido.
      // Puedes mostrar un diálogo o una solicitud para que el usuario conceda los permisos necesarios.
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, child) {
            return MaterialApp(
            
            debugShowCheckedModeBanner: false,
            home: CustomNavigation(),
          );
          },
        );
      },
    );
  }
}