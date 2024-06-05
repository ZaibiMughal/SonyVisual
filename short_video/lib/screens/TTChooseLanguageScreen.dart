import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:short_video/utils/TTColors.dart';
import 'package:short_video/utils/TTWidgets.dart';

class TTChooseLanguageScreen extends StatefulWidget {
  static String tag = '/TTChooseLanguageScreen';

  @override
  TTChooseLanguageScreenState createState() => TTChooseLanguageScreenState();
}

class TTChooseLanguageScreenState extends State<TTChooseLanguageScreen> {
  List<String> programmingList = ["हिंदी", "मराठी", "ਪੰਜਾਬੀ", "ગુજરાતી", "English", "বাংলা", "اُردُو", "français"];

  List<String> selectedProgrammingList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TTBackgroundBlack,
      appBar: ttAppBar(context, "Choose Language") as PreferredSizeWidget?,
      body: Responsive(
        mobile: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MultiSelectChip(
              programmingList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedProgrammingList = selectedList;
                });
              },
            ).paddingOnly(left: 8, right: 8),
            Align(
              child: TextButton(
                onPressed: () {
                  toast("Save");
                  finish(context);
                },
                child: Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    padding: EdgeInsets.only(top: 6, bottom: 6),
                    width: context.width(),
                    decoration: boxDecorationWithRoundedCorners(borderRadius: BorderRadius.circular(4), backgroundColor: TTColorRed),
                    child: Text('Save', textAlign: TextAlign.center, style: primaryTextStyle(color: white))),
              ).paddingAll(16),
            )
          ],
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>)? onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          selectedColor: TTColorRed,
          backgroundColor: TTBackgroundBlack,
          shape: StadiumBorder(
            side: BorderSide(color: Colors.white24),
          ),
          labelStyle: primaryTextStyle(color: white),
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item) ? selectedChoices.remove(item) : selectedChoices.add(item);
              widget.onSelectionChanged!(selectedChoices);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
