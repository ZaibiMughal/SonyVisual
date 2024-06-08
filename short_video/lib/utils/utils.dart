import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/main_config.dart';

class Utils {
  Utils._();

  static InterstitialAd? interstitialAd;
  static BannerAd? bannerAd;
  final AdSize adSize = const AdSize(width: 320, height: 50);

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

  static RegExp regShortYoutubeUrlExp = RegExp(r'^https?:\/\/(www\.)?youtube\.com\/shorts\/[a-zA-Z0-9_-]{11}(\?[\w=&-]+)?$');
  static RegExp regYoutubeUrlExp = RegExp(r'^(https:\/\/)?(www\.)?(youtube\.com\/(watch\?v=|embed\/|channel\/)|youtu\.be\/)[a-zA-Z0-9_-]{11,}$');


  static Future<bool> requestStoragePermission() async {

    Map<Permission, PermissionStatus> statuses;

    if(isIOS) {
      statuses = await [
        Permission.photos,
        Permission.mediaLibrary,
        Permission.storage,
      ].request();
    } else {
      statuses = await [
        Permission.storage,
      ].request();
    }

    bool isAllGranted = true;
    statuses.forEach((key, value) {
      print('$key ${value.isGranted}');
      if(!value.isGranted){
        isAllGranted = false;
      }
    });

    if(isAllGranted){
      // ToastConfig.showToast(message: "Permissions Granted");
    } else {
      // ToastConfig.showToast(message: "Some or All Permissions not Granted");
    }
    return isAllGranted;
  }

  static Future<bool> requestWebrtcPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    bool isAllGranted = true;
    statuses.forEach((key, value) {
      if(!value.isGranted){
        isAllGranted = false;
      }
    });

    if(isAllGranted){
      // ToastConfig.showToast(message: "Permissions Granted");
    } else {
      // ToastConfig.showToast(message: "Some or All Permissions not Granted");
    }
    return isAllGranted;
  }

  static Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
        adUnitId: isAndroid ? Config.androidAdMobInterstitialUnitId : Config.iOSAdMobInterstitialUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
          },
        ));
  }

  static void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: isAndroid ? Config.androidAdMobBannerUnitId : Config.iOSAdMobBannerUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          // Dispose the ad here to free resources.
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    )..load();
  }

  static Future<bool> showInterstitialAd() async {
    final random = Random();

    // Showing interstitial ad randomly
    int number = random.nextInt(5);
    if (number >= 3) {
      if (Utils.interstitialAd != null) {
        await Utils.loadInterstitialAd();
        await Utils.interstitialAd!.show();
        return true;
      }
    }
    return false;
  }

  static Future<File?> pickImg() async {
    File? file;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      file = File(image.path);
    }
    return file;
  }

}




