class Responsive {}

class Demension {
  static double small = 800;
  static double larger = 1200;

  static double bodyWith(double width) {
    if (width == small) {
      return width;
    } else if (width >= larger) {
      return width * 2 / 3;
    } else {
      return width * 3 / 4;
    }
  }
}
