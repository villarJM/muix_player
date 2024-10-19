// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:muix_player/provider/song_local_service_provider.dart';

// class CustomPlaying extends ConsumerState {

//   final CarouselController _controller = CarouselController();

//   @override
//   Widget build(BuildContext context){
//     return Stack(
//         alignment: Alignment.topCenter,
//         children: [
//         CarouselSlider(
//           carouselController: _controller,
//           options: CarouselOptions(
//             scrollPhysics: const BouncingScrollPhysics(),
//             height: MediaQuery.of(context).size.height,
//             viewportFraction:1.0,
//             // cambia de pantalla
//             onPageChanged: (index, reason) {
//               ref.watch(songLocalServiceProvider).updatedSongPosition(index);
//             },
//           ),
//           items: const [],
//         ),
//         Positioned.fill(
//           child: GestureDetector(
//                 onHorizontalDragEnd: (details) {
//                   if (details.primaryVelocity! > 0) {  
//                     // Deslizar hacia la derecha (prev)
//                     _controller.previousPage();
//                     ref.watch(songLocalServiceProvider).getPositionSong(1);
//                   } else if (details.primaryVelocity! < 0) {
//                     // Deslizar hacia la izquierda (next)
//                     _controller.nextPage();
//                     ref.watch(songLocalServiceProvider).getPositionSong(2);
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   color: Colors.transparent, // Asegúrate de que el GestureDetector cubra el Carousel
//                 ),
//               ),
//         ),
//         // Positioned(
//         //   bottom: MediaQuery.of(context).size.height * 0.25,
//         //   child: Column(
//         //     crossAxisAlignment: CrossAxisAlignment.center,
//         //     children: [
//         //       Text(title, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
//         //       Text(artist, style: const TextStyle(fontSize: 18, color: Colors.white,), textAlign: TextAlign.center,),
//         //     ]
//         //   )
//         // ),
//         // Padding(
//         //   padding: const EdgeInsets.fromLTRB(0, 500, 0, 0),
//         //   child: StreamBuilder(
//         //       stream: audioState.audioPlayer.onPositionChanged,
//         //       builder: (context, snapshot) {
//         //         return Slider(
//         //           value: snapshot.hasData
//         //               ? snapshot.data!.inMilliseconds.toDouble()
//         //               : 0.0,
//         //           onChanged: (value) {
//         //             audioState.seekAudio(Duration(milliseconds: value.toInt()));
//         //           },
//         //           min: 0.0,
//         //           max: duration.toDouble(),
//         //         );
//         //       },
//         //     ),
//         // ),
      
//         // Positioned(
//         //   top: 35,
//         //   left: 10,
//         //   child: IconButton(onPressed: () {
//         //       Navigator.pop(context);
//         //     }, 
//         //     icon: const Icon(Icons.chevron_left_rounded, color: Colors.white,)
//         //   )
//         // ),
//         // Positioned(
//         //   width: MediaQuery.of(context).size.width,
//         //   bottom: MediaQuery.of(context).size.height * 0.1,
//         //   child: ControlPlayer(path: path, controller: _controller),
//         // ),
//         ],        
//       );

//   }
// }