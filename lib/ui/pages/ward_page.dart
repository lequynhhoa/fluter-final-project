import 'package:flutter/material.dart';
import 'package:ql_dvhc/models/ward_model.dart';
import '../../viewmodels/home_viewmodel.dart';
import 'add_unit.dart';
import 'province_page.dart';

class WardPage extends StatefulWidget {
  const WardPage({super.key, required this.ward});
  final WardModel ward;

  @override
  State<WardPage> createState() => _WardPageState();
}

class _WardPageState extends State<WardPage> {
  late WardModel ward;
  @override
  void initState() {
    super.initState();
    ward = widget.ward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          ward.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              ward = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddUnit(
                    unitType: 3,
                    isEdit: true,
                    unit: ward,
                  ),
                ),
              );
              setState(() {});
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              HomeViewmodel().deleteUnit(3, ward);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('data')
            CustomRichText(lable: 'Mã huyện', content: ward.dCode.toString()),
            const SizedBox(height: 8),
            CustomRichText(lable: 'Mã xã', content: ward.code.toString()),
            const SizedBox(height: 8),
            CustomRichText(lable: 'Tên xã', content: ward.name.toString()),
            const SizedBox(height: 8),
            CustomRichText(lable: 'Cấp', content: ward.level.toString()),
          ],
        ),
      ),
    );
  }
}
