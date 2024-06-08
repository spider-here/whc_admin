import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class OrderStatusDropdown extends StatelessWidget {
  final Function(int) onChange;
  final List<String> items;
  final int initialVal;

  const OrderStatusDropdown(this.onChange, this.items, {super.key, this.initialVal = 0});

  @override
  Widget build(BuildContext context) {
    RxInt selected = 0.obs;
    selected.value = initialVal;
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      margin: EdgeInsets.zero,
      elevation: 1.0,
      child: Obx(
        () => DropdownButtonHideUnderline(
            child: SizedBox(
              height: 40.0,
              child: DropdownButton(
                        items: List.generate(
              items.length,
              (index) => DropdownMenuItem(
                value: index,
                child: Text(items[index]),
              ),
                        ),
                        onChanged: (int? value) {
              selected.value = value ?? 0;
              onChange(selected.value);
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                        elevation: 1,
                        focusColor: Colors.transparent,
                        hint: Text(items[selected.value]),
                        isDense: true,
                      ),
            )),
      ),
    );
  }
}
