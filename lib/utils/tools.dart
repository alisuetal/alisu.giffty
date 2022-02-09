class Tools {
  String formatPrice(double price) {
    if (price.toString().length < 3) {
      if (price.toString().length == 1) {
        return "0.0" + price.toString();
      } else {
        return "0." + price.toString();
      }
    } else {
      List<String> i = price.toString().split('').reversed.toList();
      if (price.toString().length > 5) {
        i.insert(6, ",");
      }
      return i.reversed.join('').toString();
    }
  }

  double deformatPrice(String price) {
    return double.parse(price.replaceAll(",", ''));
  }
}
