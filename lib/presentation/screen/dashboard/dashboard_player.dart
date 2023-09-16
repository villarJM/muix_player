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
            SizedBox(
              width: double.infinity,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 90, 0, 0),
                  child: Text(
                    'New Single',
                    textAlign: TextAlign.left,
                  )),
            ),
            // Card New Single Music
            SizedBox(height: 10,),
            CarouselCardNewMusic()
          ],
        ),
      ),
    );
  }
}

class CarouselCardNewMusic extends StatelessWidget {
  const CarouselCardNewMusic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        enlargeCenterPage: true,
        viewportFraction: 1.0
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(color: Colors.amber,borderRadius: BorderRadius.circular(10)),
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
