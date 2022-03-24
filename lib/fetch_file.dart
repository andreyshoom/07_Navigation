import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

Future<String> fetchFileFromAssets(String assetsPath) async {
  return rootBundle.loadString(assetsPath).then((file) => file);
  // return rootBundle.loadString(assetsPath).then((file) => file);
}

class BandsInfo {
  final String name;
  final String link;
  final String about;

  BandsInfo({
    required this.name,
    required this.link,
    required this.about,
  });

  static BandsInfo fromJson(json) => BandsInfo(
        name: json['name'],
        link: json['link'],
        about: json['about'],
      );
}

Future<List<BandsInfo>> parseJson(BuildContext context) async {
  final jsonString = await fetchFileFromAssets('assets/artists.json');
  final body = json.decode(jsonString);
  return body.map<BandsInfo>(BandsInfo.fromJson).toList();
}
