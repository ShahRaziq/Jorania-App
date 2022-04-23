import 'dart:developer';

import 'package:Jorania/screen/addService.dart';
import 'package:Jorania/screen/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListServicePage extends StatefulWidget {
  const ListServicePage({Key? key}) : super(key: key);

  @override
  State<ListServicePage> createState() => _ListServicePageState();
}

class _ListServicePageState extends State<ListServicePage> {
  List<String> service = [
    'Cod Umpan hidup',
    'Cod umpan dedak',
    'Umpan ikan ptong',
    'Sewaan rumah bot',
    'Sewaan rumah rakit',
    'Sewaan joran',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Floating action button sunting
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'servis_hero',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddService()));
        },
        label: const Text("servis"),
        icon: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 150, 100, 35),
      ),
      //appbar
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orangeAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Senarai Servis '),
              Icon(
                Icons.store,
                size: 30.sp,
              ),
              //icon button tambah servis
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MySearchDelegate(),
                  );
                },
                icon: Icon(
                  Icons.search,
                  size: 35,
                ))
          ]),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          //List View
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: service.length,
              itemBuilder: (_service, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => ServiceDetail()));
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    height: 100,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 216, 192, 161),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              service[index],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(children: [
                              Icon(Icons.calendar_month_rounded),
                              Text(' Isnin-Ahad'),
                            ]),
                            Row(children: [
                              Icon(Icons.access_alarm),
                              Text('8:00 am - 10:00 pm'),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null); //close search bar
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = [
      'Umpan hidup',
      'Umpan',
      'Penor',
      'Bentengg Kuantan',
      'Jeti',
      'Tanjung Api',
      'Sungai Lembing',
    ];
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;

            showResults(context);
          },
        );
      },
    );
  }
}
