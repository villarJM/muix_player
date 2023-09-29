import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Widget build(BuildContext context){

    List<Todo> todos = ref.watch(todosProvider);

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          QueryArtworkWidget(
            controller: _audioQuery,
            id: todos[0].idSong, 
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
                Text(todos[0].title, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
                Text(todos[0].artist, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
              ]
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 500, 0, 0),
            child: StreamBuilder(
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
              ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: ControlPlayer(audioPlayerManager: todos[0].songPlayerManager,  path: todos[0].path,)
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