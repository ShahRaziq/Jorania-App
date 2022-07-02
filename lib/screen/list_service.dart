import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Jorania/screen/addService.dart';
import 'package:Jorania/screen/service.dart';

class ListServicePage extends StatefulWidget {
  const ListServicePage({Key? key}) : super(key: key);

  @override
  State<ListServicePage> createState() => _ListServicePageState();
}

class _ListServicePageState extends State<ListServicePage> {
  bool visible = false;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
    checkUserRole();
    setState(() {});
  }

  List<Map<String, dynamic>> services = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Floating action button sunting
      floatingActionButton: Visibility(
        visible: visible,
        child: FloatingActionButton.extended(
          heroTag: 'servis_hero',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddService()));
          },
          label: const Text(
            "servis",
            style: TextStyle(fontSize: 17),
          ),
          icon: const Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 216, 153, 71),
        ),
      ),
      //appbar
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orangeAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('          Senarai Servis'),
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
                    delegate: MySearchDelegate(services: services),
                  );
                },
                icon: const Icon(
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
            child: loading
                ? const SizedBox(
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: services.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => ServiceDetail(
                                        data: services[index],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          height: 100,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 216, 192, 161),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
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
                                    services[index]["ser_name"],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(children: [
                                    const Icon(Icons.calendar_month_rounded),
                                    Text(
                                      services[index]["ser_hari"],
                                    ),
                                  ]),
                                  Row(children: [
                                    const Icon(Icons.access_alarm),
                                    Text(
                                      services[index]["ser_waktu"],
                                    ),
                                  ]),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
          ),
        ],
      ),
    );
  }

  Future getData() async {
    await FirebaseFirestore.instance
        .collection("servis_memancing")
        .get()
        .then((value) {
      for (var element in value.docs) {
        Map<String, dynamic> data = element.data();
        data.addAll({'id': element.id});
        services.add(data);
      }
      if (mounted) {
        loading = false;
        setState(() {});
      }
    });
  }

  checkUserRole() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!["role"].toString() == "admin") {
        visible = true;
      } else {
        visible = false;
      }
      setState(() {});
    });
  }
}

class MySearchDelegate extends SearchDelegate {
  List services;
  MySearchDelegate({
    required this.services,
  });

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Cari servis";
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
    List data = [];

    for (int i = 0; i < services.length; i++) {
      if ((services[i]["ser_name"] as String).toLowerCase() ==
          query.toLowerCase()) {
        data.add(services[i]);
      }
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => ServiceDetail(
                          data: data[index],
                        )));
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            height: 100,
            decoration: const BoxDecoration(
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
                      data[index]["ser_name"],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(children: [
                      const Icon(Icons.calendar_month_rounded),
                      Text(
                        data[index]["ser_hari"],
                      ),
                    ]),
                    Row(children: [
                      const Icon(Icons.access_alarm),
                      Text(
                        data[index]["ser_waktu"],
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List data = [];

    for (int i = 0; i < services.length; i++) {
      if ((services[i]["ser_name"] as String)
          .toLowerCase()
          .contains(query.toLowerCase())) {
        data.add(services[i]);
      }
    }

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => ServiceDetail(
                          data: data[index],
                        )));
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            height: 100,
            decoration: const BoxDecoration(
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
                      data[index]["ser_name"],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(children: [
                      const Icon(Icons.calendar_month_rounded),
                      Text(
                        data[index]["ser_hari"],
                      ),
                    ]),
                    Row(children: [
                      const Icon(Icons.access_alarm),
                      Text(
                        data[index]["ser_waktu"],
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
