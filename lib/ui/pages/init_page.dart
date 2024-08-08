import 'package:flutter/material.dart';
import 'package:ql_dvhc/ui/pages/home_page.dart';
import 'package:ql_dvhc/viewmodels/home_viewmodel.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();

    // Lấy hết dữ liệu cho home
    initApp();
  }

  Future<void> initApp() async {
    await HomeViewmodel().getUnits();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
