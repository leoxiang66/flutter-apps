import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_widgets/input/text_input.dart' show OpenTextInput;
import 'package:open_widgets/input/dropdown.dart' show OpenDropdown;
import 'package:open_widgets/notification/snackbar.dart';
import 'package:peer/states/essay.dart' show EssayState;
import '../../states/utils.dart' show essay_info_complete;
import '../../states/utils.dart';
import '../base.dart' show BasePage;

class ChooseIPMPage extends StatelessWidget {
  const ChooseIPMPage({
    Key? key,
    this.naviBarIndex = 0,
  }) : super(key: key);

  final int naviBarIndex;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double imagePaddingValue =
        screenSize.width * 0.05; // Set image padding to 5% of screen width
    var sizedBox = SizedBox(
      height: imagePaddingValue,
    );
    var content_max_width = screenSize.width * 0.8;
    var essayState = context.watch<EssayState>();


    return BasePage(
      naviBarIndex: naviBarIndex,
      singleChildScrollView: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(imagePaddingValue, 0, imagePaddingValue, 0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sizedBox,
                Text(
                  'Insert Essay',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sizedBox,
                OpenTextInput(
                    onSubmitted: (text) {
                      print(text);
                      essayState.setEssayTitle(text);
                      show_snackbar_notification(
                          context, 'Essay title saved.', 'dismiss', () {});
                    },
                    onChanged: (text) {},
                    label: 'Title of  Essay',
                    width: content_max_width),
                sizedBox,
                SizedBox(
                  width: content_max_width,
                  child: Row(
                    children: [
                      OpenDropdown(
                          hint: 'Essay Type',
                          items: ['o1'],
                          onChanged: (text) {
                            print(text);
                            essayState.setEssayType(text);
                            show_snackbar_notification(
                                context, 'Essay type saved.', 'dismiss', () {});
                          },
                          width: content_max_width / 3),
                      Expanded(child: SizedBox()),
                      OpenDropdown(
                          hint: 'Study Year',
                          items: ['o1'],
                          onChanged: (text) {
                            print(text);
                            essayState.setStudyYear(text);
                            show_snackbar_notification(
                                context, 'Study year saved.', 'dismiss', () {});
                          },
                          width: content_max_width / 3),
                    ],
                  ),
                ),
                sizedBox,
                essayState.essay_info_complete()
                    ? SizedBox(
                        width: content_max_width,
                        child: Column(
                          children: [
                            sizedBox,
                            Text(
                              "How do you want to upload your essay?",
                              style: TextStyle(fontSize: 18),
                            ),
                            sizedBox,
                            Row(
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.lightBlueAccent)),
                                    onPressed: () {
                                      print('manually enter essay...');
                                    },
                                    child: Text("Manually Enter")),
                                Expanded(child: SizedBox()),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.lightBlueAccent)),
                                    onPressed: () {
                                      print('upload photo...');
                                    },
                                    child: Text("Upload photo")),
                              ],
                            )
                          ],
                        ))
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
