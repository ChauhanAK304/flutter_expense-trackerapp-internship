import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'expense_details.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedFilter = 'All';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
        appBar: AppBar(
            backgroundColor: Colors.blue.shade50,
            title: const Text("Transactions",
          style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),) ),
        body:
        Padding(
          padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [

                const Divider(thickness: 1,color: Colors.black54,),
                const SizedBox(height: 5,),
                Center(child: SizedBox(width: double.maxFinite,
                  child: SegmentedButton(multiSelectionEnabled: false,
                      segments: const [
                        ButtonSegment(value: 'All',label: Text("All",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black))),
                        ButtonSegment(value: 'expenses',label: Text("Expense",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.black))),
                        ButtonSegment(value: 'income',label: Text("Income",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)))],
                      selected: {selectedFilter},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        selectedFilter = newSelection.first;
                      });
                    },
                  style: SegmentedButton.styleFrom(backgroundColor: Colors.white,selectedBackgroundColor: Colors.blue,selectedForegroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),),
                ),),

                const SizedBox(height: 5,),
            
                 const Divider(thickness: 1,color: Colors.black87,),
                const SizedBox(height: 5,),
            
                Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [const Text("Today",style:
                  TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),),
                     const SizedBox(height: 5,),
                
                     const Divider(thickness: 1,color: Colors.black87,),
                    const SizedBox(height: 5,),

                    StreamBuilder(
                      stream: selectedFilter == 'All' ?
                      FirebaseFirestore.instance
                          .collection('transection')
                          .orderBy('createdAt', descending: true)
                          .snapshots()
                      :FirebaseFirestore.instance.collection('transection').where('Type',isEqualTo: selectedFilter).orderBy('createdAt',descending: true,).snapshots(),
                      builder: (context, snapshot) {
                        // 1. Agar data load ho raha hai
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // 2. Agar koi error aaya
                        if (snapshot.hasError) {
                          return Center(child: Text("Error: ${snapshot.error}"));
                        }

                        // 3. Agar data mil gaya
                        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                          var docs = snapshot.data!.docs;  // Saare documents yahan hain


                          return ListView.builder(
                            shrinkWrap: true, // ScrollView ke andar use karne ke liye
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              var data = docs[index].data();
                              bool isIncome = data['Type'] == 'income';
                              return Column(
                                children: [
                                  InkWell(onTap: (){
                                    Get.to(()=> const ExpenseDetailsScreen(),
                                        arguments: {
                                          'data': data,
                                          'id': docs[index].id});
                                  },

                                    child: Container(decoration:
                                    BoxDecoration(color: Colors.white,borderRadius:
                                    BorderRadius.circular(15)),
                                      width: double.maxFinite,
                                      height: 85,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Column(mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor: isIncome ? Colors.green.shade100 : Colors.red.shade100,
                                                  child: Icon(
                                                    isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                                                    color: isIncome ? Colors.green : Colors.red,size: 35,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 13,  top: 5, bottom: 5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${data['Title']}",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 26,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "${data['Date']}",
                                                    style: const TextStyle(fontSize: 20),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(right: 10),
                                            child: Text("${isIncome ? '+' : '-'} ₹${data['Amount'] ?? '0'}"
                                              ,style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                                                color: isIncome ? Colors.green : Colors.red,
                                              ),),
                                          )

                                        ],
                                      ),

                                    ),
                                  ),const SizedBox(height: 14,)
                                  // const Divider(
                                  //   height: 15,
                                  //   thickness: 2.5,
                                  //   color: Colors.black26,
                                  // ),
                                ],
                              );
                            },
                          );
                        }

                        // 4. Agar data khali hai (No Documents)
                        return const Center(child: Text("No expenses found."));
                      },
                    ),
                    const Divider(thickness: 1,color: Colors.black54,),


                

                
                    ],
                ),
            
            
              ],
            ),
          ),
        ));
  }
}
