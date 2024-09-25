// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart'
    as carousel;
import 'package:front_end/widgets/app_menu_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<String> imgList = [
    'assets/images/imagem-1-CarouselEssentia.png',
    'assets/images/imagem-2-CarouselEssentia.png',
    'assets/images/imagem-3-CarouselEssentia.png',
    'assets/images/imagem-4-CarouselEssentia.png',
  ];

  final String phoneNumber = '+5508007249099';
  final Uri url = Uri(
    scheme: 'https',
    host: 'essentia.com.br',
    path: '',
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Essentia',
      home: Scaffold(
        drawer: Drawer(
          child: AppMenuDrawer(),
        ),
        appBar: AppBar(
          title: Text('Contato', style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromRGBO(21, 21, 21, 1),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            // Carousel Slider
            Container(
              height: MediaQuery.of(context).size.height *
                  0.4, // 40% da altura da tela
              child: carousel.CarouselSlider.builder(
                itemCount: imgList.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgList[itemIndex]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                options: carousel.CarouselOptions(
                  autoPlay: true,
                  height: 400,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                ),
              ),
            ),
            // Texto separador
            Container(
              color: Colors.black87, // Altere para a cor desejada
              padding: const EdgeInsets.all(16.0),
              width: double.maxFinite,
              child: Column(
                children: [
                  Text(
                    'Essentia Pharma',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[300]),
                  ),
                  Text(
                    'The science of art in the art of living',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Botões
            // Botões
            SizedBox(
              height: 60, // Define a altura do botão
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: phoneNumber,
                        );
                        if (await canLaunchUrl(launchUri)) {
                          launchUrl(launchUri);
                        } else {
                          throw 'Could not launch $launchUri';
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, color: Colors.grey[400]), // Ícone do telefone
                          SizedBox(width: 8), // Espaço entre o ícone e o texto
                          Text(
                            'Ligar',
                            style: TextStyle(color: Colors.grey[300]), // Estilo do texto
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.grey[800], // Cor de fundo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.web, color: Colors.grey[400]), // Ícone do site
                          SizedBox(width: 8), // Espaço entre o ícone e o texto
                          Text(
                            'Acessar Site',
                            style: TextStyle(color: Colors.grey[300]), // Estilo do texto
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.grey[800], // Cor de fundo do botão
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Bordas arredondadas
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),


            // ListView com informações
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  ListTile(
                    title: Text('Endereço:'),
                    subtitle: Text('Rua Exemplo, 123'),
                    leading: IconTheme(
                      child: Icon(Icons.home_work_outlined),
                      data: IconThemeData(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    title: Text('URL do Site:'),
                    subtitle: Text(url.toString()),
                    leading: IconTheme(
                      child: Icon(Icons.web_outlined),
                      data: IconThemeData(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    title: Text('Número de Telefone:'),
                    subtitle: Text(phoneNumber),
                    leading: IconTheme(
                      child: Icon(Icons.phone_android_rounded),
                      data: IconThemeData(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    title: Text('Email:'),
                    subtitle: Text('exemplo@email.com'),
                    leading: IconTheme(
                      child: Icon(Icons.mail_sharp),
                      data: IconThemeData(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
