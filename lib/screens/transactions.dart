import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'transaction_details.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String selectedFilter = 'All';
  String getFormattedDate (DateTime entryDate){
    final now = DateTime.now();
    final today = DateTime(now.year,now.month,now.day,);
    final yesterday = DateTime(now.year,now.month,now.day-1,);
    final entry = DateTime(entryDate.year,entryDate.month,entryDate.day);

    if(entry == today){
      return "Today";
    } else if(entry == yesterday){
      return "Yesterday";
    }else {return "Past Transection";}

  }
  
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
        appBar: AppBar(
            title: const Text("Transactions",
          style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),) ),
        body:
        Padding(
          padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [


                const SizedBox(height: 5,),
                Center(child: SizedBox(
                  width: double.maxFinite,
                  height: 52,
                  child: SegmentedButton(multiSelectionEnabled: false,
                      segments: const [
                        ButtonSegment(value: 'All',label: Text("All",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.black,))),
                        ButtonSegment(value: 'expense',label: Text("Expense",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black))),
                        ButtonSegment(value: 'income',label: Text("Income",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.black)))],
                      selected: {selectedFilter},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        selectedFilter = newSelection.first;
                      });
                    },
                  style: SegmentedButton.styleFrom(backgroundColor: Colors.white70,selectedBackgroundColor: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),),
                ),),

                const SizedBox(height: 10,),
            
                Container(padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [



                      const SizedBox(height: 5,),

                      StreamBuilder(
                        stream: selectedFilter == 'All' ?
                        FirebaseFirestore.instance.collection('users').doc(userId)
                            .collection('transaction')
                            .orderBy('createdAt', descending: true)
                            .snapshots()
                        :FirebaseFirestore.instance.collection('users').doc(userId).collection('transaction').where('Type',isEqualTo: selectedFilter).orderBy('createdAt',descending: true,).snapshots(),
                        builder: (context, snapshot) {
                          // 1. Agar data load ho raha hai
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator(color: Colors.red,));
                          }

                          // 2. Agar koi error aaya
                          if (snapshot.hasError) {
                            return Center(child: Text("Error: ${snapshot.error}"));
                          }

                          // 3. Agar data mil gaya
                          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                            var docs = snapshot.data!.docs;  // Saare documents yahan hain


                            return ListView.builder(
                              shrinkWrap: true, // ScrollView ke andar use karne ke lie
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                var data = docs[index].data();
                                bool isIncome = data['Type'] == 'income';
                                DateTime entryDate = data['createdAt'] != null
                                    ? (data['createdAt'] as Timestamp).toDate()
                                    : DateTime.now();
                                return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(getFormattedDate(entryDate),style:
                                    TextStyle(fontSize: 25,fontWeight: FontWeight.w500,
                                        color: Theme.of(context).colorScheme.onSecondaryContainer),),
                                    const SizedBox(height: 5,),


                                    InkWell(onTap: (){
                                      debugPrint(docs[index].id);
                                      Get.to(()=> const ExpenseDetailsScreen(),
                                          arguments: {
                                            'data': data,
                                            'id': docs[index].id});
                                    },

                                      child: Container(decoration:
                                      BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius:
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
                                                    radius: 33,
                                                    backgroundColor: isIncome ? Colors.green.shade200 : Colors.red.shade200,
                                                    child: Icon(
                                                      isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                                                      color: isIncome ? Colors.black : Colors.black,size: 35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,  top: 8, ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("${data['category']}",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                          FontWeight.bold,),
                                                    ),
                                                    Text(
                                                      "${data['Date']}",
                                                      style: const TextStyle(fontSize: 20,),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Expanded(
                                              child: Text("${isIncome ? '+' : '-'} ₹${data['Amount'] ?? '0'}"
                                                ,style: TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 25, fontWeight: FontWeight.bold,
                                                  color: isIncome ? Colors.green : Colors.red,
                                                ),),
                                            )

                                          ],
                                        ),

                                      ),
                                    ),const SizedBox(height: 14,)

                                  ],
                                );
                              },
                            );
                          }

                          // 4. Agar data khali hai (No Documents)
                          return const Center(child:  Column(
                            children: [
                              Divider(thickness: 1,color: Colors.black54,),
                              Text("No Data Found.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Divider(thickness: 1,color: Colors.black54,),
                            ],
                          ));
                        },
                      ),






                      ],
                  ),
                ),
            
            
              ],
            ),
          ),
        ));
  }
}
