import 'dart:developer';
import 'dart:io';

import 'package:Jorania/providers/place_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:Jorania/services/firestore_service.dart';
import 'package:Jorania/services/storage_services.dart';
import 'package:provider/provider.dart';

class EditLocation extends StatefulWidget {
  final String id;
  const EditLocation({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<EditLocation> createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  final ImagePicker imagePicker = ImagePicker();
  List<dynamic>? imageNetworkList = [];
  List<XFile>? imageFileList = [];
  StorageServices storageServices = StorageServices();
  FireStoreService fireStoreService = FireStoreService();
  bool loading = true;
  late DocumentSnapshot<Map<String, dynamic>> data;
  //formkey
  // final _formKey = GlobalKey<FormState>();
  //default role =user

  //editting Controller
  final nameController = TextEditingController();
  final detailController = TextEditingController();
  final tipsController = TextEditingController();
  final typeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireStoreService.getdataLocation(widget.id).then((value) {
      data = value;
      nameController.text = data["loc_name"];
      detailController.text = data["loc_desc"];
      tipsController.text = data["loc_tips"];
      imageNetworkList = data["loc_pic"];
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    place.place = widget;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: Text(
          'Kemaskini Lokasi Memancing',
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 1,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      margin: EdgeInsets.all(20.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.circular(20.w),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 15,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.w),
                                topRight: Radius.circular(20.w),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //upload image
                                imageNetworkList!.isNotEmpty
                                    ? SizedBox(
                                        width: double.infinity,
                                        height: 200.h,
                                        child: ListView.separated(
                                          itemCount: imageNetworkList!.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            log(index.toString());
                                            return Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Image.network(
                                                  imageNetworkList![index],
                                                  fit: BoxFit.cover,
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      imageNetworkList!
                                                          .removeAt(index);
                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.red),
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const SizedBox(
                                              width: 10,
                                            );
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                imageFileList!.isEmpty
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                const Size(double.infinity, 40),
                                            primary: Colors.orange),
                                        onPressed: () {
                                          selectImages();
                                        },
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text("MUAT NAIK GAMBAR"),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Icon(Icons.add_photo_alternate)
                                            ]))
                                    : SizedBox(
                                        height: 200.h,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: imageFileList!.length,
                                            itemBuilder: ((context, index) {
                                              return Stack(
                                                children: [
                                                  Image.file(
                                                    File(imageFileList![index]
                                                        .path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        imageFileList!
                                                            .removeAt(index);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    Colors.red),
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            })),
                                      ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                //NAMA LOKASI
                                Row(
                                  children: [
                                    Text(
                                      'NAMA LOKASI',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    const Icon(
                                      Icons.place,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                TextFormField(
                                  controller: nameController,
                                  autofocus: false,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.name,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    RegExp regex = RegExp(r'^.{5,}$');
                                    if (value!.isEmpty) {
                                      return ("Sila isi butiran nama lokasi");
                                    }
                                    if (!regex.hasMatch(value)) {
                                      return ("masukkan minimum 5 huruf");
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    nameController.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    labelText: '',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                //ULASAN
                                Row(
                                  children: [
                                    Text(
                                      'ULASAN',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    const Icon(
                                      Icons.draw_rounded,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  minLines: 3,
                                  maxLines: null,
                                  controller: detailController,
                                  autofocus: false,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.multiline,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    RegExp regex = RegExp(r'^.{10,}$');
                                    if (value!.isEmpty) {
                                      return ("Sila isi butiran ulasan");
                                    }
                                    // if (!regex.hasMatch(value)) {
                                    //   return ("masukkan minimum 10 huruf");
                                    // }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    nameController.text = value!;
                                  },
                                  textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    labelText: '',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                const SizedBox(height: 10),

                                const SizedBox(height: 10),
                                //TIPS
                                Row(
                                  children: [
                                    Text(
                                      'Tips',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                    const Icon(
                                      Icons.draw_rounded,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  maxLines: null,
                                  minLines: 3,
                                  controller: tipsController,
                                  autofocus: false,
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.multiline,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    RegExp regex = RegExp(r'^.{10,}$');
                                    if (value!.isEmpty) {
                                      return ("Sila isi butiran tips");
                                    }
                                    // if (!regex.hasMatch(value)) {
                                    //   return ("masukkan minimum 10 huruf");
                                    // }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    nameController.text = value!;
                                  },
                                  textInputAction: TextInputAction.newline,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    labelText: '',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                SizedBox(height: 10.h),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.orange),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Batal ",
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.orange),
                                        onPressed: () {
                                          EasyLoading.show(
                                              status: 'Sedang diproses');
                                          uploadImage().then((value) {
                                            fireStoreService
                                                .updateLocationData(
                                                    detailController.text,
                                                    nameController.text.trim(),
                                                    tipsController.text,
                                                    widget.id,
                                                    imageNetworkList)
                                                .then((value) {
                                              EasyLoading.showSuccess(
                                                  "Kemaskini Info Lokasi Berjaya");
                                              Map<String, dynamic> a =
                                                  data.data()!;
                                              a.addAll({'id': widget.id});
                                              a.update('loc_pic',
                                                  (value) => imageNetworkList);
                                              a.update(
                                                  'loc_name',
                                                  (value) =>
                                                      nameController.text);
                                              a.update(
                                                  'loc_desc',
                                                  (value) =>
                                                      detailController.text);
                                              a.update(
                                                  'loc_tips',
                                                  (value) =>
                                                      tipsController.text);

                                              Navigator.pop(context);
                                              // Navigator.pop(context);

                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             PlaceDetail(
                                              //                 data: a)));
                                            });
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Simpan ",
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                            const Icon(
                                              Icons.save,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        // set up the buttons
                                        Widget cancelButton = TextButton(
                                          child: const Text("Tidak"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                        Widget continueButton = TextButton(
                                          child: const Text("Ya"),
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection("lokasi")
                                                .doc(widget.id)
                                                .delete();

                                            removeFavLoc();

                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                          },
                                        );

                                        // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          title: const Text("Buang Lokasi"),
                                          content: const Text(
                                              "Anda pasti mahu buang lokasi ini?"),
                                          actions: [
                                            cancelButton,
                                            continueButton,
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Future uploadImage() async {
    for (int i = 0; i <= imageFileList!.length; i++) {
      if (i == imageFileList!.length) {
        return;
      }
      String url = await storageServices.uploadFile(
          "location/${imageFileList![i].name}", File(imageFileList![i].path));
      imageNetworkList!.add(url);
    }
  }

  Future removeFavLoc() async {
    FirebaseFirestore.instance.collection("user").get().then((value) async {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          if ((element.data()["favLoc"] as List).contains(widget.id)) {
            Map<String, dynamic> data = element.data();
            (data["favLoc"] as List).remove(widget.id);

            await FirebaseFirestore.instance
                .collection("user")
                .doc(element.id)
                .set(data);
          }
        }
      }
    });
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null) {
      imageFileList = [];
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }
}
