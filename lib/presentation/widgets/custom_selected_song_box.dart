
import 'package:audioplayers/audioplayers.dart';
import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/domain/usecases/audio_context_manager.dart';
import 'package:muix_player/presentation/screen/playing_now/playing_now_screen.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';

class CustomSelectedSongBox extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final int id;
  final String title;
  final String artist;
  final String path;
  final Color color;

  const CustomSelectedSongBox({
    super.key,
    required this.audioPlayer,
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white)),
          subtitle: Text(artist,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white)),
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: LoardArtwork(
                  id: id,
                  radius: 10,
                ),
              )),
          trailing: IconButton(
              onPressed: () {
                AudioContextManager.playAudio(path);
              },
              icon: const Icon(Icons.play_arrow)),
        ).frosted(
          frostColor: color,
          height: 70,
          width: MediaQuery.of(context).size.width,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          blur: 16.0,
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PlayingNowScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      // settings: RouteSettings(
      //   arguments: {
      //     'id': id,
      //     'title': title,
      //     'artist': artist,
      //     'duration': duration,
      //     'path': path,
      //   }
      // )
    );
  }
}
