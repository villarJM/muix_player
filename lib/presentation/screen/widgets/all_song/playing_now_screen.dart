import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/app/repositories/song_player_manager_repositories.dart';
import 'package:muix_player/presentation/providers/audio_player_manager_provider.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/control_player/control_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingNowScreen extends ConsumerStatefulWidget {

  static const String name = 'playing-now';

const PlayingNowScreen({Key? key, }) : super(key: key);

  @override
  ConsumerState<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends ConsumerState<PlayingNowScreen> {

  SongPlayerManager songPlayerManager = SongPlayerManager();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final ArtworkType artworkType = ArtworkType.AUDIO;

  @override
  Widget build(BuildContext context){

    final songListProvider = ref.watch(listSongProvider);
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height,
        viewportFraction:1.0,
        // cambia de pantalla
        onPageChanged: (index, reason) {
          print('nextPage $index');
          setState(() {
            
          });
        },
      ),
      items: songListProvider.map((song) {
        return Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  QueryArtworkWidget(
                    controller: _audioQuery,
                    id: song.id, 
                    type: artworkType,
                    artworkBorder: BorderRadius.circular(0),
                    artworkHeight: 600,
                    artworkWidth: 500,
                    size: 1800,
                    ),
                  Positioned.fill(
                    top: 400,
                    child: Container(
                      decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                            const Color(0XFF212345).withAlpha(0),
                            const Color(0XFF212345),
                            const Color(0XFF212345),
                            const Color(0XFF212345)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(song.title, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
                        Text(song.artist!, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
                      ]
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 500, 0, 0),
                    child: StreamBuilder(
                        stream: songPlayerManager.onAudioPositionChanged,
                        builder: (context, snapshot) {
                          return Slider(
                            value: snapshot.hasData
                                ? snapshot.data!.inMilliseconds.toDouble()
                                : 0.0,
                            onChanged: (value) {
                              songPlayerManager.seekAudio(Duration(milliseconds: value.toInt()));
                            },
                            min: 0.0,
                            max: song.duration!.toDouble(),
                          );
                        },
                      ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: ControlPlayer(audioPlayerManager: songPlayerManager,  path: song.data,)
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 10,
                    child: IconButton(onPressed: () {
                        Navigator.pop(context);
                      }, 
                      icon: const Icon(Icons.chevron_left_rounded, color: Colors.white,)
                    )
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}