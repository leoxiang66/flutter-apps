import 'package:flutter/material.dart';
import 'dart:math';
import 'chat_msg.dart';

class OpenChatPage extends StatefulWidget {
  final Future<String> Function(String input) reply_func;

  const OpenChatPage({super.key, required this.reply_func});

  @override
  State<OpenChatPage> createState() => _OpenChatPageState();
}

class _OpenChatPageState extends State<OpenChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<OpenChatMessage> _messages = [];
  final FocusNode _focusNode = FocusNode(); // 添加FocusNode实例
  final ScrollController _scrollController = ScrollController();
  bool isWaitingForResponse = true;

  Future<String> _3dots() async {
    int typingDelay = 250; // 每个字符的延迟时间，单位为毫秒

    StringBuffer stringBuffer = StringBuffer();
    while (isWaitingForResponse) {
      String response = stringBuffer.toString();
      if (response == '....') {
        stringBuffer.clear();
      } else {
        await Future.delayed(Duration(milliseconds: typingDelay)); // 等待延迟时间
        stringBuffer.write('.');
      }

      {
        OpenChatMessage botMessage = OpenChatMessage(
          text: stringBuffer.toString(),
          sender: "bot",
          isImage: false,
        );

        setState(() {
          if (_messages.isNotEmpty &&
              _messages.last.sender == "bot" &&
              !_messages.last.isImage) {
            _messages.removeLast(); // 移除上一个botMessage
          }
          _messages.add(botMessage); // 添加新的botMessage
          scroll_bottom();
        });
      }
    }
    return '';
  }

  bool _isImageSearch = false;

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    OpenChatMessage message = OpenChatMessage(
      text: _controller.text,
      sender: "user",
      isImage: false,
    );

    setState(() {
      isWaitingForResponse = true;
      _messages.add(message);
      scroll_bottom();
    });

    _controller.clear();

    if (_isImageSearch) {
      // final request = GenerateImage(message.text, 1, size: "256x256");
      // final response = await chatGPT!.generateImage(request);
      final response = await widget.reply_func(message.text);
      // Vx.log(response!.data!.last!.url!);
      // insertNewData(response.data!.last!.url!, isImage: true);
      insertNewData(response, isImage: true);
    } else {
      _3dots();
      String response = await widget.reply_func(message.text).whenComplete(() {
        isWaitingForResponse = false;
        // setState(() {
        //   _messages.removeLast();
        // });
      });

      insertNewData(response);
    }
  }

  void insertNewData(String response, {bool isImage = false}) async {
    int typingDelay = 5; // 每个字符的延迟时间，单位为毫秒

    StringBuffer stringBuffer = StringBuffer();
    for (int i = 0; i < response.length; i++) {
      stringBuffer.write(response[i]);
      await Future.delayed(Duration(milliseconds: typingDelay)); // 等待延迟时间

      OpenChatMessage botMessage = OpenChatMessage(
        text: stringBuffer.toString(),
        sender: "bot",
        isImage: isImage,
      );

      setState(() {
        if (_messages.isNotEmpty &&
            _messages.last.sender == "bot" &&
            !_messages.last.isImage) {
          _messages.removeLast(); // 移除上一个botMessage
        }
        _messages.add(botMessage); // 添加新的botMessage
        scroll_bottom();
      });
    }
  }

  void scroll_bottom() {
    _scrollController.jumpTo(
      _scrollController.position.maxScrollExtent, // 立即滚动到底部
    );
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8), // 设置四周的padding值
            child: TextField(
              controller: _controller,
              focusNode: _focusNode, // 将TextField与_focusNode关联
              onSubmitted: (value) {
                _sendMessage();
                // auto-focus
                _focusNode.requestFocus(); // 自动将焦点聚焦到TextField
              },
              decoration: const InputDecoration.collapsed(
                  hintText: "Question/description"),
            ),
          ),
        ),
        ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                _isImageSearch = false;
                _sendMessage();
                // auto-focus
                _focusNode.requestFocus(); // 自动将焦点聚焦到TextField
              },
            ),
            // Padding(
            //   padding: EdgeInsets.all(8.0), // 设置四周的padding值
            //   child: TextButton(
            //     onPressed: () {
            //       _isImageSearch = true;
            //       _sendMessage();
            //     },
            //     child: const Text("Generate Image"),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ChatGPT Demo"),
          centerTitle: true, // 将标题居中
          backgroundColor:
              const Color.fromARGB(100, 212, 250, 226), // 设置背景颜色为白色
          foregroundColor: Colors.black, // 设置前景色为黑色，以确保标题在白色背景上可见
        ),
        backgroundColor: Colors.white, // 设置背景颜色为白色，或者您想要的其他颜色
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                controller: _scrollController, // 添加ScrollController
                reverse: false,
                // padding: const EdgeInsets.all(10),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              )),
              const Divider(
                height: 1.0,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: _buildTextComposer(),
              )
            ],
          ),
        ));
  }
}
