import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/services/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  
  // await PreferencesAppTheme.init();
  WidgetsFlutterBinding.ensureInitialized();
  // Verifica y solicita los permisos necesarios.
  await _checkAndRequestPermissions();
  await setupServiceLocator();
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
    getIt<AudioManager>().init();
  }
  
  @override
  void dispose() {
    getIt<AudioManager>().dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: CustomNavigation(),
        );
      },
    );
  }
}
