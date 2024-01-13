import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:muix_player/data/models/song_local_model.dart';
import 'package:muix_player/presentation/screen/widgets/side_menu.dart';
import 'package:muix_player/presentation/widgets/loard_artwork.dart';
import 'package:muix_player/provider/song_local_provider.dart';

class Drawer3D extends ConsumerStatefulWidget {
  
  static const String name = 'transform-3d';
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Drawer3D({super.key});

  @override
  ConsumerState<Drawer3D> createState() => Drawer3DState();
}

class Drawer3DState extends ConsumerState<Drawer3D>
    with SingleTickerProviderStateMixin {
  var _maxSlide = 0.75;
  var _extraHeight = 0.1;
  late double _startingPos;
  var _drawerVisible = false;
  late AnimationController _animationController;
  Size _screen = const Size(0, 0);
  late CurvedAnimation _animator;
  late CurvedAnimation _objAnimator;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animator = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuad,
      reverseCurve: Curves.easeInQuad,
    );
    _objAnimator = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeIn,
    );
  }

  @override
  void didChangeDependencies() {
    _screen = MediaQuery.of(context).size;
    _maxSlide *= _screen.width;
    _extraHeight *= _screen.height;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: <Widget>[
            Container(color: const Color(0XFFedf5f8)),
            _buildBackground(),
            // _build3dObject(),
            _buildPage(),
            _buildDrawer(),
            _buildHeader(),
            // _buildOverlay(),
          ],
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    _startingPos = details.globalPosition.dx;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final globalDelta = details.globalPosition.dx - _startingPos;
    if (globalDelta > 0) {
      final pos = globalDelta / _screen.width;
      if (_drawerVisible && pos <= 1.0) return;
      _animationController.value = pos;
    } else {
      final pos = 1 - (globalDelta.abs() / _screen.width);
      if (!_drawerVisible && pos >= 0.0) return;
      _animationController.value = pos;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx.abs() > 500) {
      if (details.velocity.pixelsPerSecond.dx > 0) {
        _animationController.forward(from: _animationController.value);
        _drawerVisible = true;
      } else {
        _animationController.reverse(from: _animationController.value);
        _drawerVisible = false;
      }
      return;
    }
    if (_animationController.value > 0.5) {
      {
        _animationController.forward(from: _animationController.value);
        _drawerVisible = true;
      }
    } else {
      {
        _animationController.reverse(from: _animationController.value);
        _drawerVisible = false;
      }
    }
  }

  void _toggleDrawer() {
    if (_animationController.value < 0.5)
      _animationController.forward();
    else
      _animationController.reverse();
  }

  _buildMenuItem(String s, {bool active = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        hoverColor: Colors.amber,
        onTap: () {
          
          print('link');
        },
        child: Text(
          s.toUpperCase(),
          style: TextStyle(
            fontSize: 25,
            color: active ? const Color(0xffbb0000) : null,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  _buildFooterMenuItem(String s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          
        },
        child: Text(
          s.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

_buildBackground() => Positioned.fill(
  top: -_extraHeight,
  bottom: -_extraHeight,
  child: AnimatedBuilder(
    animation: _animator,
    builder: (context, widget) => Transform.translate(
      offset: Offset(_maxSlide * _animator.value, 0),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY((pi / 2 + 0.1) * -_animator.value),
        alignment: Alignment.centerLeft,
        child: widget,
      ),
    ),
    child: Container(
      color: const Color(0XFFedf5f8),
      child: Stack(
        children: <Widget>[

          // Positioned(
          //   top: _extraHeight + 0.1 * _screen.height,
          //   left: 80,
          //   child: Transform.rotate(
          //     angle: 90 * (pi / 180),
          //     alignment: Alignment.centerLeft,
          //     child: const Text(
          //       "FENDER",
          //       style: TextStyle(
          //         fontSize: 100,
          //         color: Color(0xFFc7c0b2),
          //         shadows: [
          //           Shadow(
          //             color: Colors.black26,
          //             blurRadius: 5,
          //             offset: Offset(2.0, 0.0),
          //           ),
          //         ],
          //         fontWeight: FontWeight.w900,
          //       ),
          //     ),
          //   ),
          // ),
          // Shadow
          // Positioned(
          //   top: _extraHeight + 0.13 * _screen.height,
          //   bottom: _extraHeight + 0.24 * _screen.height,
          //   left: _maxSlide - 0.41 * _screen.width,
          //   right: _screen.width * 1.06 - _maxSlide,
          //   child: Column(
          //     children: <Widget>[
          //       Flexible(
          //         child: FractionallySizedBox(
          //           widthFactor: 0.2,
          //           child: Container(
          //             decoration: BoxDecoration(
          //               boxShadow: const [
          //                 BoxShadow(
          //                   blurRadius: 50,
          //                   color: Colors.black38,
          //                 )
          //               ],
          //               borderRadius: BorderRadius.circular(50),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Flexible(
          //         child: Container(
          //           decoration: BoxDecoration(
          //             boxShadow: const [
          //               BoxShadow(
          //                 blurRadius: 50,
          //                 color: Colors.black26,
          //               )
          //             ],
          //             borderRadius: BorderRadius.circular(50),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          AnimatedBuilder(
            animation: _animator,
            builder: (_, __) => Container(
              color: Colors.black.withAlpha(
                (150 * _animator.value).floor(),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);

_buildDrawer() => Positioned.fill(
  top: -_extraHeight,
  bottom: -_extraHeight,
  left: 0,
  right: _screen.width - _maxSlide,
  child: AnimatedBuilder(
    animation: _animator,
    builder: (context, widget) {
      return Transform.translate(
        offset: Offset(_maxSlide * (_animator.value - 1), 0),
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(pi * (1 - _animator.value) / 2),
          alignment: Alignment.centerRight,
          child: widget,
        ),
      );
    },
    child: Container(
      color: const Color(0XFFedf5f8),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Container(
              width: 5,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black12],
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: _extraHeight,
            bottom: _extraHeight,
            child: SafeArea(
              child: SizedBox(
                width: _maxSlide,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                                width: 4,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(-15, 0),
                            child: const Text(
                              "STRING",
                              style: TextStyle(
                                fontSize: 12,
                                backgroundColor: Color(0xffe8dfce),
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildMenuItem("Guitars"),
                          _buildMenuItem("Basses",active: true),
                          _buildMenuItem("Amps"),
                          _buildMenuItem("Pedals"),
                          _buildMenuItem("Others"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildFooterMenuItem("About"),
                          _buildFooterMenuItem("Support"),
                          _buildFooterMenuItem("Terms"),
                          _buildFooterMenuItem("Faqs"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _animator,
            builder: (_, __) => Container(
              width: _maxSlide,
              color: Colors.black.withAlpha(
                (150 * (1 - _animator.value)).floor(),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);

_buildPage() => Positioned(
  child:   Padding(
  
    padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
  
    child:   Container(
  
      height: 300,
  
      width: 500,
  
      // color: Colors.amber,
  
      child: FutureBuilder(
  
        future: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal(),
  
        builder: (BuildContext context, AsyncSnapshot<List<SongLocalModel>> snapshot) {
  
          if (snapshot.hasData) {
  
            return Container(
  
              padding: EdgeInsets.fromLTRB(40, 120, 40, 180),
  
              child: TransformerPageView(
  
                itemCount: 20,
  
                itemBuilder: (context, index) {
  
                final item = snapshot.data![index];
  
                return Transform.translate(
  
                  offset: Offset((_maxSlide + 50) * _animator.value, 0),
  
                  child: Transform(
  
                    transform: Matrix4.identity()
  
                      ..setEntry(3, 2, 0.001)
  
                      ..rotateY((pi / 2 + 0.1) * -_animator.value),
  
                    alignment: Alignment.centerLeft,
  
                    child: LoardArtwork(id: item.id, height: 100, width: 100, quality: FilterQuality.low,)
  
                  ));
  
              }
  
              ),
  
            );
  
          } else {
  
            return const Center(child: CircularProgressIndicator());
  
          }
  
        }
  
  
  
      ),
  
    ),
  
  ),
);

_build3dObject() => Positioned(
  top: 1,
  bottom: 1,
  left: _maxSlide - 350 * 1,
  right: 500 * 0.5 - _maxSlide,
  child: AnimatedBuilder(
    animation: _objAnimator,
    builder: (_, __) => FutureBuilder(
      future: ref.watch(songLocalRepositoryProvider).getRecentlyAddedSongsLocal(),
      builder: (BuildContext context, AsyncSnapshot<List<SongLocalModel>> snapshot) {
        if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.fromLTRB(40, 120, 40, 180),
            child: TransformerPageView(
              itemCount: 20,
              itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return Transform.translate(
                offset: Offset((_maxSlide + 50) * _animator.value, 0),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY((pi / 2 + 0.1) * -_animator.value),
                  alignment: Alignment.centerLeft,
                  child: LoardArtwork(id: item.id, height: 100, width: 100, quality: FilterQuality.low,)
                ));
            }
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    ),
  ),
);

  _buildHeader() => SafeArea(
        child: AnimatedBuilder(
            animation: _animator,
            builder: (_, __) {
              return Transform.translate(
                offset: Offset((_screen.width - 60) * _animator.value, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: InkWell(
                        onTap: _toggleDrawer,
                        child: const Icon(Icons.menu),
                      ),
                    ),
                    Opacity(
                      opacity: 1 - _animator.value,
                      child: const Text(
                        "PRODUCT DETAIL",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(width: 50, height: 50),
                  ],
                ),
              );
            }),
      );

// _buildOverlay() => Positioned(
//         top: 0,
//         bottom: 50,
//         left: 0,
//         right: 0,
//         child: AnimatedBuilder(
//           animation: _animator,
//           builder: (_, widget) => Opacity(
//             opacity: 1 - _animator.value,
//             child: Transform.translate(
//               offset: Offset((_maxSlide + 50) * _animator.value, 0),
//               child: Transform(
//                 transform: Matrix4.identity()
//                   ..setEntry(3, 2, 0.001)
//                   ..rotateY((pi / 2 + 0.1) * -_animator.value),
//                 alignment: Alignment.centerLeft,
//                 child: widget,
//               ),
//             ),
//           ),
//           child: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 50.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Text(
//                   "Fender\nAmerican\nElite Strat",
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Text(
//                       "SPEC",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     Icon(Icons.keyboard_arrow_down),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
}