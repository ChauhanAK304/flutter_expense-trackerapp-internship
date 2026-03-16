import 'package:expense_tracker/auth/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  logout() async{
   await FirebaseAuth.instance.signOut();
   Get.offAll(()=> const LoginScreen());

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.amberAccent,
              radius: 60,
              backgroundImage: AssetImage('assets/images/profiler.png'),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Akshay Chauhan",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const Text(
              "ac24130@gmail.com",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "9127345675",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300),
              child: const ListTile(
                leading: Icon(
                  Icons.settings,
                  size: 35,
                ),
                title: Text(
                  "Account Setting",
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.message,
                      size: 35,
                    ),
                    title: Text(
                      "Manage Categories",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  Divider(
                    height: 5,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications_rounded, size: 35),
                    title: Text("Notification Setting",
                        style: TextStyle(fontSize: 20)),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                  Divider(
                    height: 5,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Icon(Icons.help, size: 35),
                    title:
                        Text("Help & Support", style: TextStyle(fontSize: 20)),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 360,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {logout();},
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
