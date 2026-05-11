import 'package:expense_tracker/provider/auth_provider.dart';
import 'package:expense_tracker/provider/profile_provider.dart';
import 'package:expense_tracker/screens/image_picker_optionscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/notification_service.dart';

class CustomDrawerScreen extends StatefulWidget {
   const CustomDrawerScreen({super.key});

  @override
  State<CustomDrawerScreen> createState() => _CustomDrawerScreenState();
}

class _CustomDrawerScreenState extends State<CustomDrawerScreen> {


  bool isReminderOn = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider1>(context,listen: false);
    final provider2 = Provider.of<ProfileImage>(context,listen: false);

    final user = FirebaseAuth.instance.currentUser;
    String userName = user?.displayName ?? "User";
    var userEmail = user?.email ?? "no-email@example.com";

    var width = MediaQuery.of(context).size.width;
    return Drawer(
      width: width*0.9,
      child: Padding(
        padding: const EdgeInsets.only(right: 10,left: 10,top: 30),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Stack(children: [
                  SizedBox(
                    width: 180,
                     height: 150,
                    child: Consumer<ProfileImage>(
                      builder: (context, provider, child) {
                        return provider2.profileImage == null
                            ? const CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/images/profiler.png'),) // Default icon
                            : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(provider2.profileImage!),
                        );
                      },
                    ),
                  ),
                Positioned(
                    left: 130,
                    top: 95,
                    child: CircleAvatar(radius: 20,backgroundColor:Colors.green.shade300,
                      child: IconButton(onPressed: (){ProfileHelper.showImagePicker(context);}, icon: const Icon(Icons.camera_alt,size: 25,color: Colors.black,)),))],),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userName,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                 Text(
                  userEmail,
                  style: const TextStyle(fontSize: 18,color: Colors.indigo),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade400),
                  child:  ListTile(
                      leading: const Icon(Icons.notifications_rounded, size: 25,color: Colors.black),
                      title:  const Text("Daily Reminder",
                          style: TextStyle(fontSize: 19,color: Colors.black, fontWeight: FontWeight.bold)),
                      trailing: Switch(
                          activeColor: Colors.black54,
                          activeTrackColor: Colors.green,
                          inactiveTrackColor: Colors.grey,
                          trackOutlineColor: WidgetStateProperty.all(Colors.black45),
                          value: isReminderOn,
                          onChanged: (value) async {setState((){isReminderOn=value;});
                          if (isReminderOn) {
                            // Agar toggle ON hai toh rat 9 bje ke lie set karo
                            await NotificationHelper.scheduleDailyAt();
                            debugPrint("Reminder Set for 9 PM");
                          } else {
                            // Agar toggle OFF hai toh cancel kar do
                            await NotificationHelper.cancelAll();
                            debugPrint("Reminder Cancelled");
                          }
                          },
                          )
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Column(
                    children: [
                      ListTile(
                        leading: Icon(
                            Icons.settings,
                            size: 25,color: Colors.black
                        ),
                        title: Text(
                          "Account Setting",
                          style: TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black),
                      ),
                      Divider(
                        height: 3,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: Icon(
                            Icons.message,
                            size: 25,color: Colors.black
                        ),
                        title: Text(
                          "Manage Categories",
                          style: TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: 25,),
                      ),
                      Divider(
                        height: 3,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: Icon(Icons.help, size: 25,color: Colors.black),
                        title:
                        Text("Help & Support", style: TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold)),
                        trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: width*1.0,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        provider.logout();},
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),

                ),const SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
