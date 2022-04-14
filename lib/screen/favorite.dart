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
    'fav 6',
    'fav 4',
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Kegemaran'),
        ), // AppBar
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _posts.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlaceDetail(index)));
                      },
                      child: Square(
                        child: _posts[index],
                      ),
                    );
                  })),
            )
          ],
        ),
      ); // Scaffold
}
