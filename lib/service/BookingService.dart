import 'dart:async';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:module_gym/objects/Booking.dart';
import 'dart:convert';

import 'package:module_gym/service/HttpService.dart';

class BookingService extends HttpService {

  Future<void> fetchSecureData() async {
    makeGetRequest('/api/secure-data');
  }

  Future<List<Booking>> fetchBookings() async {
    final response = await authorisedGet('/api/booking');
    final List<dynamic> parsedJson = json.decode(response.body);
    return parsedJson.map((e) => Booking.fromJson(e)).toList();
  }

  Future<Map<String, List<int>>> fetchBookedSections(podId) async {
    final rawData = await makeGetRequest('/api/booking/pod/$podId');

    return rawData.map((key, value) {
      if (value is List) {
        return MapEntry(key, value.map((e) => e as int).toList());
      } else {
        throw Exception('Invalid data for key: $key. Expected List<int>.');
      }
    });
  }

  Future<void> bookSection(podId, DateTime start, startSessionIndex, sessions) async {
    final body = jsonEncode({
      'podId': podId,
      'sessions': sessions,
      'startSessionIndex': startSessionIndex,
      'start': start.toString()
    });
    final resp = await makePostRequest('/api/booking', body);
    final clientSecret = resp['clientSecret'];
    if (clientSecret == null) return;

    await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: 'And Gym'
    ));
    await Stripe.instance.presentPaymentSheet();
  }

  Future<Map<String, dynamic>> makeGetRequest(String url) async {
    final response = await authorisedGet(url);
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> makePostRequest(String url, String? body) async {
    final response = await authorisedPost(url, body);
    return json.decode(response.body);
  }
}