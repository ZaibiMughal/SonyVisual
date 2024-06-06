import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share/share.dart';
import 'package:short_video/config/colors_config.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTConstant.dart';

import 'TTImages.dart';

Widget dot() {
  return Container(
    height: 7,
    width: 7,
    decoration: BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
  );
}

class PinEntryTextField extends StatefulWidget {
  final String? lastPin;
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  PinEntryTextField({this.lastPin, this.fields = 4, this.onSubmit, this.fieldWidth = 40.0, this.fontSize = 16.0, this.isTextObscure= false, this.showFieldAsBox= false}) : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  late List<String?> _pin;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;

  Widget textfields = Container();

  @override
  void initState() {
    super.initState();
    _pin = List<String?>.filled(widget.fields, null, growable: false);
    _focusNodes = List<FocusNode?>.filled(widget.fields, null, growable: false);
    _textControllers = List<TextEditingController?>.filled(widget.fields, null, growable: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        if (widget.lastPin != null) {
          for (var i = 0; i < widget.lastPin!.length; i++) {
            _pin[i] = widget.lastPin![i];
          }
        }
        textfields = generateTextFields(context);
      });
    });
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController? t) => t!.dispose());
    super.dispose();
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    if (_pin.first != null) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, verticalDirection: VerticalDirection.down, children: textFields);
  }

  void clearTextFields() {
    _textControllers.forEach((TextEditingController? tEditController) => tEditController!.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    if (_focusNodes[i] == null) {
      _focusNodes[i] = FocusNode();
    }
    if (_textControllers[i] == null) {
      _textControllers[i] = TextEditingController();
      if (widget.lastPin != null) {
        _textControllers[i]!.text = widget.lastPin![i];
      }
    }

    _focusNodes[i]!.addListener(() {
      if (_focusNodes[i]!.hasFocus) {}
    });

    final String lastDigit = _textControllers[i]!.text;

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        cursorColor: Colors.white24,
        style: primaryTextStyle(color: white, size: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
            counterText: "",
            enabledBorder: widget.showFieldAsBox ? new OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: Colors.white24)) : null,
            focusedBorder: widget.showFieldAsBox ? new OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: TTColorRed)) : null,
            border: widget.showFieldAsBox ? new OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: Colors.white24)) : null),
        onChanged: (String str) {
          setState(() {
            _pin[i] = str;
          });
          if (i + 1 != widget.fields) {
            _focusNodes[i]!.unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            } else {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            }
          } else {
            _focusNodes[i]!.unfocus();
            if (lastDigit != null && _pin[i] == '') {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          }
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
        onSubmitted: (String str) {
          if (_pin.every((String? digit) => digit != null && digit != '')) {
            widget.onSubmit(_pin.join());
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return textfields;
  }
}

Widget ttAppBar(BuildContext context, String title, {List<Widget>? actions, bool showBack = true, Color color = black, Color? iconColor = white, bool? centerLogo}) {
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: centerLogo != null ? 100 : AppBarTheme.of(context).toolbarHeight,
    backgroundColor: color,
    centerTitle: true,
    leading: showBack
        ? IconButton(
            onPressed: () {
              finish(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: iconColor ?? null),
          )
        : null,
    title: centerLogo == true ? Container(
        decoration: boxDecorationWithRoundedCorners(
            borderRadius: radius(16)),
        child: Image.asset(TT_ic_logo, height: 80)
            .cornerRadiusWithClipRRect(16)).center() : Text(title, style: boldTextStyle(color: white, size: 18), maxLines: 1),
    actions: actions,
  );
}

Container ttEditTextStyle(var hintText, {var keyboardType = TextInputType.text}) {
  return Container(
    child: TextFormField(
      style: primaryTextStyle(size: 16, color: Colors.white54),
      cursorColor: Colors.white54,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: primaryTextStyle(
          color: Colors.white54,
          size: 14,
        ),
        labelStyle: primaryTextStyle(color: Colors.white54),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      ),
    ),
  );
}

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? Colors.white,
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: shadowColorGlobal) : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

void onShareTap(BuildContext context, {String? msg}) async {
  final RenderBox box = context.findRenderObject() as RenderBox;
  Share.share(msg ?? TTAppName, subject: '', sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

Function(BuildContext, String) placeholderWidgetFn() => (_, s) => placeholderWidget();

Widget placeholderWidget() => Image.asset('images/sonyVisual/placeholder.png', fit: BoxFit.cover);

Widget commonCacheImageWidget(String? url, {double? width, BoxFit? fit, double? height}) {
  if (url!.validate().startsWith('http')) {
    if (isMobile) {
      return CachedNetworkImage(
        placeholder: placeholderWidgetFn() as Widget Function(BuildContext, String)?,
        imageUrl: '$url',
        height: height,
        width: width,
        fit: fit,
      );
    } else {
      return Image.network(url, height: height, width: width, fit: fit);
    }
  } else {
    return Image.asset(url, height: height, width: width, fit: fit);
  }
}


enum AlertType { info, warning, error, success }
