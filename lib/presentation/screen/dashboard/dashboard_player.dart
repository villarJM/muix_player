import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DashboardPlayer extends StatelessWidget {
  const DashboardPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Title Carousel
            _TitleCarousel(left: 10, top: 90, title: 'New Single',),
            // Carousel Card New Single Music
            SizedBox(height: 10,),
            CarouselCardNewMusic(height: 200.0, viewportFraction: 1.0, isEnLargeCenterPage: true, marginHorizontal: 10.0, borderRadio: 10.0,),

            SizedBox(height: 20,),
            // Title Carousel
            _TitleCarousel(left: 10, top: 0, title: 'Most Played',),
            // Carousel Card Most Played
            SizedBox(height: 10,),
            CarouselCardNewMusic(height: 110.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 5.0, borderRadio: 10.0,),

            SizedBox(height: 20,),
            // Title Carousel
            _TitleCarousel(left: 10, top: 0, title: 'Playlist',),
            // Carousel Card Playlist
            SizedBox(height: 10,),
            CarouselCardNewMusic(height: 110.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 5.0, borderRadio: 10.0,),

            SizedBox(height: 20,),
            // Title Carousel
            _TitleCarousel(left: 10, top: 0, title: 'Artist',),
            // Carousel Card Playlist
            SizedBox(height: 10,),
            CarouselCardNewMusic(height: 120.0, viewportFraction: 0.325, isEnLargeCenterPage: false, marginHorizontal: 5.0, borderRadio: 60.0,)
          ],
        ),
      ),
    );
  }
}

class _TitleCarousel extends StatelessWidget {

  final double left;
  final double top;
  final String title;

  const _TitleCarousel({ 
    required this.left, 
    required this.top, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
          padding: EdgeInsets.fromLTRB(left, top, 0, 0),
          child: Text(
            title,
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

  const CarouselCardNewMusic({
    super.key, 
    required this.height,
    required this.viewportFraction, 
    required this.isEnLargeCenterPage,
    required this.marginHorizontal, 
    required this.borderRadio
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        enlargeCenterPage: isEnLargeCenterPage,
        viewportFraction: viewportFraction
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
                decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(borderRadio)),
                child: Text(
                  'text $i',
                  style: const TextStyle(fontSize: 16.0),
                ));
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
