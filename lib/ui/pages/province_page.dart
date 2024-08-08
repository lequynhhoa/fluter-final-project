import 'package:flutter/material.dart';
import 'package:ql_dvhc/models/district_model.dart';
import 'package:ql_dvhc/models/province_model.dart';
import 'package:ql_dvhc/ui/pages/add_unit.dart';
import 'package:ql_dvhc/viewmodels/home_viewmodel.dart';

import 'district_page.dart';

class ProvincePage extends StatefulWidget {
  const ProvincePage({super.key, required this.province});
  final ProvinceModel province;

  @override
  State<ProvincePage> createState() => _ProvincePageState();
}

class _ProvincePageState extends State<ProvincePage> {
  late ProvinceModel province;
  final List<DistrictModel> districts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    province = widget.province;
  }

  Future<void> getDistricts() async {
    districts.clear();
    for (var district in HomeViewmodel().districts) {
      if (district.pCode == province.code) {
        districts.add(district);
      }
    }

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getDistricts();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          province.name,
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
              province = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddUnit(
                    unitType: 1,
                    isEdit: true,
                    unit: province,
                  ),
                ),
              );

              setState(() {});
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              HomeViewmodel().deleteUnit(1, province);
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
            CustomRichText(lable: 'Mã tỉnh', content: province.code.toString()),
            const SizedBox(height: 8),
            CustomRichText(
                lable: 'Tên tỉnh', content: province.name.toString()),
            const SizedBox(height: 8),

            CustomRichText(lable: 'Cấp', content: province.level.toString()),
            const SizedBox(height: 8),
            const Text(
              'Danh sách Quận/Huyện',
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
              visible: isLoading == false && districts.isEmpty,
              child: const Expanded(
                child: Center(
                  child: Text('Chưa có Quận/Huyện'),
                ),
              ),
            ),
            Visibility(
              visible: isLoading == false && districts.isNotEmpty,
              child: Expanded(
                child: ListenableBuilder(
                  listenable: HomeViewmodel(),
                  builder: (context, child) {
                    return ListView.builder(
                        itemCount: districts.length,
                        itemBuilder: (context, index) {
                          return DistrictCard(
                            district: districts[index],
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

class CustomRichText extends StatelessWidget {
  const CustomRichText({super.key, required this.lable, required this.content});
  final String lable;
  final String content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '$lable: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              // fontSize: 16,
            ),
          ),
          TextSpan(
            text: content,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              // fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class DistrictCard extends StatelessWidget {
  const DistrictCard({super.key, required this.district});
  final DistrictModel district;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => DistrictPage(district: district)));
      },
      // leading: const Icon(Icons.looks_one),
      title: Text(district.name),
      subtitle: Text('${district.code} - ${district.level}'),
      trailing: const Icon(Icons.navigate_next_rounded),
    );
  }
}
