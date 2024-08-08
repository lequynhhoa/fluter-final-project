import 'package:flutter/material.dart';
import 'package:ql_dvhc/models/province_model.dart';
import 'package:ql_dvhc/ui/pages/add_unit.dart';
import 'package:ql_dvhc/ui/pages/province_page.dart';
import 'package:ql_dvhc/viewmodels/home_viewmodel.dart';

// import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Đơn vị hành chính',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            builder: (context) {
              return Container(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddUnit(unitType: 1),
                          ),
                        );
                      },
                      leading: const Icon(Icons.looks_one),
                      title: const Text('Thêm mới tỉnh'),
                      trailing: const Icon(Icons.navigate_next_rounded),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddUnit(unitType: 2),
                          ),
                        );
                      },
                      leading: const Icon(Icons.looks_two),
                      title: const Text('Thêm mới huyện'),
                      trailing: const Icon(Icons.navigate_next_rounded),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddUnit(unitType: 3),
                          ),
                        );
                      },
                      leading: const Icon(Icons.looks_3),
                      title: const Text('Thêm mới xã'),
                      trailing: const Icon(Icons.navigate_next_rounded),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListenableBuilder(
        listenable: HomeViewmodel(),
        builder: (context, child) {
          return ListView.builder(
              itemCount: HomeViewmodel().provinces.length,
              itemBuilder: (context, index) {
                return ProvinceCard(
                  province: HomeViewmodel().provinces[index],
                );
              });
        },
      ),
    );
  }
}

class ProvinceCard extends StatelessWidget {
  const ProvinceCard({super.key, required this.province});
  final ProvinceModel province;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProvincePage(province: province)));
      },
      // leading: const Icon(Icons.looks_one),
      title: Text(province.name),
      subtitle: Text('${province.code} - ${province.level}'),
      trailing: const Icon(Icons.navigate_next_rounded),
    );
  }
}
