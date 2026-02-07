import 'package:flutter/material.dart';
import '../services/api.dart';

class DetailScreen extends StatelessWidget {
  final Map report;
  const DetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("รายละเอียดรายงาน"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report["subject"],
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              report["detail"],
              style:
                  const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Text(
              "ผู้แจ้ง: ${report["name"]}",
              style:
                  const TextStyle(fontSize: 14, color: Colors.white54),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber),
                    onPressed: () async {
                      await ApiService.updateStatus(
                          report["id"], "progress");
                      Navigator.pop(context);
                    },
                    child: const Text("กำลังดำเนินการ"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green),
                    onPressed: () async {
                      await ApiService.updateStatus(
                          report["id"], "done");
                      Navigator.pop(context);
                    },
                    child: const Text("เสร็จแล้ว"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}