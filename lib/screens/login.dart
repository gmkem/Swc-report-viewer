class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ctrl = TextEditingController();
  bool loading = false;

  Future<void> login() async {
    setState(() => loading = true);
    final res = await http.post(
      Uri.parse("https://plain-sky-f718.gagtgvgqgg.workers.dev"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"secret": ctrl.text}),
    );
    final ok = jsonDecode(res.body)["success"];
    setState(() => loading = false);

    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("รหัสไม่ถูกต้อง")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("เข้าสู่ระบบสภา",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            TextField(
              controller: ctrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "รหัสสภา"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : login,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("เข้าสู่ระบบ"),
            ),
          ],
        ),
      ),
    );
  }
}