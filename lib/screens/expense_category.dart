import 'package:flutter/material.dart';

class ExpenseCategoryScreen extends StatefulWidget {
  const ExpenseCategoryScreen({super.key});

  @override
  State<ExpenseCategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<ExpenseCategoryScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Food', 'icon': Icons.fastfood},
    {'name': 'Travel', 'icon': Icons.airplanemode_active},
    {'name': 'Bill', 'icon': Icons.receipt_long},
    {'name': 'Groceries', 'icon': Icons.local_grocery_store},
    {'name': 'Shopping', 'icon': Icons.shopping_bag},
    {'name': 'Rent', 'icon': Icons.house},
    {'name': 'Education', 'icon': Icons.school},
    {'name': 'Gifts', 'icon': Icons.card_giftcard},
    {'name': 'Loan', 'icon': Icons.currency_rupee},
    {'name': 'Hospital', 'icon': Icons.local_hospital},
    {'name': 'Gym', 'icon': Icons.sports_gymnastics},
    {'name': 'Sports', 'icon': Icons.sports_cricket},
    {'name': 'Petrol', 'icon': Icons.local_gas_station_rounded},
    {'name': 'Water', 'icon': Icons.water_drop_rounded},
    {'name': 'Electricity', 'icon': Icons.lightbulb},
    {'name': 'Other', 'icon': Icons.other_houses},
    {'name': 'Salon', 'icon': Icons.content_cut},
    {'name': 'Cosmetics', 'icon': Icons.face},
    {'name': 'Spa', 'icon': Icons.spa},
    {'name': 'Laundry', 'icon': Icons.local_laundry_service},
    {'name': 'Pharmacy', 'icon': Icons.local_pharmacy},
    {'name': 'Movies', 'icon': Icons.movie},
    {'name': 'Gaming', 'icon': Icons.videogame_asset},
    {'name': 'Music', 'icon': Icons.music_note},
    {'name': 'Books', 'icon': Icons.menu_book},
    {'name': 'Photography', 'icon': Icons.camera_alt},
    {'name': 'Streaming', 'icon': Icons.live_tv},
    {'name': 'Baby Care', 'icon': Icons.child_care},
    {'name': 'Toys', 'icon': Icons.smart_toy},
    {'name': 'School Fee', 'icon': Icons.history_edu},
    {'name': 'Parent Care', 'icon': Icons.elderly},
    {'name': 'Parking', 'icon': Icons.local_parking},
    {'name': 'Service', 'icon': Icons.build},
    {'name': 'Taxi', 'icon': Icons.local_taxi},
    {'name': 'Toll', 'icon': Icons.add_road},
    {'name': 'Insurance', 'icon': Icons.verified_user},
    {'name': 'Snacks', 'icon': Icons.bakery_dining},
    {'name': 'Coffee', 'icon': Icons.coffee},
    {'name': 'Alcohol', 'icon': Icons.liquor},
    {'name': 'Party', 'icon': Icons.celebration},
    {'name': 'Furniture', 'icon': Icons.chair},
    {'name': 'Kitchen', 'icon': Icons.kitchen},
    {'name': 'Garden', 'icon': Icons.park},
    {'name': 'Cleaning', 'icon': Icons.cleaning_services},
    {'name': 'Broadband', 'icon': Icons.wifi},
    {'name': 'Investment', 'icon': Icons.trending_up},
    {'name': 'Tax', 'icon': Icons.assessment},
    {'name': 'Stocks', 'icon': Icons.show_chart},
    {'name': 'EMI', 'icon': Icons.credit_score},
    {'name': 'Savings', 'icon': Icons.savings},
    {'name': 'Office', 'icon': Icons.business_center},
    {'name': 'Freelance', 'icon': Icons.laptop_mac},
    {'name': 'Electronics', 'icon': Icons.devices},
    {'name': 'Footwear', 'icon': Icons.ice_skating},
    {'name': 'Jewelry', 'icon': Icons.diamond},
    {'name': 'Watch', 'icon': Icons.watch},
    {'name': 'Hotel', 'icon': Icons.hotel},
    {'name': 'Flights', 'icon': Icons.flight_takeoff},
    {'name': 'Vacation', 'icon': Icons.beach_access},
    {'name': 'Trekking', 'icon': Icons.terrain},
    {'name': 'Charity', 'icon': Icons.volunteer_activism},
    {'name': 'Subscription', 'icon': Icons.card_membership},
    {'name': 'Repair', 'icon': Icons.handyman},
    {'name': 'Mobile Recharge', 'icon': Icons.phonelink_ring},
    {'name': 'Fastag', 'icon': Icons.directions_bus},
    {'name': 'Postage', 'icon': Icons.local_post_office},
  ];

  List<Map<String, dynamic>> foundExpense = [];

  @override
  void initState() {
    foundExpense = categories;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = categories;
    } else {
      results = categories
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundExpense = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category's")),
      body: Column(
        children: [
          // Search Field Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) => _runFilter(value),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
              decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.grey.shade400,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black54, width: 3),
                      borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 3),
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Search Category",
                  hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
            ),
          ),

          const SizedBox(height: 10),


          Expanded(
            child: foundExpense.isNotEmpty
                ? GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: foundExpense.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, foundExpense[index]['name']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Flexible(
                          flex: 2,
                          child: Icon(
                            foundExpense[index]['icon'],
                            size: 45,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 5),

                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              foundExpense[index]['name'],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSecondaryContainer,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
                : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No result found please try", style: TextStyle(fontSize: 20)),
                  Text("with different search", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}