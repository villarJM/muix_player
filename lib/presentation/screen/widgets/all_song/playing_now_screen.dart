import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/app/repositories/song_player_manager_repositories.dart';
import 'package:muix_player/presentation/providers/song_info_state_notifier_provider.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/control_player/control_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingNowScreen extends ConsumerStatefulWidget {

  static const String name = 'playing-now';

const PlayingNowScreen({Key? key, }) : super(key: key);

  @override
  ConsumerState<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends ConsumerState<PlayingNowScreen> {

  final OnAudioQuery _audioQuery = OnAudioQuery();
  final ArtworkType artworkType = ArtworkType.AUDIO;

@override
  void initState() {
    // TODO: implement initState
    
  }
  @override
  Widget build(BuildContext context){

    List<Todo> todos = ref.watch(todosProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
          color: const Color.fromARGB(255, 33, 25, 110),
          child: Column(

            children: [
              
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: QueryArtworkWidget(
                    controller: _audioQuery,
                    id: todos[0].idSong, 
                    type: artworkType,
                    artworkBorder: BorderRadius.circular(0),
                    artworkHeight: 400,
                    artworkWidth: 400,
                    size: 1800,
                    ),
                ),
              ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 30,
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      title: Text(todos[0].title, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
                      subtitle: Text(todos[0].artist, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
                    ),
                  ),
                ),

              todos[0].playerState == PlayerState.playing
              ? StreamBuilder(
                  stream: todos[0].songPlayerManager.onAudioPositionChanged,
                  builder: (context, snapshot) {
                    return Slider(
                      value: snapshot.hasData
                          ? snapshot.data!.inMilliseconds.toDouble()
                          : 0.0,
                      onChanged: (value) {
                        todos[0].songPlayerManager.seekAudio(Duration(milliseconds: value.toInt()));
                      },
                      min: 0.0,
                      max: todos[0].duration.toDouble(),
                    );
                  },
                )
              : Container(),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
                  child: ControlPlayer(audioPlayerManager: todos[0].songPlayerManager,  path: todos[0].path,)
                ),
              ),
              
            ],
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
  }
}