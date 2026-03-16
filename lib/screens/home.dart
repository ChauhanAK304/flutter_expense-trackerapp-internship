import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/screens/expense_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:expense_tracker/screens/add_income.dart';
import 'package:expense_tracker/screens/profile.dart';
import 'package:expense_tracker/screens/transactions.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {


   const HomeScreen( {super.key, });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.blue.shade100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Expenses Tracker",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_rounded,
                  size: 35,
                )),
          ],
        ),
      ),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('transection').snapshots(),
        builder: ( context,  snapshot) {
          double totalIncome = 0.0;
          double totalExpense = 0.0;
          double totalBalance = 0.0;

          if (snapshot.hasData) {
            for (var doc in snapshot.data!.docs) {
              var data = doc.data();
              // Amount ko safety ke saath double mein convert karne k liye
              double amount = double.tryParse(data['Amount'].toString()) ?? 0.0;
              if (data['Type'] == 'income') {
                totalIncome += amount;
              }
              else {
                totalExpense += amount;
              }
            }
            totalBalance = totalIncome - totalExpense;
          }
          return Stack(children: [
            SingleChildScrollView(
              child: Container(
                color: Colors.blue.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.amberAccent,
                            radius: 35,
                            backgroundImage: AssetImage(
                                'assets/images/profiler.png'),),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Hi,",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${user!.email}!",
                                      style: const TextStyle(
                                          fontSize: 23,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),

                              const Text(
                                "Welcome Back",
                                style: TextStyle(fontSize: 19,
                                  color: Colors.black87,),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(

                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 90,
                                  width: 180,
                                  child:  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        const Text("Total Expense",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.currency_rupee,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              totalExpense.toStringAsFixed(0),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 90,
                                  width: 180,
                                  child:  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        const Text("Total Income",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.currency_rupee,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              totalIncome.toStringAsFixed(0),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10)),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Balance",
                                  style: TextStyle(
                                    fontSize: 20, color: Colors.white,),
                                ),
                                const SizedBox(width: 10,),
                                const Icon(
                                  Icons.currency_rupee,
                                  color: Colors.white,
                                ),
                                Text(
                                  totalBalance.toStringAsFixed(0),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 180,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    "Quick Action",
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const AddExpenseScreen());
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.red.shade100,
                                          borderRadius: BorderRadius.circular(
                                              10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.red
                                                .shade400,
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Add Expense",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const AddIncomeScreen());
                                    },
                                    child: Container(
                                      height: 120,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          borderRadius: BorderRadius.circular(
                                              10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.green
                                                .shade400,
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Add Income",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  const Text(
                                    "Recent Transaction",
                                    style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get
                                            .to(() => const TransactionsScreen());
                                      },
                                      child: const Text(
                                        "View All >",
                                        style: TextStyle(fontSize: 19),
                                      ))

                                ],
                              ),
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('transection')
                                    .orderBy('createdAt', descending: true)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  // 1. Agar data load ho raha hai
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  // 2. Agar koi error aaya
                                  if (snapshot.hasError) {
                                    return Center(child: Text(
                                        "Error: ${snapshot.error}"));
                                  }

                                  // 3. Agar data mil gaya
                                  if (snapshot.hasData &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    var docs = snapshot.data!
                                        .docs; // Saare documents yahan hain


                                    return ListView.builder(
                                      shrinkWrap: true,
                                      // ScrollView ke andar use karne ke liye
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: docs.length,
                                      itemBuilder: (context, index) {
                                        var data = docs[index].data();
                                        bool isIncome = data['Type'] ==
                                            'income';
                                        return Column(
                                          children: [
                                            InkWell(onTap: () {
                                              Get
                                                  .to(() => const ExpenseDetailsScreen(),
                                                  arguments: {
                                                    'data': data,
                                                    'id': docs[index].id});
                                            },

                                              child: Container(decoration:
                                              BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                  borderRadius:
                                                  BorderRadius.circular(15)),
                                                width: double.maxFinite,
                                                height: 85,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      mainAxisSize: MainAxisSize
                                                          .min,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(left: 10),
                                                          child: CircleAvatar(
                                                            radius: 33,
                                                            backgroundColor: isIncome
                                                                ? Colors.green
                                                                .shade100
                                                                : Colors.red
                                                                .shade100,
                                                            child: Icon(
                                                              isIncome
                                                                  ? Icons
                                                                  .arrow_downward
                                                                  : Icons
                                                                  .arrow_upward,
                                                              color: isIncome
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                              size: 35,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 13,
                                                            top: 5,
                                                            bottom: 5),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text(
                                                              "${data['Title']}",
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 26,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            Text(
                                                              "${data['Date']}",
                                                              style: const TextStyle(
                                                                  fontSize: 20),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(right: 10),
                                                      child: Text("${isIncome
                                                          ? '+'
                                                          : '-'} ₹${data['Amount'] ??
                                                          '0'}"
                                                        , style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: isIncome
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),),
                                                    )

                                                  ],
                                                ),

                                              ),
                                            ), const SizedBox(height: 14,)

                                          ],
                                        );
                                      },
                                    );
                                  }

                                  // 4. Agar data khaali hai (No Documents)
                                  return const Center(
                                      child: Text("No expenses found."));
                                },
                              ),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]
          );

        }),

          bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          IconButton(
          onPressed: () {},
          icon: const Icon(
          Icons.home,
          size: 50,
          )),
          CircleAvatar(
          backgroundColor: Colors.blueAccent,
          radius: 50,
          child: IconButton(
          onPressed: () {
          Get.to(()=> const AddExpenseScreen());
          },
          icon: const Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
          )),
          ),
          IconButton(
          onPressed: () {
          Get.to(()=> const ProfileScreen());

          },
          icon: const Icon(
          Icons.person,
          size: 50,
          ))
          ],
          ),
          ),


    );
  }
}
