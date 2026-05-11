import 'package:expense_tracker/provider/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'add_income.dart';


class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataProvider>(context,listen: false);
    var width = MediaQuery.of(context).size.width;
    
    final dynamic args = Get.arguments;
    if (args == null) {
      return const Scaffold(body: Center(child: Text("No Data Found")));
    }

    final Map<String, dynamic> data = Map<String , dynamic>.from(args['data'] ?? {});
    final String docId = args['id']?.toString()??"";
    bool isIncome = data['Type'] == 'income';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Transection Details",
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
                    radius: 70,
                    backgroundColor: isIncome ? Colors.green.shade200 : Colors.red.shade200,
                    child: Icon(
                      isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isIncome ? Colors.green : Colors.red,size: 70,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "${data['category']}",
                      style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width:  double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
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
                                fontSize: 26, fontWeight: FontWeight.w500,color: Colors.black),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Text("${isIncome ? '+' : '-'} ₹${data['Amount'] ?? '0'}"
                              ,style: TextStyle(overflow: TextOverflow.ellipsis,fontSize: 28, fontWeight: FontWeight.bold,
                                color: isIncome ? Colors.green : Colors.red,
                              ),),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Date -",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w400,color: Colors.black),
                          ),
                          Text(
                            "${data['Date']}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500,color: Colors.black),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        const Text(
                        "Note ",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500,color: Colors.black),
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
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width*1.0,
                child: Row(

                  children: [
                    Expanded(
                      child: SizedBox(
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
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          // Delete Button ke lie
                          onPressed: () {

                              provider.deleteDataFromFirebase(docId);
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
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
