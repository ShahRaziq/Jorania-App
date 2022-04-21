import 'package:Jorania/screen/place.dart';
import 'package:Jorania/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:Jorania/custom/square_fav.dart';
import 'package:Jorania/screen/place.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List _posts = [
    'fav 1',
    'fav 2',
    'fav 3',
    'fav 4',
    'fav 5',
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          automaticallyImplyLeading: false,
          title: Text('Kegemaran'),
        ), // AppBar
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _posts.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (c) => PlaceDetail(data:  )));
                      },
                      child: Square(),
                    );
                  })),
            )
          ],
        ),
      ); // Scaffold
}
