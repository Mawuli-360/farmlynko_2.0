import 'dart:convert';

import 'package:farmlynko/feature/farmer/chat_ai/component/message.dart';
import 'package:farmlynko/feature/farmer/chat_ai/model/response_model.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_images.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  AlertDialog? _alertDialog;
  late TextEditingController promptController;
  late ResponseModel responseModel;
  final _formKey = GlobalKey<FormState>();
  final _textFieldFocusNode = FocusNode();
  String responseText = "";
  final List<Messages> _messages = [];
  bool isTyping = false;
  final bool _showSpeechDialog = false;

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  // Future<ResponseModel> getResponse(String prompt) async {
  //   final response =
  //       await http.post(Uri.parse("https://api.openai.com/v1/chat/completions"),
  //           headers: {
  //             "Content-Type": "application/json",
  //             "Authorization":
  //                 "Bearer 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"
  //           },
  //           body: jsonEncode({
  //             "model": "gpt-3.5-turbo",
  //             "messages": [
  //               {"role": "user", "content": prompt}
  //             ]
  //           }));

  //   return responseModel = responseModelFromJson(response.body);
  // }

  void sendMessage() async {
    if (promptController.text.isEmpty) {
      return;
    }
    Messages message = Messages(
      text: promptController.text,
      sender: Sender.user,
    );

    setState(() {
      _messages.insert(0, message);
      isTyping = true;
    });

    final response = await http.post(
        Uri.parse("https://newton-hackthon.onrender.com/chat"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"user_email": "string", "user_message": promptController.text}));


    setState(() {
      responseText =
          responseModelFromJson(response.body).message;
      _messages.insert(0, Messages(text: responseText, sender: Sender.bot));
      isTyping = false;
    });

    promptController.clear();
  }

  void sendVoiceMessage() async {
    if (_lastWords.isEmpty) {
      return;
    }
    Messages message = Messages(
      text: _lastWords,
      sender: Sender.user,
    );

    setState(() {
      _messages.insert(0, message);
      isTyping = true;
    });

  final response = await http.post(
        Uri.parse("https://newton-hackthon.onrender.com/chat"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({"user_email": "string", "user_message": _lastWords}));

    setState(() {
      responseText =
          responseModelFromJson(response.body).message;
      _messages.insert(0, Messages(text: responseText, sender: Sender.bot));
      isTyping = false;
    });

    _lastWords = "";
  }

  @override
  void initState() {
    super.initState();
    promptController = TextEditingController();
    _initSpeech();
  }

  @override
  void dispose() {
    promptController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          "Assistant",
          style: AppTextStyle.latoStyle(size: 14, color: AppColors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: _messages.isEmpty
                ? null
                : const DecorationImage(
                    image: AppImages.chatBackground, fit: BoxFit.cover)),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _speechToText.isListening
                ? Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 25.h,
                          width: 25.h,
                          child: Lottie.asset("assets/animation/listen.json")),
                      Gap(2.h),
                      Text(
                        _lastWords,
                        style: _messages.isEmpty
                            ? TextStyle(
                                fontSize: 13.sp,
                              )
                            : TextStyle(
                                fontSize: 13.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ))
                : Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: _messages.isEmpty
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.h),
                              child: SizedBox(
                                height: 65.h,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/chatbot.png",
                                      width: 30.h,
                                    ),
                                    Gap(3.h),
                                    Text(
                                      "How can we help you today?",
                                      style: AppTextStyle.latoStyle(
                                          size: 12,
                                          fontWeight: FontWeight.w100),
                                    ),
                                    Gap(3.h),
                                    Container(
                                      height: 7.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: AppColors.grey)),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Powered by OpenAI",
                                              style: AppTextStyle.latoStyle(
                                                  size: 10,
                                                  fontWeight: FontWeight.w100),
                                            ),
                                            Text("-Example: How to grow rice?",
                                                style: AppTextStyle.latoStyle(
                                                    size: 10,
                                                    color: AppColors.darkGrey))
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      reverse: true,
                                      itemCount: _messages.length,
                                      itemBuilder: (context, index) {
                                        return _messages[index];
                                      }),
                                ),
                                if (isTyping)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Lottie.asset(
                                          "assets/animation/loading.json",
                                          height: 4.h,
                                          width: 15.w),
                                    ],
                                  ),
                              ],
                            ),
                    ),
                  ),
            Container(
              height: 9.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xDCFFFFFF).withOpacity(.4),
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onLongPress: () {
                        _startListening();
                      },
                      onLongPressUp: () {
                        _stopListening();
                        sendVoiceMessage();
                      },
                      child: Container(
                          height: 5.h,
                          width: 5.h,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.mic,
                            color: AppColors.white,
                          ))),
                  Container(
                    height: 6.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        color: AppColors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w),
                      child: Form(
                        key: _formKey,
                        child: TextField(
                          style: TextStyle(fontSize: 12.sp),
                          controller: promptController,
                          focusNode: _textFieldFocusNode,
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: AppTextStyle.latoStyle(
                                  size: 10, color: AppColors.black),
                              hintText: "Send Message"),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        _textFieldFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(FocusNode());
                        sendMessage();
                      },
                      child: Container(
                          height: 5.h,
                          width: 5.h,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle),
                          child: const Icon(
                            Icons.send,
                            color: AppColors.white,
                          ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpeechDialog extends StatefulWidget {
  const SpeechDialog({super.key});

  @override
  State<SpeechDialog> createState() => _SpeechDialogState();
}

class _SpeechDialogState extends State<SpeechDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: const Text('Listening...'),
      ),
    );
  }
}
