import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/provider/color_adaptable.dart';
import 'package:muix_player/services/services.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await _checkAndRequestPermissions();
  await setupServiceLocator();
  runApp(const MyApp(),);
}

Future<void> _checkAndRequestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    Permission.phone,
    Permission.audio,
    Permission.manageExternalStorage,
    Permission.mediaLibrary,
    Permission.photos,
    Permission.accessNotificationPolicy
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
    
    return MultiProvider(
    providers: providers,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: CustomNavigation(),
          );
        },
      ),
    );
  }
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => MuixTheme()),
  ChangeNotifierProvider(create: (context) => ColorAdaptable()),
];
