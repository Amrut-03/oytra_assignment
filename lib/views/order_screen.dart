import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oytra_app/controllers/order_controller.dart';

class OrderScreen extends StatelessWidget {
  final controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oytra Order App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Product", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text('Choose Product'),
                        value: controller.selectedProduct.value,
                        items: controller.products
                            .map((p) => DropdownMenuItem(
                                  value: p,
                                  child: Text("${p.name} (₹${p.price})"),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedProduct.value = value;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text("Customer Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: Text("Retail"),
                        selected: controller.customerType.value == "Retail",
                        onSelected: (_) => controller.customerType.value = "Retail",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ChoiceChip(
                        label: Text("Dealer"),
                        selected: controller.customerType.value == "Dealer",
                        onSelected: (_) => controller.customerType.value = "Dealer",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text("Quantity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter quantity",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (val) {
                    controller.quantity.value = int.tryParse(val) ?? 0;
                  },
                ),
                SizedBox(height: 10),
                if (controller.validateMOQ().isNotEmpty)
                  Text(
                    controller.validateMOQ(),
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 20),
                Card(
                  color: Colors.blue.shade50,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Price", style: TextStyle(fontSize: 16)),
                        Text(
                          "₹${controller.totalPrice.value}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          String error = controller.validateMOQ();
                          if (error.isNotEmpty) {
                            Get.snackbar('Error', error);
                          } else {
                            Get.snackbar('Success', 'Order Placed');
                          }
                        },
                        child: Text("Place Order", style: TextStyle(color: Colors.black),),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => Get.toNamed('/scanner'),
                        child: Text("Scan", style: TextStyle(color: Colors.black),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
