import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:muix_player/infractructure/datasources/local_songs_datasource_impl.dart';
import 'package:muix_player/infractructure/repositories/song_post_repositories_impl.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DashboardPlayer extends StatefulWidget {

  static const String name = '/';

  const DashboardPlayer({Key? key}) : super(key: key);

  @override
  State<DashboardPlayer> createState() => _DashboardPlayerState();
}

class _DashboardPlayerState extends State<DashboardPlayer> {

  final SongPostRepositoriesImp songs = SongPostRepositoriesImp(songsPostDatasources: LocalSongsDatasource());
  List<SongModel> _songRecently = [];


  Future<void> _loadSongListRecently() async {
    List<SongModel> songRecently = await songs.getRecentlyAddedSongs();
    setState(() {
      _songRecently = songRecently;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSongListRecently();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Muix Player'),
        backgroundColor: const Color(0XFF404094),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0XFF212345),
                  Color(0XFF404094),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
              )
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Title Carousel
                const _TitleCarousel(left: 10, top: 10, title: 'New Single',),
                // Carousel Card New Single Music
                const SizedBox(height: 10,),
                CarouselCardNewMusic(height: 200.0, viewportFraction: 1.0, isEnLargeCenterPage: true, marginHorizontal: 10.0, borderRadio: 10.0, songRecently: _songRecently),
        
                const SizedBox(height: 20,),
                // Title Carousel
                const _TitleCarousel(left: 10, top: 0, title: 'Most Played',),
                // Carousel Card Most Played
                const SizedBox(height: 10,),
                const CarouselCardNewMusic(height: 110.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 5.0, borderRadio: 10.0, songRecently: []),
        
                const SizedBox(height: 20,),
                // Title Carousel
                const _TitleCarousel(left: 10, top: 0, title: 'Playlist',),
                // Carousel Card Playlist
                const SizedBox(height: 10,),
                const CarouselCardNewMusic(height: 110.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 5.0, borderRadio: 10.0, songRecently: []),
        
                const SizedBox(height: 20,),
                // Title Carousel
                const _TitleCarousel(left: 10, top: 0, title: 'Artist',),
                // Carousel Card Playlist
                const SizedBox(height: 10,),
                const CarouselCardNewMusic(height: 120.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 5.0, borderRadio: 60.0,songRecently: [],)
              ],
            ),
          ),
        ],
        
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey,),
    );
  }
}

class _TitleCarousel extends StatefulWidget {

  final double left;
  final double top;
  final String title;

  const _TitleCarousel({ 
    required this.left, 
    required this.top, 
    required this.title,
  });

  @override
  State<_TitleCarousel> createState() => _TitleCarouselState();
}

class _TitleCarouselState extends State<_TitleCarousel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.fromLTRB(widget.left, widget.top, 0, 0),
          child: Text(
            widget.title,
            textAlign: TextAlign.left,
          )),
    );
  }
}

class CarouselCardNewMusic extends StatelessWidget {


  final double height;
  final double viewportFraction;
  final bool isEnLargeCenterPage;
  final double marginHorizontal;
  final double borderRadio;
  final List<SongModel> songRecently;

  const CarouselCardNewMusic({
    super.key, 
    required this.height,
    required this.viewportFraction, 
    required this.isEnLargeCenterPage,
    required this.marginHorizontal, 
    required this.borderRadio, 
    required this.songRecently
  });


  @override
  Widget build(BuildContext context) {
  final OnAudioQuery audioQuery = OnAudioQuery();
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        enlargeCenterPage: isEnLargeCenterPage,
        viewportFraction: viewportFraction
      ),
      items: songRecently.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                  Color(0XFFFB399A),
                  Color(0XFFAF00FE),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
                  ),
                  borderRadius: BorderRadius.circular(borderRadio)
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                      QueryArtworkWidget(
                        controller: audioQuery, 
                        id: i.id, 
                        type: ArtworkType.AUDIO, 
                        artworkQuality: FilterQuality.high,
                        artworkFit: BoxFit.cover,
                        format: ArtworkFormat.JPEG,
                        artworkBorder: const BorderRadius.all(Radius.circular(10)),
                        artworkHeight: 500,
                        artworkWidth: 500,
                        size: 1800,
                    ),
                    
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.18,
                      left: MediaQuery.of(context).size.width * 0.65,
                      child: Container(
                        height: 35,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70),
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TextButton(
                          onPressed: () {
                          
                          }, 
                          child: const Text('Listen Now', style: TextStyle(color: Colors.white),)),
                      ).frosted(
                        height: 35,
                        width: 100,
                        blur: 2.5,
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(i.title, style: const TextStyle(color: Colors.white, ),overflow: TextOverflow.fade),
                          Text(i.artist!, style: const TextStyle(color: Colors.white), overflow: TextOverflow.fade),
                        ],
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

class _CardNewMusic extends StatelessWidget {
  const _CardNewMusic();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SizedBox(
        height: 200,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(10),
            elevation: 10,

            // Dentro de esta propiedad usamos ClipRRect
            child: ClipRRect(
              // Los bordes del contenido del card se cortan usando BorderRadius
              borderRadius: BorderRadius.circular(10),

              // EL widget hijo que será recortado segun la propiedad anterior
              child: const Column(
                children: <Widget>[
                  // Usamos el widget Image para mostrar una imagen
                  Image(
                    width: double.infinity,
                    height: 170,
                    // Como queremos traer una imagen desde un url usamos NetworkImage
                    image: NetworkImage(
                        'https://www.yourtrainingedge.com/wp-content/uploads/2019/05/background-calm-clouds-747964.jpg'),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
