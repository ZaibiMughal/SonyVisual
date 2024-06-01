import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils._();

  static Connectivity connectivity = Connectivity();

  static Future<bool> launchExternalUrl(Uri url) async {
    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
      return true;
    } catch(e){
      print(e.toString());
      return false;
    }
  }

  static Future<List<ConnectivityResult>> getConnectivityStatus() async {
    late List<ConnectivityResult> result;
      result = await connectivity.checkConnectivity();
      return result;
  }

  static bool isOnline(List<ConnectivityResult> connectionStatus){
    return connectionStatus.contains(ConnectivityResult.mobile) ||
        connectionStatus.contains(ConnectivityResult.wifi) ||
        connectionStatus.contains(ConnectivityResult.ethernet) ||
        connectionStatus.contains(ConnectivityResult.vpn);
  }

  static Future<bool> isUserOnline() async {
    List<ConnectivityResult> result = await getConnectivityStatus();
    return isOnline(result);
  }


  static String getIdFromUrl(String url){
    List<String> arr = url.split("?");
    arr = arr[0].split("/");
    return arr[arr.length - 1];
  }
}




