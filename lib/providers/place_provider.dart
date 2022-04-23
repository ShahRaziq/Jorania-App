import 'package:flutter/cupertino.dart';

class PlaceProvider with ChangeNotifier {
  Widget? place;
  setPlace(Widget w) {
    place = w;
  }
}
