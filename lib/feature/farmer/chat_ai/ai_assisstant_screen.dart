import 'dart:async';
import 'dart:convert';

import 'package:farmlynko/feature/farmer/chat_ai/component/message.dart';
import 'package:farmlynko/feature/farmer/chat_ai/model/response_model.dart';
import 'package:farmlynko/shared/resource/app_colors.dart';
import 'package:farmlynko/shared/resource/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  late TextEditingController promptController;
  late ResponseModel responseModel;
  String responseText = "";
  final List<Messages> _messages = [];
  bool isTyping = false;
  var isSpeaking = false;
  var text = "";
  StreamSubscription? _subscription;
  SpeechToText speechToText = SpeechToText();

  Future<ResponseModel> getResponse(String prompt) async {
    final response =
        await http.post(Uri.parse("https://api.openai.com/v1/chat/completions"),
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer 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"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": prompt}
              ]
            }));

    return responseModel = responseModelFromJson(response.body);
  }

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

    // setState(() {
    //   responseText = response.choices[0].message.content;
    //   _messages.insert(0, Messages(text: responseText, sender: Sender.bot));
    //   isTyping = false;
    // });

    final response =
        await http.post(Uri.parse("https://api.openai.com/v1/chat/completions"),
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer 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"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": promptController.text}
              ]
            }));

    print(response.body);

    setState(() {
      responseText =
          responseModelFromJson(response.body).choices[0].message.content;
      _messages.insert(0, Messages(text: responseText, sender: Sender.bot));
      isTyping = false;
    });

    print(responseText);

    promptController.clear();
  }

  void voiceMessage() async {
    if (text.isEmpty) {
      return;
    }
    Messages message = Messages(text: text, sender: Sender.user);
    setState(() {
      _messages.insert(0, message);
      isTyping = true;
    });

    text = "";
  }

  @override
  void initState() {
    super.initState();
    promptController = TextEditingController();
  }

  @override
  void dispose() {
    promptController.dispose();

    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      bottomNavigationBar: Container(
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
                onTapDown: (details) async {
                  if (!isSpeaking) {
                    var available = await speechToText.initialize();
                    if (available) {
                      setState(() {
                        isSpeaking = true;
                        speechToText.listen(onResult: (result) {
                          setState(() {
                            text = result.recognizedWords;
                          });
                        });
                      });
                    }
                  }
                },
                onTapUp: (details) async {
                  setState(() {
                    isSpeaking = false;
                  });
                  speechToText.stop();
                  voiceMessage();
                  text = "";
                },
                child: Container(
                    height: 5.h,
                    width: 5.h,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
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
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: TextField(
                  style: TextStyle(fontSize: 12.sp),
                  controller: promptController,
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
            GestureDetector(
                onTap: () async {
                  sendMessage();
                },
                child: Container(
                    height: 5.h,
                    width: 5.h,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.send,
                      color: AppColors.white,
                    ))),
          ],
        ),
      ),
      body:
          // SizedBox(
          //     width: double.infinity,
          //     child: Column(
          //       children: [
          //         Expanded(
          //           child: Container(
          //             color: Colors.white,
          //             child: Center(
          //               child: responseText == ""
          //                   ? const CircularProgressIndicator()
          //                   : Text(responseText),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           color: Colors.amber[200],
          //           child: TextFormField(
          //               controller: promptController,
          //               decoration: InputDecoration(
          //                   suffixIcon: IconButton(
          //                       onPressed: () async {
          //                         setState(() {
          //                           responseText = "Loading...";
          //                         });

          //                         print("prompt: ${promptController.text}");

          //                         final response = await http.post(
          //                             Uri.parse(
          //                                 'https://api.openai.com/v1/completions'),
          //                             headers: {
          //                               'Content-Type': 'application/json',
          //                               'Authorization':
          //                                   'Bearer ${dotenv.env['OPENAI_API_KEY']}'
          //                             },
          //                             body: jsonEncode({
          //                               "model": "text-davinci-003",
          //                               "prompt": promptController.text,
          //                               "temperature": 0.7,
          //                               "max_tokens": 256,
          //                               "top_p": 1
          //                             }));

          //                         setState(() {
          //                           responseModel =
          //                               ResponseModel.fromJson(response.body);
          //                           responseText = responseModel.choices[0].text;
          //                         });

          //                         print("responseText: $responseText");
          //                       },
          //                       icon: const Icon(Icons.send)),
          //                   border: const OutlineInputBorder(),
          //                   hintText: "enter a prompt")),
          //         ),
          //       ],
          //     )),

          SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 0.h),
                child: Container(
                  width: 90.w,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(96, 255, 255, 255)),
                      color: Colors.white.withOpacity(.2),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    child: _messages.isEmpty
                        ? SizedBox(
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
                                      size: 12, fontWeight: FontWeight.w100),
                                ),
                                Gap(3.h),
                                Container(
                                  height: 5.h,
                                  width: 50.h,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      color: Colors.transparent,
                                      border:
                                          Border.all(color: AppColors.grey)),
                                  child: Column(children: [
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
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 65.h,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
