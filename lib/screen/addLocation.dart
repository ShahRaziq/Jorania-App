import 'dart:developer';
import 'dart:io';

import 'package:Jorania/providers/place_provider.dart';
import 'package:Jorania/services/firestore_service.dart';
import 'package:Jorania/services/storage_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  StorageServices storageServices = StorageServices();
  FireStoreService fireStoreService = FireStoreService();

  //formkey
  //default role =user

  //editting Controller
  final nameController = TextEditingController();
  final detailController = TextEditingController();
  final tipsController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    place.place = widget;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.anchor),
              Text(
                'Tambah Lokasi Memancing',
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
            ],
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
                          imageFileList!.isNotEmpty
                              ? SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: ListView.separated(
                                    itemCount: imageFileList!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      log(index.toString());
                                      return Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Image.file(
                                            File(imageFileList![index].path),
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                imageFileList!.removeAt(index);
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red),
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
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 10,
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 40),
                                  primary: Colors.orange),
                              onPressed: () {
                                selectImages();
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("MUAT NAIK GAMBAR"),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Icon(Icons.add_photo_alternate)
                                  ])),
                          const SizedBox(
                            height: 10,
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
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          //ULASAN
                          Row(
                            children: [
                              Text(
                                'KETERANGAN(Jenis Ikan/latar belakang)',
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
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 10),

                          const SizedBox(height: 10),
                          //TIPS
                          Row(
                            children: [
                              Text(
                                'Tips(Jenis umpan/masa/teknik yang sesuai)',
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
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              labelText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.orange),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Batal",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      SizedBox(
                                        width: 20.w,
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
                                    addLocation();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Tambah",
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      const Icon(
                                        Icons.add,
                                        color: Colors.green,
                                      )
                                    ],
                                  ),
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

  void addLocation() async {
    EasyLoading.show(status: "sedang diproses...");
    Position position = await _determinePosition();
    List<String> picUrl = await uploadImage();
    GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);

    await fireStoreService.uploadLocationData(geoPoint, detailController.text,
        nameController.text, picUrl, tipsController.text);
    EasyLoading.showSuccess("Lokasi baru berjaya ditambah!");
    Navigator.of(context).pop();
  }

  Future uploadImage() async {
    List<String> picUrl = [];
    for (int i = 0; i <= imageFileList!.length; i++) {
      if (i == imageFileList!.length) {
        return picUrl;
      }
      String url = await storageServices.uploadFile(
          "location/${imageFileList![i].name}", File(imageFileList![i].path));
      picUrl.add(url);
    }
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList = [];
      imageFileList!.addAll(selectedImages);
    }

    setState(() {});
  }

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
  }
}
