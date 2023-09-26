
import 'package:flutter/material.dart';
import 'package:muix_player/domain/repositories/song_post_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ListProvider extends ChangeNotifier {
  
  final SongPostRepository songsRepository;

  bool initialLoading = true;
  List<SongModel> songs = [];

  ListProvider({required this.songsRepository});


  Future<void> loadListSong() async {
    // await Future.delayed(const Duration(seconds: 2));

    // final List<VideoPost> newVideos = videoPosts
    //     .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
    //     .toList();

    final newSong = await songsRepository.getSongFiles();
    songs.addAll(newSong);
    initialLoading = false;
    notifyListeners();
  }
}