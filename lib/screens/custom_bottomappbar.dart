import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:expense_tracker/screens/add_expense.dart';
import 'package:expense_tracker/screens/analytics_screen.dart';
import 'package:expense_tracker/screens/home.dart';
import 'package:flutter/material.dart';



class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({super.key});

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int index = 1;
  final screens = [
    const AddExpenseScreen(),
    const HomeScreen(),
    const AnalyticsScreen()
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        index: index,
        color: Theme.of(context).colorScheme.secondary,
          items:  <Widget>[
            Icon(Icons.add,size: 30,color: Theme.of(context).colorScheme.onSurface,),
            Icon(Icons.home,size: 30,color: Theme.of(context).colorScheme.onSurface,),
            Icon(Icons.analytics_outlined,size: 30,color: Theme.of(context).colorScheme.onSurface,),

          ],
        onTap: (newIndex){
          setState(() {
            index = newIndex;
          });
        },

      ));
  }
}
