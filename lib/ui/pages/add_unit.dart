// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ql_dvhc/viewmodels/home_viewmodel.dart';

class AddUnit extends StatelessWidget {
  const AddUnit({
    super.key,
    required this.unitType,
    this.isEdit = false,
    this.unit,
  });

  final int unitType;
  final bool isEdit;
  final dynamic unit;

  String _getLevelName() {
    if (unitType == 1) {
      return 'Tỉnh';
    } else if (unitType == 2) {
      return 'Huyện';
    } else {
      return 'Xã';
    }
  }

  @override
  Widget build(BuildContext context) {
    final pCodeTextKey = GlobalKey<FormFieldState>();
    final dCodeTextKey = GlobalKey<FormFieldState>();
    final codeTextKey = GlobalKey<FormFieldState>();
    final nameTextKey = GlobalKey<FormFieldState>();
    final levelTextKey = GlobalKey<FormFieldState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${isEdit ? 'Cập nhật thông tin' : 'Thêm mới'} ${_getLevelName()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (unitType == 2)
              CustomInputText(
                title: 'Mã Tỉnh',
                textKey: pCodeTextKey,
                keyboardType: TextInputType.number,
                initValue: isEdit ? unit.pCode.toString() : null,
              ),
            if (unitType == 3)
              CustomInputText(
                title: 'Mã Huyện',
                textKey: dCodeTextKey,
                keyboardType: TextInputType.number,
                initValue: isEdit ? unit.dCode.toString() : null,
              ),
            // TextFormField(),
            Visibility(
              visible: unitType != 1,
              child: const SizedBox(height: 16),
            ),
            CustomInputText(
              title: 'Mã ${_getLevelName()}',
              textKey: codeTextKey,
              keyboardType: TextInputType.number,
              initValue: isEdit ? unit.code.toString() : null,
            ),
            const SizedBox(height: 16),
            CustomInputText(
              title: 'Tên ${_getLevelName()}',
              textKey: nameTextKey,
              initValue: isEdit ? unit.name : null,
            ),
            const SizedBox(height: 16),
            CustomInputText(
              title: 'Cấp',
              textKey: levelTextKey,
              initValue: isEdit ? unit.level : _getLevelName(),
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final isValidCode =
                          codeTextKey.currentState?.validate() ?? false;
                      final isValidName =
                          nameTextKey.currentState?.validate() ?? false;
                      final isValidLevel =
                          levelTextKey.currentState?.validate() ?? false;

                      bool isValid = isValidCode && isValidName && isValidLevel;
                      if (unitType == 2) {
                        final isValidPCode =
                            pCodeTextKey.currentState?.validate() ?? false;
                        isValid = isValid && isValidPCode;
                      }

                      if (unitType == 3) {
                        final isValidDCode =
                            dCodeTextKey.currentState?.validate() ?? false;
                        isValid = isValid && isValidDCode;
                      }

                      if (isValid == false) {
                        return;
                      }

                      final code = codeTextKey.currentState?.value;
                      final name = nameTextKey.currentState?.value;
                      final level = levelTextKey.currentState?.value;

                      late dynamic value;
                      if (unitType == 1) {
                        value = HomeViewmodel().addProvince(
                          code: int.parse(code),
                          name: name,
                          level: level,
                          id: isEdit ? unit.id : null,
                        );
                      } else if (unitType == 2) {
                        final pCode = pCodeTextKey.currentState?.value;
                        value = HomeViewmodel().addDistrict(
                          pCode: int.parse(pCode),
                          code: int.parse(code),
                          name: name,
                          level: level,
                          id: isEdit ? unit.id : null,
                        );
                      } else {
                        final dCode = dCodeTextKey.currentState?.value;
                        value = HomeViewmodel().addWard(
                          dCode: int.parse(dCode),
                          code: int.parse(code),
                          name: name,
                          level: level,
                          id: isEdit ? unit.id : null,
                        );
                      }

                      Navigator.pop(context, value);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      isEdit ? 'Cập nhật' : 'Thêm',
                      style: const TextStyle(color: Colors.white),
                    ),
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

class CustomInputText extends StatelessWidget {
  const CustomInputText(
      {super.key,
      required this.title,
      required this.textKey,
      this.initValue,
      this.keyboardType});

  final String title;
  final GlobalKey<FormFieldState> textKey;
  final String? initValue;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: textKey,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: title,
      ),
      initialValue: initValue,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập $title';
        }

        return null;
      },
    );
  }
}
