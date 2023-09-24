import 'package:flutter/material.dart';
import 'package:muix_player/app/repositories/song_player_manager_repositories.dart';

class ControlPlayer extends StatefulWidget {

  final SongPlayerManager audioPlayerManager;
  IconData iconPlayer;
  final String path;

  ControlPlayer({
    Key? key, 
    required this.audioPlayerManager, 
    required this.iconPlayer, 
    required this.path
  }) : super(key: key);

  @override
  State<ControlPlayer> createState() => _ControlPlayerState();
}

class _ControlPlayerState extends State<ControlPlayer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {

          },
          icon: Icon(Icons.shuffle_rounded, size: 40.0, color: Colors.white,),
        ),
        IconButton(
          onPressed: () {

          }, icon: Icon(Icons.skip_previous_rounded, size: 40.0, color: Colors.white,)
        ),
        IconButton(
          onPressed: () {
            widget.iconPlayer = widget.iconPlayer == Icons.play_arrow_rounded ? Icons.pause_rounded : Icons.play_arrow_rounded;
            
            setState(() {
              
            });

            if(widget.iconPlayer == Icons.pause_rounded){
              widget.audioPlayerManager.playLocalAudio(widget.path);
            } else if (widget.iconPlayer == Icons.play_arrow_rounded){
              widget.audioPlayerManager.pauseLocalAudio();
            } 
            setState(() {
              
            });
          }, icon: Icon(widget.iconPlayer, size: 40.0, color: Colors.white),
        ),
        IconButton(
          onPressed: () {

          }, icon: Icon(Icons.skip_next_rounded, size: 40.0, color: Colors.white,),
        ),
        IconButton(
          onPressed: () {

          }, icon: Icon(Icons.repeat_rounded, size: 40.0, color: Colors.white,),
        ),
      ],
    );
  }
}
