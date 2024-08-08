import 'package:flutter/material.dart';
import 'package:ql_dvhc/models/district_model.dart';
import 'package:ql_dvhc/models/ward_model.dart';
import 'package:ql_dvhc/ui/pages/add_unit.dart';
import 'package:ql_dvhc/ui/pages/ward_page.dart';

import '../../viewmodels/home_viewmodel.dart';
import 'province_page.dart';

class DistrictPage extends StatefulWidget {
  const DistrictPage({super.key, required this.district});
  final DistrictModel district;

  @override
  State<DistrictPage> createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {
  late DistrictModel district;
  final List<WardModel> wards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    district = widget.district;
  }

  Future<void> getWards() async {
    wards.clear();
    for (var ward in HomeViewmodel().wards) {
      if (ward.dCode == district.code) {
        wards.add(ward);
      }
    }

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getWards();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          district.name,
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
              district = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddUnit(
                    unitType: 2,
                    isEdit: true,
                    unit: district,
                  ),
                ),
              );

              setState(() {});
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              HomeViewmodel().deleteUnit(2, district);
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
            CustomRichText(
                lable: 'Mã Tỉnh', content: district.pCode.toString()),
            const SizedBox(height: 8),
            CustomRichText(
                lable: 'Mã huyện', content: district.code.toString()),
            const SizedBox(height: 8),
            CustomRichText(
                lable: 'Tên huyện', content: district.name.toString()),
            const SizedBox(height: 8),

            CustomRichText(lable: 'Cấp', content: district.level.toString()),
            const SizedBox(height: 8),
            const Text(
              'Danh sách Xã/Phường',
            ),
            const SizedBox(height: 8),
            Visibility(
              visible: isLoading,
              child: const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Visibility(
              visible: isLoading == false && wards.isEmpty,
              child: const Expanded(
                child: Center(
                  child: Text('Chưa có Xã/Phường'),
                ),
              ),
            ),
            Visibility(
              visible: isLoading == false && wards.isNotEmpty,
              child: Expanded(
                child: ListenableBuilder(
                  listenable: HomeViewmodel(),
                  builder: (context, child) {
                    return ListView.builder(
                        itemCount: wards.length,
                        itemBuilder: (context, index) {
                          return WardCard(
                            ward: wards[index],
                          );
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WardCard extends StatelessWidget {
  const WardCard({super.key, required this.ward});
  final WardModel ward;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => WardPage(ward: ward)));
      },
      // leading: const Icon(Icons.looks_one),
      title: Text(ward.name),
      subtitle: Text('${ward.code} - ${ward.level}'),
      trailing: const Icon(Icons.navigate_next_rounded),
    );
  }
}
