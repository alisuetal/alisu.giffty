import 'dart:math';

import 'package:flutter/material.dart';
import 'package:giffty_flutter/models/dark_pair.dart';
import 'package:giffty_flutter/models/guest.dart';
import 'package:giffty_flutter/models/pair.dart';

class Event with ChangeNotifier {
  double? _price;
  final List<Guest> _guests = [];
  final List<DarkPair> _darkPairs = [];
  final List<Pair> _pairs = [];
  String _currency = "USD";

  int get guestCount {
    return _guests.length;
  }

  String get currency {
    return _currency.toString();
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

  void setCurrency(String value) {
    _currency = value;
    notifyListeners();
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
        .where((element) => ((element.pair[0].id == gOne.id &&
                element.pair[1].id == gTwo.id) ||
            (element.pair[0].id == gTwo.id && element.pair[1].id == gOne.id)))
        .isNotEmpty;
  }

  bool isTaken(Guest guest) {
    return _pairs
        .where((element) => (element.pair[1].id == guest.id))
        .isNotEmpty;
  }

  bool pairValidation(Guest gOne, Guest gTwo) {
    if (isPair(gOne, gTwo)) {
      return false;
    } else {
      if (isTaken(gTwo)) {
        return false;
      } else {
        if (gOne.id == gTwo.id) {
          return false;
        } else {
          if (isDarkPair(gOne, gTwo)) {
            return false;
          } else {
            return true;
          }
        }
      }
    }
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
    if (_pairs.isNotEmpty) {
      _pairs.clear();
    }
    while (_pairs.length < _guests.length) {
      if (_pairs.isNotEmpty) {
        _pairs.clear();
      }
      for (var gOne in _guests) {
        Guest? gTwo = getRandomPair(gOne);
        if (gTwo == null) {
          break;
        } else {
          Pair pair = createPair(gOne, gTwo);
          _pairs.add(pair);
        }
      }
    }
  }

  Guest? getRandomPair(Guest gOne) {
    List<Guest> triedGuests = [];
    while (triedGuests.length <= (_guests.length - 1)) {
      Guest guestTwo = _guests[Random().nextInt(_guests.length)];
      if (pairValidation(gOne, guestTwo)) {
        return guestTwo;
      } else if (!triedGuests.contains(guestTwo)) {
        triedGuests.add(guestTwo);
      }
    }
    return null;
  }

  void setDarkPair(Guest gOne, Guest gTwo) {
    if (verifyDarkPair(gOne, gTwo)) {
      _darkPairs.add(createDarkPair(gOne, gTwo));
    }
  }

  DarkPair createDarkPair(Guest gOne, Guest gTwo) {
    return DarkPair(
      id: darkPairs.isEmpty
          ? "0"
          : (int.parse(darkPairs.last.id) + 1).toString(),
      pair: [gOne, gTwo],
    );
  }

  bool verifyDarkPair(Guest gOne, Guest gTwo) {
    if (gOne.id != gTwo.id) {
      if (isDarkPair(gOne, gTwo) == false) {
        if (availabeDarkPair(inDarkPairs(gOne)) &&
            availabeDarkPair(inDarkPairs(gTwo))) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool availabeDarkPair(int x) {
    if ((guests.length % 2) == 1) {
      if (((guests.length - 1) - x) <= 2) {
        return false;
      } else {
        return true;
      }
    } else {
      if (((guests.length - 1) - x) <= 1) {
        return false;
      } else {
        return true;
      }
    }
  }

  int inDarkPairs(Guest guest) {
    return _darkPairs
        .where((element) =>
            (element.pair[0].id == guest.id || element.pair[1].id == guest.id))
        .length;
  }

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
