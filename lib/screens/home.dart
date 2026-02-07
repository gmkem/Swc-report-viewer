import 'package:flutter/material.dart';
import '../services/api.dart';
import 'detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List reports = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    reports = await ApiService.getReports();
    setState(() => loading = false);
  }

  Color statusColor(String s) {
    if (s == "new") return Colors.redAccent;
    if (s == "progress") return Colors.amber;
    if (s == "done") return Colors.greenAccent;
    return Colors.grey;
  }

  String statusText(String s) {
    if (s == "new") return "ใหม่";
    if (s == "progress") return "กำลังดำเนินการ";
    if (s == "done") return "เสร็จแล้ว";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset("assets/swc.png", height: 40),
            const SizedBox(height: 8),
            const Text("ระบบตรวจสอบรายงาน SWC",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("Student Welfare Committee",
                style: TextStyle(fontSize: 12, color: Colors.white54)),
          ],
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: load,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: reports.length,
                itemBuilder: (context, i) {
                  final r = reports[i];
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(report: r),
                        ),
                      );
                      load();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.white.withOpacity(0.05),
                        border: Border.all(
                          color: statusColor(r["status"]).withOpacity(0.9),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: statusColor(r["status"]).withOpacity(0.25),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r["subject"],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor(r["status"]),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  statusText(r["status"]),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                r["createdAt"]
                                    .toString()
                                    .substring(11, 16),
                                style: const TextStyle(
                                    color: Colors.white54, fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}