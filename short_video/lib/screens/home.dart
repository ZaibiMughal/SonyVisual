import 'dart:collection';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_video/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/colors_config.dart';
import '../config/toast_config.dart';
import '../utils/TTWidgets.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _webViewKey = GlobalKey();
  final ReceivePort _port = ReceivePort();

  late String _url;
  late URLRequest _urlRequest;
  late double _progress;
  late InAppWebViewController _webViewController;
  late InAppWebViewSettings _settings;

  PullToRefreshController? _pullToRefreshController;
  TextEditingController controller = TextEditingController(text: "");
  DateTime? _currentBackPressTime;
  int _currentScreenIndex = 1;
  List<String>? _favoriteList;
  final String _errorImage =
      "https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg";


  @override
  void initState() {
    super.initState();
    checkPermissions();
    initWebView();
  }


  Future<void> initWebView() async {
    _url = "https://chat.sonyplays.com/";
    _progress = 0;
    WebUri urlUri = WebUri(_url);
    _urlRequest = URLRequest(url: urlUri);


    _settings = InAppWebViewSettings(
        isInspectable: kDebugMode,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllow: "camera; microphone",
        allowBackgroundAudioPlaying: true,
        allowContentAccess: true,
        allowFileAccess: true,
        alwaysBounceVertical: true,
        defaultFixedFontSize: 16,
        horizontalScrollbarTrackColor: ColorsConfig.p_color,
        // allowUniversalAccessFromFileURLs: false,
        iframeAllowFullscreen: true);

    _pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        reloadWebView();
      },
    );
  }

  reloadWebView() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _webViewController.reload();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      _webViewController.loadUrl(
          urlRequest: URLRequest(url: await _webViewController.getUrl()));
    }
  }

  onWillPopUp() async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return Future.value(false);
    } else {
      DateTime now = DateTime.now();
      if (_currentBackPressTime == null ||
          now.difference(_currentBackPressTime!) > const Duration(seconds: 2)) {
        _currentBackPressTime = now;
        ToastConfig.showToast(message: "Press again to exit!", context: context, title: 'Important');
        return Future.value(false);
      }
      return Future.value(true);
    }
  }


  checkPermissions() async{
    await Utils.requestStoragePermission();
    await Utils.requestWebrtcPermission();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    // if (currentBackPressTime == null ||
    //     now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    //   currentBackPressTime = now;
    //   Fluttertoast.showToast(msg: "Press again to exit");
    //   return Future.value(false);
    // }
    return Future.value(true);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ttAppBar(context, "Chat") as PreferredSizeWidget?,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: InAppWebView(
            key: _webViewKey,
            initialUrlRequest: _urlRequest,
            initialSettings: _settings,
            pullToRefreshController:
            _pullToRefreshController,
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                this._url = url.toString();
              });
            },
            onPermissionRequest:
                (controller, request) async {
              return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT);
            },
            shouldOverrideUrlLoading:
                (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              _pullToRefreshController!.endRefreshing();
              setState(() {
                this._url = url.toString();
              });
            },
            onReceivedHttpError:
                (controller, request, errorResponse) async {
              // Handle HTTP errors here
              var isForMainFrame =
                  request.isForMainFrame ?? false;
              if (!isForMainFrame) {
                return;
              }

              const snackBar = SnackBar(
                content: Text(
                    'Something went wrong!'
                ),
              );
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBar);
            },
            onReceivedError:
                (controller, request, error) async {
              _pullToRefreshController?.endRefreshing();
              var isForMainFrame =
                  request.isForMainFrame ?? false;
              if (!isForMainFrame ||
                  (!kIsWeb &&
                      defaultTargetPlatform ==
                          TargetPlatform.iOS &&
                      error.type ==
                          WebResourceErrorType.CANCELLED)) {
                return;
              }

              var errorUrl = request.url;
              controller.loadData(data: """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style>
    ${await InAppWebViewController.tRexRunnerCss}
    </style>
    <style>
    .interstitial-wrapper {
        box-sizing: border-box;
        font-size: 1em;
        line-height: 1.6em;
        margin: 0 auto 0;
        max-width: 600px;
        width: 100%;
    }
    </style>
</head>
<body>
    ${await InAppWebViewController.tRexRunnerHtml}
    <div class="interstitial-wrapper">
      <h1>${'Web error'}</h1>
    </div>
</body>
    """, baseUrl: errorUrl, historyUrl: errorUrl);
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                _pullToRefreshController!.endRefreshing();
              }
              setState(() {
                _progress = progress / 100;
              });
            },
            onUpdateVisitedHistory:
                (controller, url, androidIsReload) {
              setState(() {
                _url = url.toString();
              });
            },
            onConsoleMessage: (controller, consoleMessage) {
              if (kDebugMode) {
                print(consoleMessage);
              }
            },
            onDownloadStartRequest:
                (InAppWebViewController controller,
                DownloadStartRequest
                downloadStartRequest) async {
            },
          ),
        ),
      ),
    );
  }
}