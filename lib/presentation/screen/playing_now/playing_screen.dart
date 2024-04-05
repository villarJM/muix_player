import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muix_player/helper/icons.dart';
import 'package:muix_player/presentation/screen/widgets/background.dart';
import 'package:muix_player/presentation/widgets/circle_painter.dart';
import 'package:muix_player/presentation/widgets/wave_slider.dart';
import 'package:muix_player/theme/app_muix_theme.dart';
import 'package:muix_player/util/blend_mask.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class PlayingScreen extends StatefulWidget {

  final int id;
  final String artist;
  final String title;

  const PlayingScreen({
    Key? key, 
    required this.id, 
    required this.artist, 
    required this.title
  }) : super(key: key);

  @override
  PlayingScreenState createState() => PlayingScreenState();
}

class PlayingScreenState extends State<PlayingScreen> {
  int age = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        Scaffold(
          appBar: AppBar(
            title: const Text('Playing Now'),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [

                          Image.asset(
                            'assets/images/cd.png',
                            fit: BoxFit.cover,
                            height: 260.h,
                            width: 260.h,
                            alignment: Alignment.bottomCenter,
                            // colorBlendMode: BlendMode.xor,
                          ),
                          SizedBox(
                            height: 260.h,
                            width: 260.h,
                            child: BlendMask(
                              blendMode: BlendMode.hardLight,
                              opacity: 1.0,
                              child: ClipOval(
                                child: QueryArtworkWidget(
                                    id: widget.id,
                                    type: ArtworkType.AUDIO,
                                    keepOldArtwork: true,
                                    artworkFit: BoxFit.cover,
                                    artworkHeight: 270.h,
                                    artworkWidth: 270.h,
                                    artworkQuality: FilterQuality.high,
                                    quality: 100,
                                    size: 1600,
                                  ),
                              )
                              
                            ),
                          ),
                          // Container(
                          //   height: 270.h,
                          //   width: 270.h,
                          //   decoration:  const BoxDecoration(
                          //     backgroundBlendMode: BlendMode.hardLight,
                          //     color: Colors.transparent,
                              
                          //   ),
                          //   child: ClipOval(
                          //     child: QueryArtworkWidget(
                          //         id: widget.id,
                          //         type: ArtworkType.AUDIO,
                          //         keepOldArtwork: true,
                          //         artworkBorder: BorderRadius.circular(10),
                          //         artworkFit: BoxFit.cover,
                          //         artworkHeight: 270.h,
                          //         artworkWidth: 270.h,
                          //         artworkQuality: FilterQuality.high,
                          //         quality: 100,
                          //         size: 1600,
                          //         artworkBlendMode: BlendMode.saturation,
                          //       ),
                          //   ),
                          // ),
                          
                          CustomPaint(
                            size: Size(70.h, 70.h), // Tamaño del widget CustomPaint
                            painter: CirclePainter(200), // Pasamos el radio del círculo
                          ),
                          
                        ],
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        child: Column(
                          children: [
                            Text(widget.artist, maxLines: 1,),
                            Text(widget.title, maxLines: 1,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: WaveSlider(
                          color: AppMuixTheme.primary,
                          onChanged: (double val) {
                            setState(() {
                              age = (val * 10).round();
                            });
                          },
                          onChangeStart: (p0) {},
                          onChangeEnd: (p0) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: (){}, icon: Iconify(Ph.shuffle_fill, color: AppMuixTheme.primary, size: 35,)),
                            Transform.rotate(
                              angle: 3.15,
                              child: IconButton(onPressed: (){}, icon: Iconify(Teenyicons.next_small_solid, color: AppMuixTheme.primary, size: 40,))),
                            IconButton(onPressed: (){}, icon: Iconify(Ri.play_fill, color: AppMuixTheme.primary, size: 50,)),
                            IconButton(onPressed: (){}, icon: Iconify(Teenyicons.next_small_solid, color: AppMuixTheme.primary, size: 40,)),
                            
                            IconButton(onPressed: (){}, icon: Iconify(Ph.repeat_fill, color: AppMuixTheme.primary, size: 35,), ),
                            // Container(
                            //   height: 35.w,
                            //   width: 35.w,
                            //   decoration: BoxDecoration(
                            //     color: AppMuixTheme.backgroundSecondary,
                            //     border: Border.all(color: Colors.white),
                            //     borderRadius: BorderRadius.circular(10)
                            //   ),
                            //   child: IconButton(onPressed: (){}, icon: const Iconify(Ph.pause_fill))
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          child: Container(
            height: 110.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppMuixTheme.primary,
                  AppMuixTheme.background
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp,
              )
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          child: WaveWidget(
            config: CustomConfig(
              colors: [
                AppMuixTheme.backgroundSecondary,
                AppMuixTheme.primary
              ],
              durations: [
                5000,
                4000
              ],
              heightPercentages: [
                0.3,
                0.3
              ],
            ),
            backgroundColor: Colors.transparent,
            size: Size(MediaQuery.of(context).size.width, 100.h),
          ),
        ),
      ],
    );
  }
}
