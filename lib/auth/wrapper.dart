import 'package:expense_tracker/auth/welcome_screen.dart';
import 'package:expense_tracker/screens/custom_bottomappbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class WrapperScreen extends StatefulWidget {
  const WrapperScreen({super.key});

  @override
  State<WrapperScreen> createState() => _WrapperScreenState();

}

class _WrapperScreenState extends State<WrapperScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const CustomBottomAppBar();}
          else{
            return const WelcomeScreen();}
        });
  }
}
