import 'dart:convert';

import 'package:module_gym/objects/GymPod.dart';
import 'package:module_gym/service/HttpService.dart';

class GymPodService extends HttpService {

  Future<List<GymPod>> fetchAllPods() async {
    final response = await authorisedGet('/api/gym-pod');

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> podsJson = body['pods']; // Explicit cast
      final List<GymPod> pods = podsJson.map((j) => GymPod.fromJson(j)).toList();
      return pods;
    } else {
      throw Exception('Failed to load gym pods');
    }
  }
}
