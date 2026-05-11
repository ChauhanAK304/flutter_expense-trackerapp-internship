import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  Map<String, double> groupedData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    // Firestore se data lana
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).collection('transaction').get();

    Map<String, double> tempMap = {};
    for (var item in snapshot.docs) {
      String cat = item['category'];
      // Amount ko double mein convert karna
      double amt = double.parse(item['Amount'].toString());

      if (tempMap.containsKey(cat)) {
        tempMap[cat] = tempMap[cat]! + amt;
      } else {
        tempMap[cat] = amt;
      }
    }

    setState(() {
      groupedData = tempMap;
    });
  }

  // Categories ke lie alg-alg colors assign Carne ka function
  Color getCategoryColor(String cat) {

    switch (cat) {
      case 'Food': return Colors.green;
      case 'Travel': return Colors.blue;
      case 'Bill': return Colors.yellow.shade700;
      case 'Groceries': return Colors.lightGreen;
      case 'Shopping': return Colors.orange;
      case 'Rent': return Colors.red;
      case 'Hospital': return Colors.cyan;
      case 'Gym': return Colors.blueGrey;
      case 'Petrol': return Colors.amber;
      case 'Investment': return Colors.teal;
      case 'EMI': return Colors.redAccent;
      case 'Savings': return Colors.indigo;
      case 'Movies': return Colors.deepPurple;
      case 'Gaming': return Colors.pinkAccent;
    }


    return Colors.primaries[cat.length % Colors.primaries.length].withOpacity(0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Spending Analytics')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Container(
              height: 50,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: Text(
                  'Category Distribution',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [

                 const SizedBox(height: 10),
                const Divider(color: Colors.black, thickness: 1.5),
                SizedBox(
                   height: 360,
                   width: 340,
                  // Agar data empty hai toh loader dikhane k lie
                  child: groupedData.isEmpty
                      ? const Center(child: Column(
                        children: [
                          Text("No Data Found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                          Divider(color: Colors.black, thickness: 1.5),
                        ],
                      ))
                      : PieChart(
                    PieChartData(
                      sections: groupedData.entries.map((entry) {
                        return PieChartSectionData(
                          title: '${entry.key}\n₹${entry.value.toInt()}',
                          value: entry.value,
                          color: getCategoryColor(entry.key),
                          radius: 90,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const Divider(color: Colors.black, thickness: 1.5),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
