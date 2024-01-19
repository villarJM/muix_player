import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/domain/usecases/audio_context_manager.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';

class CustomSelectedSongBox extends StatelessWidget {
  final int id;
  final String title;
  final String artist;
  final String path;
  final Color color;
  final Function()? onTap;
  final Widget? iconButton;

  const CustomSelectedSongBox({
    super.key,
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    required this.color,
    this.onTap,
    this.iconButton,
  });
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          onTap: onTap,
          child: GlassContainer(
            height: 70,
            width: MediaQuery.of(context).size.width,
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.40), color.withOpacity(0.10)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(13),
            borderGradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.39, 0.40, 1.0],
            ),
            blur: 10.0,
            borderWidth: 1.2,
            elevation: 3.0,
            isFrostedGlass: true,
            shadowColor: Colors.black.withOpacity(0.50),
            alignment: Alignment.center,
            frostedOpacity: 0.00,
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
                )
                ),
              trailing: iconButton,
            ),
          )
        ),
      ),
    );
  }
}
