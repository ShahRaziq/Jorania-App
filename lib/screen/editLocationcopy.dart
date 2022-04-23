import 'dart:developer';
import 'dart:io';

import 'package:Jorania/providers/place_provider.dart';
import 'package:Jorania/screen/list_service.dart';
import 'package:Jorania/screen/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditService extends StatefulWidget {
  const EditService({Key? key}) : super(key: key);

  @override
  State<EditService> createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  final nameController = new TextEditingController();
  final hariController = new TextEditingController();
  final waktuController = new TextEditingController();
  final detailController = new TextEditingController();
  final operasiController = new TextEditingController();
  final telefonController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    place.place = widget;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,
        title: Text(
          'Kemaskini Servis Memancing',
          style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                        imageFileList!.length != 0
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
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red),
                                              child: Icon(
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
                                    return SizedBox(
                                      width: 10,
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 40),
                                primary: Colors.orange),
                            onPressed: () {
                              selectImages();
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("MUAT NAIK GAMBAR"),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(Icons.add_photo_alternate)
                                ])),
                        SizedBox(
                          height: 20,
                        ),
                        //NAMA LOKASI
                        Row(
                          children: [
                            Text(
                              'NAMA SERVIS',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
                              Icons.store,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        TextFormField(
                          controller: operasiController,
                          autofocus: false,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{5,}$');
                            if (value!.isEmpty) {
                              return ("Sila isi butiran nama servis");
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
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 15),
                        //hari operasi
                        Row(
                          children: [
                            Text(
                              'HARI OPERASI',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              '(cth: Isnin-Ahad)',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                        SizedBox(height: 3),
                        TextFormField(
                          controller: hariController,
                          autofocus: false,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{5,}$');
                            if (value!.isEmpty) {
                              return ("Sila isi butiran hari operasi");
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
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 15),
                        //waktu operasi
                        Row(
                          children: [
                            Text(
                              'WAKTU OPERASI',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
                              Icons.alarm,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              '(cth: 8.30pg-10.30mlm)',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                        SizedBox(height: 3),
                        TextFormField(
                          controller: waktuController,
                          autofocus: false,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{5,}$');
                            if (value!.isEmpty) {
                              return ("Sila isi butiran waktu operasi");
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
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        //nombor telefon
                        Row(
                          children: [
                            Text(
                              'NO. TELEFON',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
                              Icons.whatsapp,
                              color: Colors.black54,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              '(cth: 01234567891)',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            )
                          ],
                        ),
                        SizedBox(height: 3),
                        TextFormField(
                          controller: telefonController,
                          autofocus: false,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            RegExp regex =
                                new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                            if (value!.isEmpty) {
                              return ("Sila isi butiran no. telefon");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("masukkan no. telefon yang betul seperti contoh");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            nameController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        //ULASAN
                        Row(
                          children: [
                            Text(
                              'KETERANGAN',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Icon(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{10,}$');
                            if (value!.isEmpty) {
                              return ("Sila isi butiran keterangan");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("masukkan minimum 10 huruf");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            nameController.text = value!;
                          },
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: '',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(height: 10),

                        SizedBox(height: 10),
                        //TIPS

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
                                      "Batal ",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Icon(
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
                                  // addLocation();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Simpan ",
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Icon(
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
                                  child: Text("Tidak"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                                Widget continueButton = TextButton(
                                  child: Text("Ya"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                );

                                // set up the AlertDialog
                                AlertDialog alert = AlertDialog(
                                  title: Text("Buang Servis"),
                                  content:
                                      Text("Anda pasti mahu buang servis?"),
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
                              icon: Icon(
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
      ]),
    );
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList = [];
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }
}
