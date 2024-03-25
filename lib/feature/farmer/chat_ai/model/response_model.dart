
import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choice> choices;
  final Usage usage;

  ResponseModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  ResponseModel copyWith({
    String? id,
    String? object,
    int? created,
    String? model,
    List<Choice>? choices,
    Usage? usage,
  }) =>
      ResponseModel(
        id: id ?? this.id,
        object: object ?? this.object,
        created: created ?? this.created,
        model: model ?? this.model,
        choices: choices ?? this.choices,
        usage: usage ?? this.usage,
      );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        usage: Usage.fromJson(json["usage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "usage": usage.toJson(),
      };
}

class Choice {
  final int index;
  final Message message;
  final String finishReason;

  Choice({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  Choice copyWith({
    int? index,
    Message? message,
    String? finishReason,
  }) =>
      Choice(
        index: index ?? this.index,
        message: message ?? this.message,
        finishReason: finishReason ?? this.finishReason,
      );

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        index: json["index"],
        message: Message.fromJson(json["message"]),
        finishReason: json["finish_reason"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "message": message.toJson(),
        "finish_reason": finishReason,
      };
}

class Message {
  final String role;
  final String content;

  Message({
    required this.role,
    required this.content,
  });

  Message copyWith({
    String? role,
    String? content,
  }) =>
      Message(
        role: role ?? this.role,
        content: content ?? this.content,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  Usage copyWith({
    int? promptTokens,
    int? completionTokens,
    int? totalTokens,
  }) =>
      Usage(
        promptTokens: promptTokens ?? this.promptTokens,
        completionTokens: completionTokens ?? this.completionTokens,
        totalTokens: totalTokens ?? this.totalTokens,
      );

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
      );

  Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}
