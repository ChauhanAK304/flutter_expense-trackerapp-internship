import 'package:flutter/material.dart';

class IncomeCategoryScreen extends StatefulWidget {
  const IncomeCategoryScreen({super.key});

  @override
  State<IncomeCategoryScreen> createState() => _IncomeCategoryScreenState();
}

class _IncomeCategoryScreenState extends State<IncomeCategoryScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Salary', 'icon': Icons.payments},
    {'name': 'Business Profit', 'icon': Icons.store},
    {'name': 'Freelance', 'icon': Icons.laptop_mac},
    {'name': 'Bonus', 'icon': Icons.card_giftcard},
    {'name': 'Overtime', 'icon': Icons.more_time},
    {'name': 'Commission', 'icon': Icons.percent},
    {'name': 'Consultation', 'icon': Icons.support_agent},
    {'name': 'Dividends', 'icon': Icons.pie_chart},
    {'name': 'Stock Profit', 'icon': Icons.show_chart},
    {'name': 'Interest Info', 'icon': Icons.account_balance},
    {'name': 'Rental Income', 'icon': Icons.real_estate_agent},
    {'name': 'Crypto Profit', 'icon': Icons.currency_bitcoin},
    {'name': 'Mutual Funds', 'icon': Icons.analytics},
    {'name': 'Fixed Deposit', 'icon': Icons.lock_clock},
    {'name': 'Cashback', 'icon': Icons.redeem},
    {'name': 'Gift Money', 'icon': Icons.celebration},
    {'name': 'Lottery', 'icon': Icons.confirmation_number},
    {'name': 'Coupon', 'icon': Icons.local_offer},
    {'name': 'Reward Points', 'icon': Icons.stars},
    {'name': 'Tax Refund', 'icon': Icons.assignment_returned},
    {'name': 'Loan Repaid', 'icon': Icons.keyboard_return},
    {'name': 'Product Return', 'icon': Icons.settings_backup_restore},
    {'name': 'Insurance Claim', 'icon': Icons.health_and_safety},
    {'name': 'Selling Items', 'icon': Icons.sell},
    {'name': 'Affiliate', 'icon': Icons.campaign},
    {'name': 'Youtube/Ads', 'icon': Icons.play_circle_fill},
    {'name': 'Referral', 'icon': Icons.person_add},
    {'name': 'Property Sale', 'icon': Icons.holiday_village},
    {'name': 'Pension', 'icon': Icons.blind},
    {'name': 'Subsidy', 'icon': Icons.account_balance_wallet},
    {'name': 'Scholarship', 'icon': Icons.school},
    {'name': 'Grant', 'icon': Icons.request_quote},
    {'name': 'Pocket Money', 'icon': Icons.savings},
    {'name': 'Inheritance', 'icon': Icons.family_restroom},
    {'name': 'Found Money', 'icon': Icons.search},
    {'name': 'Staking Reward', 'icon': Icons.currency_exchange},
    {'name': 'Rental Bond', 'icon': Icons.vpn_key},
    {'name': 'Agriculture', 'icon': Icons.agriculture},
    {'name': 'Royalty', 'icon': Icons.auto_stories},
    {'name': 'Trust Fund', 'icon': Icons.foundation},
    {'name': 'Prize Money', 'icon': Icons.emoji_events},
    {'name': 'Venture', 'icon': Icons.rocket_launch},
    {'name': 'Contract Work', 'icon': Icons.handshake},
    {'name': 'Tips', 'icon': Icons.volunteer_activism},
    {'name': 'Sponsorship', 'icon': Icons.diamond},
    {'name': 'E-commerce', 'icon': Icons.shopping_cart_checkout},
    {'name': 'App Revenue', 'icon': Icons.get_app},
    {'name': 'Blog Revenue', 'icon': Icons.article},
    {'name': 'Online Teaching', 'icon': Icons.cast_for_education},
    {'name': 'Other Income', 'icon': Icons.add_circle_outline},
  ];

  List<Map<String, dynamic>> foundIncome = [];

  @override
  void initState() {
    foundIncome = categories;
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
      foundIncome = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category's")),
      body: Column(
        children: [
          // Search Bar Section
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
              ),
            ),
          ),

          Expanded(
            child: foundIncome.isNotEmpty
                ? GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: foundIncome.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context, foundIncome[index]['name']);
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
                            foundIncome[index]['icon'],
                            size: 45,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              foundIncome[index]['name'],
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
              child: Text(
                "No result found\nTry different search",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}