import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/app/repositories/song_player_manager_repositories.dart';
import 'package:muix_player/presentation/screen/widgets/all_song/control_player/control_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingNowScreen extends StatefulWidget {

  final int id;
  final String title;
  final String artist;
  final ArtworkType artworkType;
  final int duration;
  final PlayerState playerState;
  final SongPlayerManager audioPlayerManager;
  final IconData iconPlayer;
  final String path;

const PlayingNowScreen({ 
  Key? key,
  required this.id,
  required this.title, 
  required this.artist,
  required this.artworkType,
  required this.duration,
  required this.playerState,
  required this.audioPlayerManager,
  required this.iconPlayer, 
  required this.path,
}) : super(key: key);

  @override
  State<PlayingNowScreen> createState() => _PlayingNowScreenState();
}

class _PlayingNowScreenState extends State<PlayingNowScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

@override
  void initState() {
    // TODO: implement initState
    
  }
  @override
  Widget build(BuildContext context){
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
                    id: widget.id, 
                    type: widget.artworkType,
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
                      title: Text(widget.title, style: TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
                      subtitle: Text(widget.artist, style: TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
                    ),
                  ),
                ),

              widget.playerState == PlayerState.playing
              ? StreamBuilder(
                  stream: widget.audioPlayerManager.onPositionChanged,
                  builder: (context, snapshot) {
                    return Slider(
                      value: snapshot.hasData
                          ? snapshot.data!.inMilliseconds.toDouble()
                          : 0.0,
                      onChanged: (value) {
                        widget.audioPlayerManager.seekAudio(Duration(milliseconds: value.toInt()));
                      },
                      min: 0.0,
                      max: widget.duration.toDouble(),
                    );
                  },
                )
              : Container(),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
                  child: ControlPlayer(audioPlayerManager: widget.audioPlayerManager, iconPlayer: widget.iconPlayer, path: widget.path,)
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