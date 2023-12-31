import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/config/router/app_router.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
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
  Widget build(BuildContext 
  context) {

    // final songPostRepository = SongPostRepositoriesImp(songsPostDatasources: LocalSongsDatasource());
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}