import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_widgets/input/text_input.dart';
import 'package:open_widgets/input/dropdown.dart' show OpenDropdown;
import 'package:open_widgets/notification/snackbar.dart';
import 'package:peer/states/essay.dart' show EssayState;
import '../base.dart' show BasePage;

class ChooseIPMPage extends StatelessWidget {
  const ChooseIPMPage({
    Key? key,
    this.naviBarIndex = -1,
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
    final ValueNotifier<String> clearNotifier = ValueNotifier("None");
    clearNotifier.addListener(() {
      print('Value changeds');
    });
    var essayContentInput = OpenTextInput(
      clearNotifier: clearNotifier,
      // defaultValue: essayState.essayContent,
      // minLines: 20,
      // maxLines: null,
      placeholder: "Enter your essay here...",
      onSubmitted: (text) {
        essayState.setEssayContent(text);
        show_snackbar_notification(
            context, 'Essay content saved.', 'dismiss', () {});
      },
      onChanged: (text) {
        if (text == '') {
          essayState.setPhotoInput();
        } else {
          essayState.setTextInput();
        }

        essayState.setEssayContent(text);
      },
      label: '',
      width: content_max_width,
    );
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
                      essayState.setEssayTitle(text);
                      show_snackbar_notification(
                          context, 'Essay title saved.', 'dismiss', () {});
                    },
                    onChanged: (text) {
                      essayState.setEssayTitle(text);
                    },
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
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              essayContentInput,
                              Positioned(
                                bottom: 15, // 调整按钮距离底部的位置
                                right: 15, // 调整按钮距离右侧的位置
                                child: Opacity(
                                  opacity: essayState.textInput ? 0.0 : 1.0,
                                  child: Tooltip(
                                    message: !essayState.textInput
                                        ? "Upload photos instead"
                                        : '',
                                    child: IconButton(
                                      icon: Icon(
                                          Icons.photo_album), // 将此处替换为您想要的图标
                                      onPressed: () {
                                        // 在这里处理图像上传或拍照操作
                                        if (!essayState.textInput) {
                                          // todo
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          essayState.essayContent != ''
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Tooltip(
                                          message: "Clear",
                                          child: IconButton(
                                              onPressed: () {
                                                print('clicked');
                                                clearNotifier.value = '';
                                                print('done');
                                                // essayState.setEssayContent("");
                                              },
                                              icon: Icon(Icons.clear))),
                                      Tooltip(
                                        message: "Submit",
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.done_all)),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
