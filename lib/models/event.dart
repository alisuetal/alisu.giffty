import 'package:flutter/material.dart';
import 'package:giffty_flutter/models/dark_pair.dart';
import 'package:giffty_flutter/models/guest.dart';
import 'package:giffty_flutter/models/pair.dart';

class Event with ChangeNotifier {
  int? _price;
  List<Guest> _guests = [];
  List<DarkPair> _darkPairs = [];
  List<Pair> _pairs = [];

  int get guestCount {
    return _guests.length;
  }

  List<Guest> get guests {
    return [..._guests];
  }

  void setPrice(int price) {
    _price = price;
  }

  void addGuest(Guest guest) {
    _guests.add(guest);
    notifyListeners();
  }

  void removeGuest(Guest guest) {
    _guests.removeWhere((element) => element.id == guest.id);
    notifyListeners();
  }
}
