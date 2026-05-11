import 'package:flutter/material.dart';

class IncomeCategoryScreen extends StatefulWidget {
  const IncomeCategoryScreen({super.key});

  @override
  State<IncomeCategoryScreen> createState() => _IncomeCategoryScreenState();
}

class _IncomeCategoryScreenState extends State<IncomeCategoryScreen> {
  final List<Map<String,dynamic>> categories = [
    {'name': 'Salary', 'icon': Icons.payments},
    {'name': 'Business Profit', 'icon': Icons.store},
    {'name': 'Freelance', 'icon': Icons.laptop_mac},
    {'name': 'Bonus', 'icon': Icons.card_giftcard},
    {'name': 'Overtime', 'icon': Icons.more_time},
    {'name': 'Commission', 'icon': Icons.percent},
    {'name': 'Consultation', 'icon': Icons.support_agent},

    // --- Investments & Passive Income ---
    {'name': 'Dividends', 'icon': Icons.pie_chart},
    {'name': 'Stock Profit', 'icon': Icons.show_chart},
    {'name': 'Interest Info', 'icon': Icons.account_balance},
    {'name': 'Rental Income', 'icon': Icons.real_estate_agent},
    {'name': 'Crypto Profit', 'icon': Icons.currency_bitcoin},
    {'name': 'Mutual Funds', 'icon': Icons.analytics},
    {'name': 'Fixed Deposit', 'icon': Icons.lock_clock},

    // --- Rewards & Gifts ---
    {'name': 'Cashback', 'icon': Icons.redeem},
    {'name': 'Gift Money', 'icon': Icons.celebration},
    {'name': 'Lottery', 'icon': Icons.confirmation_number},
    {'name': 'Coupon', 'icon': Icons.local_offer},
    {'name': 'Reward Points', 'icon': Icons.stars},

    // --- Refunds & Returns ---
    {'name': 'Tax Refund', 'icon': Icons.assignment_returned},
    {'name': 'Loan Repaid', 'icon': Icons.keyboard_return}, // Kisi ko udhaar diya tha wo wapas mila
    {'name': 'Product Return', 'icon': Icons.settings_backup_restore},
    {'name': 'Insurance Claim', 'icon': Icons.health_and_safety},

    // --- Side Hustles & Selling ---
    {'name': 'Selling Items', 'icon': Icons.sell}, // Purana saman bechna
    {'name': 'Affiliate', 'icon': Icons.campaign},
    {'name': 'Youtube/Ads', 'icon': Icons.play_circle_fill},
    {'name': 'Referral', 'icon': Icons.person_add},
    {'name': 'Property Sale', 'icon': Icons.holiday_village},

    // --- Government & Grants ---
    {'name': 'Pension', 'icon': Icons.blind},
    {'name': 'Subsidy', 'icon': Icons.account_balance_wallet},
    {'name': 'Scholarship', 'icon': Icons.school},
    {'name': 'Grant', 'icon': Icons.request_quote},

    // --- Occasional & Others ---
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
  List<Map<String,dynamic>> foundIncome = [];

  @override
  void initState() {
    // TODO: implement initState
    foundIncome = categories;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // Agar search bar khali hai to saari categories dikhane k lie
      results = categories;
    } else {
      // Case-insensitive search: 'Food' aur 'food' dono match honge
      results = categories
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // UI update karne ke lie setState
    setState(() {
      foundIncome = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Category's"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,

            children: [
              TextFormField(
                onChanged: (value) => _runFilter(value),

                  validator: (value) {
                    if (value!.isEmpty){return "Enter Valid Category";}
                    else{return null;}
                  },
                  // controller: titleController,
                  style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.search,color: Colors.black,),
                      filled: true,
                      fillColor: Colors.grey.shade400,

                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue, width: 3), borderRadius: BorderRadius.circular(15)),

                      hintText: "Search Category",
                      hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
              const SizedBox(height: 15,),

              foundIncome.isNotEmpty?
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: foundIncome.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {Navigator.pop(context, categories[index]['name']);},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            foundIncome[index]['icon'],
                            size: 40,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 7),
                          Text(
                            foundIncome[index]['name'],
                            style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onSecondaryContainer),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ):const Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No result found please try ",style: TextStyle(fontSize: 20),),
                    Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("with different search",style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  ],
                ),
              )],
          ),
        ),
      ),
    );
  }
}
