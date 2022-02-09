import 'package:flutter/material.dart';
import 'package:giffty_flutter/models/dark_pair.dart';
import 'package:giffty_flutter/models/guest.dart';
import 'package:giffty_flutter/models/pair.dart';

class Event with ChangeNotifier {
  double? _price;
  // List<Guest> _guests = [
  //   Guest(id: "1", approxPrice: 12.48, desiredGift: "a", name: "a"),
  //   Guest(id: "2", approxPrice: 12.48, desiredGift: "b", name: "b"),
  //   Guest(id: "3", approxPrice: 12.48, desiredGift: "c", name: "c")
  // ];
  List<Guest> _guests = [];
  List<DarkPair> _darkPairs = [];
  List<Pair> _pairs = [];

  int get guestCount {
    return _guests.length;
  }

  double get price {
    return _price ?? 0.00;
  }

  List<Guest> get guests {
    return [..._guests];
  }

  List<DarkPair> get darkPairs {
    return [..._darkPairs];
  }

  List<Pair> get pairs {
    return [..._pairs];
  }

  void setPrice(double price) {
    _price = price;
  }

  Guest _createGuest(String? id, String name, String gift, double price) {
    return Guest(
      id: guests.isEmpty ? "0" : (int.parse(guests.last.id) + 1).toString(),
      approxPrice: price,
      desiredGift: gift,
      name: name,
    );
  }

  DarkPair _createDarkPair(String? id, Guest gOne, Guest gTwo) {
    return DarkPair(
      id: darkPairs.isEmpty
          ? "0"
          : (int.parse(darkPairs.last.id) + 1).toString(),
      pair: [gOne, gTwo],
    );
  }

  bool isPair(Guest gOne, Guest gTwo) {
    return _pairs
        .where((element) => ((element.pair[0].id == gOne.id ||
                element.pair[0].id == gTwo.id) &&
            (element.pair[1].id == gOne.id || element.pair[1].id == gTwo.id)))
        .isNotEmpty;
  }

  bool isDarkPair(Guest gOne, Guest gTwo) {
    return _darkPairs
        .where((element) => ((element.pair[0].id == gOne.id ||
                element.pair[0].id == gTwo.id) &&
            (element.pair[1].id == gOne.id || element.pair[1].id == gTwo.id)))
        .isNotEmpty;
  }

  Pair createPair(Guest gOne, Guest gTwo) {
    return Pair(id: _pairs.length.toString(), pair: [gOne, gTwo]);
  }

  void setPairs() {
    for (var gOne in _guests) {
      _pairs.add(createPair(
          gOne, _guests.where((element) => element.id != gOne.id).first));
    }
  }

  // List<Guest> getRandomPair(Guest gOne) {
  //   List<Guest> triedGuests = [];
  //   while (triedGuests.length != (_guests.length - 1)) {
  //     Guest guestTwo = _guests[Random().nextInt(_guests.length)];
  //     if (!isPair(gOne, guestTwo)) {
  //       return [gOne, guestTwo];
  //     } else if (!triedGuests.contains(guestTwo)) {
  //       triedGuests.add(guestTwo);
  //     }
  //   }
  //   return [];
  // }

  void addDarkPair(Guest gOne, Guest gTwo) {
    _darkPairs.add(_createDarkPair(null, gOne, gTwo));
    notifyListeners();
  }

  void updateDarkPair(String id, Guest gOne, Guest gTwo) {
    _darkPairs[_darkPairs.indexWhere((element) => element.id == id)] =
        _createDarkPair(id, gOne, gTwo);
    notifyListeners();
  }

  void removeDarkPair(DarkPair darkPair) {
    _darkPairs.removeWhere((element) => element.id == darkPair.id);
    notifyListeners();
  }

  void updateGuest(String id, String name, String gift, double price) {
    _guests[_guests.indexWhere((element) => element.id == id)] =
        _createGuest(id, name, gift, price);
    notifyListeners();
  }

  void addGuest(String name, String gift, double price) {
    _guests.add(_createGuest(null, name, gift, price));
    notifyListeners();
  }

  void removeGuest(Guest guest) {
    _guests.removeWhere((element) => element.id == guest.id);
    notifyListeners();
  }
}
