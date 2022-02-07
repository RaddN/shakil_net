import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1954971990366031/8731563225";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1954971990366031/7403267161";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1954971990366031/1401676031";
    } else if (Platform.isIOS) {
      return "ca-app-pub-1954971990366031/1959368792";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}