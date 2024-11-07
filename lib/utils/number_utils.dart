class NumberUtils {
  static String sttFormat(int stt) {
    if (stt <= 0) {
      throw Exception("STT must be greater than 0");
    }
    String res = stt.toString();
    if (stt < 10) {
      return "0$res";
    }
    return res;
  }
}
