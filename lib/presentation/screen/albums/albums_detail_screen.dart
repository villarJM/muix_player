import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/presentation/widgets/box_playing.dart';
import 'package:muix_player/presentation/widgets/widgets.dart';
import 'package:muix_player/provider/color_adaptable.dart';
import 'package:muix_player/theme/muix_theme.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:anim_search_app_bar/anim_search_app_bar.dart';
import 'package:provider/provider.dart';

class AlbumsDetailScreen extends StatefulWidget {
  final Map<dynamic, dynamic> albumModel;
  final List<MediaItem> songList;
const AlbumsDetailScreen(this.albumModel, this.songList, { Key? key }) : super(key: key);

  @override
  State<AlbumsDetailScreen> createState() => _AlbumsDetailScreenState();
}

class _AlbumsDetailScreenState extends State<AlbumsDetailScreen>{

  final TextEditingController searchController = TextEditingController();

  List<MediaItem> songItems = [];
  
  void filterSearchResult(String query) {
    setState(() {
      songItems = widget.songList.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  void initState() {
    songItems = widget.songList;
    super.initState();
  }

  @override
  void dispose() {
     // ignore: empty_catches
     try { searchController.dispose(); } catch (e) {}
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    final colorAdaptable = Provider.of<ColorAdaptable>(context);
    final muixTheme = context.read<MuixTheme>();
    return Stack(
      children: [
        const Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SearchAnimated(
                      appBar: AppBar(
                        title: Text(widget.albumModel['album'], maxLines: 1, overflow: TextOverflow.clip, style: muixTheme.stPop30WhtW900),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    BlurContainer(
                      height: 110,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(10),
                      child: Row(
                        children: [
                          LoadArtwork(
                            id: widget.albumModel['id'], 
                            artworkType: ArtworkType.AUDIO,
                            height: 100.h,
                            width: 100.h,
                            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) return child;
                              return AnimatedOpacity(
                                opacity: frame == null ? 0 : 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                                child: child,
                              );
                            },
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(widget.albumModel['album'], maxLines: 1, overflow: TextOverflow.clip, style: muixTheme.styleUrbanist16WhiteW500,),
                                  Text(widget.albumModel['artist'] ?? '', maxLines: 1, overflow: TextOverflow.clip, style: muixTheme.styleUrbanist16WhiteW500,),
                                  Text('Track: ${widget.albumModel['numOfSong']}'),
                                  const Text('Duration: 4 minutos'),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                
                    Expanded(
                      child: ListView.builder(
                        itemCount: songItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListItem(
                              height: 50,
                              title: Text(songItems[index].title, maxLines: 1, style: muixTheme.styleUrbanist16WhiteW500,),
                              subtitle: Text(songItems[index].artist ?? "", maxLines: 1, style: muixTheme.styleUrbanist16WhiteW700,),
                              artwork: LoadArtwork(
                                id: int.parse(songItems[index].id), 
                                artworkType: ArtworkType.AUDIO,
                                height: 100.h,
                                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                  if (wasSynchronouslyLoaded) return child;
                                  return AnimatedOpacity(
                                    opacity: frame == null ? 0 : 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut,
                                    child: child,
                                  );
                                },
                              ), 
                              onTap: () async {
                                await colorAdaptable.getDominantingColorImage(int.parse(songItems[index].id), ArtworkType.AUDIO, 200, 50);
                                audioManager.playSongAlbum(songItems[index].album!, songItems[index].title);
                              },
                              icon: popupMenuButtonSongs(context, int.parse(songItems[index].id)),
                              
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          );
                          
                            
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const BoxPlaying(
                pBottom: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  AnimSearchAppBar search() {
    return AnimSearchAppBar(
      cancelButtonText: "Cancel",
      hintText: 'Search',
      cSearch: searchController,
      backgroundColor: Colors.transparent,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0
          ),
          
        ),
        contentPadding: EdgeInsets.all(10),
        hintMaxLines: 1,
        hintText: 'Search',
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Colors.white,
            width: 2.0
          ),
        ),
        
      ),
      onChanged: (value) {
        filterSearchResult(value);
      },
      appBar: AppBar(
        title: Text(widget.albumModel['album']),
        backgroundColor: Colors.transparent,
      )
    );
  }
}

class SearchAnimated extends StatefulWidget {

  final Widget? appBar;

const SearchAnimated({ Key? key, this.appBar }) : super(key: key);

  @override
  State<SearchAnimated> createState() => _SearchAnimatedState();
}

class _SearchAnimatedState extends State<SearchAnimated> {

  final FocusNode _focusNode = FocusNode();
  bool isShowAppBar = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        isShowAppBar = false;
      }
      setState(() {});
    },);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }
  @override
  Widget build(BuildContext context){

    final Widget _appBar = widget.appBar ?? AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Search',
          style: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
      );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSize(
          key: const ValueKey('animatedSizeSearchAppBar11'),
          duration: const Duration(milliseconds: 200),
          child: _appBar,
        )._isVisible(isShowAppBar),
        AnimatedSize(
          key: const ValueKey('animatedSizeSearchAppBar22'),
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            height: MediaQuery.of(context).padding.top + 10,
          ),
        )._isVisible(!isShowAppBar),
        Row(
          children: [
            Flexible(
              child: BlurContainer(
                height: 60,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: TextFormField(
                      focusNode: _focusNode,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        prefixIcon: isShowAppBar ? const AnimatedSize(
                          key: ValueKey('animatedSizeIconPrefix'),
                          duration: Duration(milliseconds: 200),
                          child: Icon(Icons.search, color: Colors.white, size: 35,)
                        ) : null,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20,)._isVisible(!isShowAppBar),
            AnimatedSize(
              key: const ValueKey('animatedSizeSearchAppBar33'),
              duration: const Duration(milliseconds: 200),
              child: BlurContainer(
                height: 60,
                width: 60,
                borderRadius: BorderRadius.circular(15),
                child: IconButton.filled(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () {
                    isShowAppBar = true;
                    _focusNode.unfocus();
                    setState(() {});
                  }, 
                  icon: const Icon(Icons.close, size: 35,)
                ),
              )
            )._isVisible(!isShowAppBar),
          ],
        )
      ],
    );
  }
}

extension WidgetExtension on Widget {
  Widget _isVisible(bool value, {double? height, double? width}) =>
      value ? this : SizedBox(height: height, width: width);
}