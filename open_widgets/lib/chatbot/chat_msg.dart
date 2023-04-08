import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OpenChatMessage extends StatelessWidget {
  const OpenChatMessage(
      {super.key,
      required this.text,
      required this.sender,
      this.isImage = false});

  final String text;
  final String sender;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    var avatar = Text(sender)
        .text
        .subtitle1(context)
        .make()
        .box
        .color(sender == "user" ? Vx.red200 : Vx.green200)
        .p16
        .rounded
        .alignCenter
        .makeCentered();
    var msg = Expanded(
      child: isImage
          ? AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                text,
                loadingBuilder: (context, child, loadingProgress) =>
                    loadingProgress == null
                        ? child
                        : const CircularProgressIndicator.adaptive(),
              ),
            )
          : text.trim().text.bodyText1(context).make().px8(),
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: sender == "user" ? Colors.white : Color(0xFFF7F7F8),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children:
              // sender=='user'?
              [avatar, msg]
          // :[msg,avatar],
          ),
    );
  }
}
