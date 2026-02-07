import 'dart:convert';
import 'package:http/http.dart' as http;

const String BASE_URL = "https://plain-sky-f718.gagtgvgqgg.workers.dev"; // 🔴 เปลี่ยนเป็น URL จริง

class ApiService {
  static Future<List<dynamic>> getReports() async {
    final res = await http.get(Uri.parse("$BASE_URL/reports"));
    return jsonDecode(res.body);
  }

  static Future<void> updateStatus(String id, String status) async {
    await http.patch(
      Uri.parse("$BASE_URL/reports/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"status": status}),
    );
  }
}