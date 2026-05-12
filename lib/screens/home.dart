import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/provider/profile_provider.dart';
import 'package:expense_tracker/screens/custom_drawer_screen.dart';
import 'package:expense_tracker/screens/transaction_details.dart';
import 'package:expense_tracker/utils/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:expense_tracker/screens/add_income.dart';
import 'package:expense_tracker/screens/transactions.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final provider2 = Provider.of<ProfileImage>(context,listen: false);

    ThemeController themeController = Get.put(ThemeController());

    final user = FirebaseAuth.instance.currentUser;
    String userName = user?.displayName ?? user?.email?.split('@')[0] ?? "User";
     String userId = FirebaseAuth.instance.currentUser!.uid;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const CustomDrawerScreen(),
      appBar: AppBar(

        centerTitle: false,
        title: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              "Expenses Tracker",
              style: TextStyle(
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold),
            ),

            IconButton(
                onPressed: () {
                  themeController.toggleTheme();
                },
                icon: Obx(
                        () => themeController.isDarkMode.value
                            ?const Icon(Icons.dark_mode,color: Colors.orange,)
                            :const Icon(Icons.light_mode,)
                )
              )
          ],
        ),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('users').doc(userId).collection('transaction').snapshots(),
          builder: (context, snapshot) {
            double totalIncome = 0.0;
            double totalExpense = 0.0;
            double totalBalance = 0.0;

            if (snapshot.hasData) {
              for (var doc in snapshot.data!.docs) {
                var data = doc.data();
                // Amount ko safety ke saath double mein convert karne k liye
                double amount =
                    double.tryParse(data['Amount'].toString()) ?? 0.0;
                if (data['Type'] == 'income') {
                  totalIncome += amount;
                } else {
                  totalExpense += amount;
                }
              }
              totalBalance = totalIncome - totalExpense;
            }
            return Stack(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Consumer<ProfileImage>(
                            builder: (context, provider, child) {
                              return CircleAvatar(
                                radius: 40,
                                backgroundImage: provider.webImage != null
                                    ? MemoryImage(provider.webImage!)
                                    : const AssetImage('assets/images/profiler.png') as ImageProvider,
                              );
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi,$userName!",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width * 1.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("Total Expense",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22)),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.currency_rupee,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: Text(
                                              totalExpense.toStringAsFixed(0),
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("Total Income",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22)),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.currency_rupee,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                            child: Text(
                                              totalIncome.toStringAsFixed(0),
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
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
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                               color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               const Text(
                                "Balance-",
                                style: TextStyle(
                                  fontSize: 24,

                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.currency_rupee,
                              ),
                              Expanded(
                                child: Text(
                                  totalBalance.toStringAsFixed(0),
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                      color: Colors.red,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: width * 1.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                              Expanded(child: InkWell(
                                onTap: () {
                                  Get.to(() => const AddExpenseScreen());
                                },
                                child: Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade200,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                        Colors.red.shade400,
                                        child:  const Icon(
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
                                        style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(child: InkWell(
                                  onTap: () {
                                    Get.to(() => const AddIncomeScreen());
                                  },
                                  child: Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade200,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor:
                                          Colors.green.shade400,
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
                                          style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  )))
                                                                ],
                                                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: width*1.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                   const Text(
                                    "Recent Transaction",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(
                                            () => const TransactionsScreen());
                                      },
                                      child: const Text(
                                        "View All >",
                                        style: TextStyle(
                                            fontSize: 20,color: Colors.blue),
                                      ))
                                ],
                              ),const SizedBox(height: 5,),

                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection("users").doc(userId)
                                    .collection('transaction')
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
                                    return Center(
                                        child:
                                            Text("Error: ${snapshot.error}"));
                                  }

                                  // 3. Agar data mil gaya
                                  if (snapshot.hasData &&
                                      snapshot.data!.docs.isNotEmpty) {
                                    var docs = snapshot.data!
                                        .docs; // Saare documents yahan hain

                                    return ListView.builder(
                                      shrinkWrap: true,
                                      // ScrollView ke andar use karne ke liye
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: docs.length,
                                      itemBuilder: (context, index) {
                                        var data = docs[index].data();
                                        bool isIncome =
                                            data['Type'] == 'income';
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    () =>
                                                        const ExpenseDetailsScreen(),
                                                    arguments: {
                                                      'data': data,
                                                      'id': docs[index].id
                                                    });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        Theme.of(context).colorScheme.surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                width: double.maxFinite,
                                                height: 85,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 6),
                                                          child: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor: isIncome
                                                                ? Colors.green
                                                                    .shade200
                                                                : Colors.red
                                                                    .shade200,
                                                            child: Icon(
                                                              isIncome
                                                                  ? Icons
                                                                      .arrow_downward
                                                                  : Icons
                                                                      .arrow_upward,
                                                              color: isIncome
                                                                  ? Colors
                                                                      .black
                                                                  : Colors
                                                                      .black,
                                                              size: 35,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                              top: 8
                                                                ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${data['category']}",
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  // color: Colors.black,
                                                                  fontSize:
                                                                      25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              "${data['Date']}",
                                                              style:
                                                                  const TextStyle(
                                                                    // color: Colors.black,
                                                                      fontSize:
                                                                          20),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${isIncome ? '+' : '-'} ₹${data['Amount'] ?? '0'}",
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: isIncome
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }

                                  // 4. Agar data khaali hai (No Documents)
                                  return const Center(
                                      child:

                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          children: [ Divider(thickness: 1,),
                                            Text("No Data Found.",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                            Divider(thickness: 1,),
                                          ],
                                        ),
                                      ));
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
            ]);
          }),
    );
  }
}
