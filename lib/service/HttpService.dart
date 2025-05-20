import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class HttpService {

    final domain = "https://and-gym-7nkye.ondigitalocean.app";

    Future<http.Response> authorisedGet(url) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) throw Exception('Not logged in');

        final idToken = await user.getIdToken();

        final response = await http.get(
            Uri.parse(domain + url),
            headers: { 'Authorization': 'Bearer $idToken' },
        );

        if (response.statusCode == 400) {
            final data = json.decode(response.body);
            throw Exception(data['message']);
        }

        if (response.statusCode == 500) {
            throw Exception('Unexpected Exception');
        }

        return response;
    }

    Future<http.Response> authorisedPost(url, body) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) throw Exception('Not logged in');

        final idToken = await user.getIdToken();

        final response = await http.post(
            Uri.parse(domain + url),
            headers: {
                'Authorization': 'Bearer $idToken',
                'Content-Type': 'application/json',
            },
            body: body
        );

        if (response.statusCode == 400) {
            final data = json.decode(response.body);
            throw Exception(data['message']);
        }

        if (response.statusCode == 500) {
            throw Exception('Unexpected Exception');
        }

        return response;
    }
}
