import 'package:intl/intl.dart';

class CurrencyUtils {
  static String convertDoubletoKMB(double currency) {
    if (currency < 1000) {
      return currency.toStringAsFixed(0);
    } else if (currency < 1000000) {
      double result = currency / 1000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
    } else if (currency < 1000000000) {
      double result = currency / 1000000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}tr';
    } else {
      double result = currency / 1000000000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}T';
    }
  }

  static String convertDoubleToCurrency(double number) {
    final formatter = NumberFormat("#,###", "vi_VN");

    String temp = formatter.format(number);
    return temp.replaceAll(RegExp("r','"), ".");
  }
}
