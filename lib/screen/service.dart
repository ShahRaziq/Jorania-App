import 'package:Jorania/providers/place_provider.dart';
import 'package:Jorania/screen/editService.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ServiceDetail extends StatefulWidget {
  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    place.place = widget;
    final picUrl = [
      'https://images.unsplash.com/photo-1510525009512-ad7fc13eefab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      'https://images.unsplash.com/photo-1598597285544-73cde918c78d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=728&q=80',
      'https://www.dnamelangkawi.com/v1/images/blog/image5b.jpg',
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'sunting_hero',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => EditService()));
        },
        label: const Text("kemaskini"),
        icon: const Icon(Icons.edit),
        backgroundColor: Colors.orange,
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text('Servis '),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(20.w),
                  // color: Color.fromARGB(255, 163, 130, 130),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(height: 255.0),
                    itemCount: picUrl.length,
                    itemBuilder: (context, index, realIndex) {
                      final picurl = picUrl[index];

                      return buildImage(picurl, index);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.add_a_photo),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Kapal Sewa Nezukodse',
                    style:
                        TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                height: 300.h,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Lokasi memancing yang menjadi tumpuan orang ramai terutamanya pada malam minggu. Lokasi bersih dan selesa. jhsajdhskajdhkjshdjkashdkjhsjd jdhkajshdkja joirejvcvbn fjoiwjeofinsccv nihwihgohdjsnfjsnjhnfew./?fsjfoihwfuif',
                    style: TextStyle(),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20, 1, 1, 1),
              child: Row(children: [
                Text(
                  'Info servis',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                )
              ]),
            ),

            //content keterangan
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Container(
                    height: 160.h,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month_rounded),
                              SizedBox(width: 5.w),
                              Text(
                                'Isnin-Jumaat',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [
                              Icon(Icons.alarm),
                              SizedBox(width: 5.w),
                              Text(
                                '8:00pg-10:30mlm',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(width: 5.w),
                              Text(
                                '0166754876',
                                style: TextStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(1),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.edit),
                    ),
                  ],
                ),
              ],
            ),
            //header tips

            //content tips

            SizedBox(height: 20.h),
            //button GPS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(50, 50),
                        primary: Colors.deepOrange[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(13))),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.whatsapp,
                          color: Colors.green[400],
                          size: 35,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Whatsapp',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        )
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget buildImage(String picurl, int index) => Container(
        // margin: EdgeInsets.symmetric(horizontal: 19),
        color: Colors.grey,
        child: Image.network(
          picurl,
          fit: BoxFit.cover,
        ),
      );
}
