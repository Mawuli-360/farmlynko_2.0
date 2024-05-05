// To parse this JSON data, do
//
//     final dailyForecast = dailyForecastFromJson(jsonString);

import 'dart:convert';


DailyForecast dailyForecastFromJson(String str) => DailyForecast.fromJson(json.decode(str));

String dailyForecastToJson(DailyForecast data) => json.encode(data.toJson());

class DailyForecast {
    final The20231122Class the20231122;
    final The20231122Class the20231123;
    final The20231122Class the20231124;
    final The20231125Class the20231125;
    final The20231125Class the20231126;
    final The20231125Class the20231127;

    DailyForecast({
        required this.the20231122,
        required this.the20231123,
        required this.the20231124,
        required this.the20231125,
        required this.the20231126,
        required this.the20231127,
    });

    DailyForecast copyWith({
        The20231122Class? the20231122,
        The20231122Class? the20231123,
        The20231122Class? the20231124,
        The20231125Class? the20231125,
        The20231125Class? the20231126,
        The20231125Class? the20231127,
    }) => 
        DailyForecast(
            the20231122: the20231122 ?? this.the20231122,
            the20231123: the20231123 ?? this.the20231123,
            the20231124: the20231124 ?? this.the20231124,
            the20231125: the20231125 ?? this.the20231125,
            the20231126: the20231126 ?? this.the20231126,
            the20231127: the20231127 ?? this.the20231127,
        );

    factory DailyForecast.fromJson(Map<String, dynamic> json) => DailyForecast(
        the20231122: The20231122Class.fromJson(json["2023-11-22"]),
        the20231123: The20231122Class.fromJson(json["2023-11-23"]),
        the20231124: The20231122Class.fromJson(json["2023-11-24"]),
        the20231125: The20231125Class.fromJson(json["2023-11-25"]),
        the20231126: The20231125Class.fromJson(json["2023-11-26"]),
        the20231127: The20231125Class.fromJson(json["2023-11-27"]),
    );

    Map<String, dynamic> toJson() => {
        "2023-11-22": the20231122.toJson(),
        "2023-11-23": the20231123.toJson(),
        "2023-11-24": the20231124.toJson(),
        "2023-11-25": the20231125.toJson(),
        "2023-11-26": the20231126.toJson(),
        "2023-11-27": the20231127.toJson(),
    };
}

class The20231122Class {
    final Map<String, double> daily;
    final List<Hourly> hourly;

    The20231122Class({
        required this.daily,
        required this.hourly,
    });

    The20231122Class copyWith({
        Map<String, double>? daily,
        List<Hourly>? hourly,
    }) => 
        The20231122Class(
            daily: daily ?? this.daily,
            hourly: hourly ?? this.hourly,
        );

    factory The20231122Class.fromJson(Map<String, dynamic> json) => The20231122Class(
        daily: Map.from(json["daily"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
        hourly: List<Hourly>.from(json["hourly"].map((x) => Hourly.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "daily": Map.from(daily).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "hourly": List<dynamic>.from(hourly.map((x) => x.toJson())),
    };
}

class Hourly {
    final double dewpoint;
    final double flike;
    final double rainfall;
    final int rainprob;
    final double relhum;
    final double temp;
    final DateTime ts;
    final int wdir;
    final double wgust;
    final double wspeed;

    Hourly({
        required this.dewpoint,
        required this.flike,
        required this.rainfall,
        required this.rainprob,
        required this.relhum,
        required this.temp,
        required this.ts,
        required this.wdir,
        required this.wgust,
        required this.wspeed,
    });

    Hourly copyWith({
        double? dewpoint,
        double? flike,
        double? rainfall,
        int? rainprob,
        double? relhum,
        double? temp,
        DateTime? ts,
        int? wdir,
        double? wgust,
        double? wspeed,
    }) => 
        Hourly(
            dewpoint: dewpoint ?? this.dewpoint,
            flike: flike ?? this.flike,
            rainfall: rainfall ?? this.rainfall,
            rainprob: rainprob ?? this.rainprob,
            relhum: relhum ?? this.relhum,
            temp: temp ?? this.temp,
            ts: ts ?? this.ts,
            wdir: wdir ?? this.wdir,
            wgust: wgust ?? this.wgust,
            wspeed: wspeed ?? this.wspeed,
        );

    factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dewpoint: json["dewpoint"]?.toDouble(),
        flike: json["flike"]?.toDouble(),
        rainfall: json["rainfall"]?.toDouble(),
        rainprob: json["rainprob"],
        relhum: json["relhum"]?.toDouble(),
        temp: json["temp"]?.toDouble(),
        ts: DateTime.parse(json["ts"]),
        wdir: json["wdir"],
        wgust: json["wgust"]?.toDouble(),
        wspeed: json["wspeed"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dewpoint": dewpoint,
        "flike": flike,
        "rainfall": rainfall,
        "rainprob": rainprob,
        "relhum": relhum,
        "temp": temp,
        "ts": ts.toIso8601String(),
        "wdir": wdir,
        "wgust": wgust,
        "wspeed": wspeed,
    };
}

class The20231125Class {
    final Map<String, double> daily;

    The20231125Class({
        required this.daily,
    });

    The20231125Class copyWith({
        Map<String, double>? daily,
    }) => 
        The20231125Class(
            daily: daily ?? this.daily,
        );

    factory The20231125Class.fromJson(Map<String, dynamic> json) => The20231125Class(
        daily: Map.from(json["daily"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "daily": Map.from(daily).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}


