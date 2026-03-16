import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:get/get.dart';

import 'add_income.dart';


class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;
    if (args == null) {
      return const Scaffold(body: Center(child: Text("No Data Found")));
    }

    final Map<String, dynamic> data = args['data'];
    final String docId = args['id'];
    bool isIncome = data['Type'] == 'income';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Expense Details",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
               Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: isIncome ? Colors.green.shade100 : Colors.red.shade100,
                    child: Icon(
                      isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isIncome ? Colors.green : Colors.red,size: 50,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${data['Title']}",
                    style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width:  double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12)),
                child:  Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Amount -",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w400),
                          ),
                          Text("${isIncome ? '+' : '-'} ₹${data['Amount'] ?? '0'}"
                            ,style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400,
                              color: isIncome ? Colors.green : Colors.red,
                            ),)
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Date -",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${data['Date']}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 2,
                      ),Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        const Text(
                        "Note ",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),


                        Text(maxLines: 50,
                          "${data['Note']}",
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),

                      ],),


                      const Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {

                          bool isIncome = data['Type'] == 'income';

                          if (isIncome) {

                            Get.to(() => const AddIncomeScreen(), arguments: {
                              'isEditing': true,
                              'docId': docId,
                              'oldData': data,
                            });
                          } else {

                            Get.to(() => const AddExpenseScreen(), arguments: {
                              'isEditing': true,
                              'docId': docId,
                              'oldData': data,
                            });
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      // Delete Button ke liye
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Delete Expense?",
                          middleText: "Do you really want to remove it?",
                          textConfirm: "Yes",
                          confirmTextColor: Colors.white,
                          onConfirm: () async {
                            // Home screen se bheji gayi ID ka use karke delete karne k liye


                            await FirebaseFirestore.instance
                                .collection('transection')
                                .doc(docId)
                                .delete();

                            Get.back(); // Dialog band karne ke liye
                            Get.back(); // Home screen par wapas jaane ke liye

                            Get.snackbar("Success", "Expense delete ",
                                snackPosition: SnackPosition.BOTTOM);

                          },
                          textCancel: "No",
                        );
                      },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
