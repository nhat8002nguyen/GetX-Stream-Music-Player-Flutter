import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:music_player_fluttter/common/utils.dart';
import 'package:music_player_fluttter/models/stream.dart';
import 'package:http/http.dart' as http;

class StreamController extends GetxController {
  var streams = <Stream>[].obs;

  @override
  void onInit() async {
    super.onInit();
    var data = await fetchStreams(
        "http://192.168.1.75:9090/videos/search?text=Anh nang cua anh&amount=20");

    final items = <Stream>[];
    for (var item in data["data"]) {
      final String title = item["title"];
      final String channel = item["channel"];
      final stream = Stream(
        id: item["id"],
        title: title.length < 20 ? title : title.substring(0, 20) + "...",
        channel:
            channel.length < 14 ? channel : channel.substring(0, 14) + "...",
        url: item["url"],
        picture: item["thumbnail"]["url"],
        long: iso8601ToTimeFormat(item["duration"]),
      );

      items.add(stream);
    }
    streams.value = items;
  }

  Future<dynamic> fetchStreams(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Parse the response body (e.g., JSON)
        final data = jsonDecode(response.body);
        return data;
      } else {
        // Handle error (e.g., throw an exception)
        throw Exception('Failed to load data from $url');
      }
    } catch (error) {
      // Handle general errors
      throw Exception('Error: $error');
    }
  }
}
