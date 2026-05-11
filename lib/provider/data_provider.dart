import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/custom_bottomappbar.dart';

class DataProvider with ChangeNotifier {


 final TextEditingController _categoryController = TextEditingController();
  TextEditingController get getCategoryController => _categoryController;
  final TextEditingController _amountController = TextEditingController();
 TextEditingController get getAmountController => _amountController;
  final TextEditingController _dateController = TextEditingController();
 TextEditingController get getDateController => _dateController;
  final TextEditingController _noteController = TextEditingController();
  TextEditingController get getNoteController => _noteController;




 void saveExpenseToFirebase (bool isEditing, dynamic docId) async{

 try {
   final firestore = FirebaseFirestore.instance;
   String userId = FirebaseAuth.instance.currentUser!.uid;



   Map<String, dynamic> transactionData = {
     'category' : _categoryController.text.trim(),
     'Amount': double.tryParse(getAmountController.text) ?? 0.0,
     'Date': getDateController.text,
     'Note': getNoteController.text.trim(),
     'Type': 'expense',
     'updatedAt': FieldValue.serverTimestamp(),
   };
   if (isEditing && docId != null) {
     //  Agar Edit kar rahe hain toh UPDATE karne k liye
     await firestore.collection("users").doc(userId).collection('transaction').doc(docId).update(transactionData);
     debugPrint("Data Update ho gaya!");

     Get.snackbar("Success", "Updated Expense Successfully  ",
         titleText: const Text("Success",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
         messageText: const Text("Updated Expense Successfully ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
         snackPosition: SnackPosition.BOTTOM,
         duration: const Duration(seconds: 3),
         backgroundColor: Colors.green.shade200
         );
   } else {
     // Agar Nayi entry hai toh ADD karne k liye
     try {
       transactionData['createdAt'] = FieldValue.serverTimestamp();
       await firestore.collection("users").doc(userId).collection('transaction').add(transactionData).then((v){debugPrint("Naya Data Save ho gaya!");});
       debugPrint("Naya Data Save ho gaya!");

       Get.snackbar("Success", "Saved Expense Successfully  ",
           titleText: const Text("Success",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
           messageText: const Text("Saved Expense Sucessfully",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
           snackPosition: SnackPosition.BOTTOM,
           duration: const Duration(seconds: 3),
           backgroundColor: Colors.green.shade100
       );

     } catch (e) {
       debugPrint("$e");

       Get.snackbar("Error", "Something went wrong: $e",
           titleText: const Text("Error",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
           messageText: Text("Something went wrong: $e",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
           snackPosition: SnackPosition.BOTTOM,
           duration: const Duration(seconds: 3),
           backgroundColor: Colors.red.shade100);

     }
   }

   // Saare controllers ko reset karne k liye
   getCategoryController.clear();
   getAmountController.clear();
   getDateController.clear();
   getNoteController.clear();

    Get.offAll(() => const CustomBottomAppBar());

 } catch (e) {
 debugPrint("Error: $e");
 Get.snackbar("Error", "Something went wrong: $e",
     titleText: const Text("Error",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
     messageText: Text("Something went wrong: $e",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
     snackPosition: SnackPosition.BOTTOM,
     duration: const Duration(seconds: 3),
     backgroundColor: Colors.red.shade100);
 }

}

 void saveIncomeToFirebase() async {


   final bool isEditing = Get.arguments != null && Get.arguments['isEditing'] == true;
   final String? docId = isEditing ? Get.arguments['docId'] : null;

   try {
     final firestore = FirebaseFirestore.instance;
     String userId = FirebaseAuth.instance.currentUser!.uid;


     Map<String, dynamic> transactionData = {
       'category': _categoryController.text.trim(),
       'Amount': double.tryParse(getAmountController.text) ?? 0.0,
       'Date': getDateController.text,
       'Note': getNoteController.text.trim(),
       'Type': 'income',
       'updatedAt': FieldValue.serverTimestamp(),
     };
     if (isEditing && docId != null) {
       //  Agar Edit kar rahe hain toh UPDATE karne k liye
       await firestore.collection("users").doc(userId).collection('transaction').doc(docId).update(transactionData);
       debugPrint("Data Update ho gaya!");

       Get.snackbar("Success", "Updated Income Successfully  ",
           titleText: const Text("Success",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
           messageText: const Text(" Update Income Successfully",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
           snackPosition: SnackPosition.BOTTOM,
           duration: const Duration(seconds: 5),
           backgroundColor: Colors.green.shade100
           );

     } else {
       // Agar Nayi entry hai toh ADD karne k liye
       try {
         transactionData['createdAt'] = FieldValue.serverTimestamp();
         firestore.collection("users").doc(userId).collection('transaction').add(transactionData).then((v){debugPrint("Naya Data Save ho gaya!");});
         debugPrint("Naya Data Save ho gaya!");

         Get.snackbar("Success", "Save Income  ",
             titleText: const Text("Success",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
             messageText: const Text("Save Income Sucessfully",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
             snackPosition: SnackPosition.BOTTOM,
             duration: const Duration(seconds: 3),
             backgroundColor: Colors.green.shade100
         );
       } catch (e) {
         debugPrint("$e");

         Get.snackbar("Error", "Something went wrong: $e",
             titleText: const Text("Error",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
             messageText: Text("Something went wrong: $e",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
             snackPosition: SnackPosition.BOTTOM,
             duration: const Duration(seconds: 3),
             backgroundColor: Colors.red.shade100);

       }
     }

     // Saare controllers ko reset karne k liye
     getCategoryController.clear();
     getAmountController.clear();
     getDateController.clear();
     getNoteController.clear();

      Get.offAll(() => const CustomBottomAppBar());

   } catch (e) {
     debugPrint("Error: $e");
     Get.snackbar("Error", "Something went wrong: $e",
         titleText: const Text("Error",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
         messageText: Text("Something went wrong: $e",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
         snackPosition: SnackPosition.BOTTOM,
         duration: const Duration(seconds: 3),
         backgroundColor: Colors.red.shade100);
   }
 }


 void deleteDataFromFirebase (dynamic docId) {
   String userId = FirebaseAuth.instance.currentUser!.uid;

   Get.defaultDialog(
     backgroundColor: Colors.red.shade100,
     radius: 20,
     title: "Delete Transaction?",
     titleStyle: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.red),
     middleText: "Do you really want to delete this item?",
     middleTextStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),
     confirm: TextButton(onPressed: () async {

       // Home screen se bheji gayi ID ka use karke delete karne k liye
       await FirebaseFirestore.instance.collection("users").doc(userId)
           .collection('transaction')
           .doc(docId)
           .delete();

       Get.back(); // Dialog band karne ke liye
       Get.back(); // Home screen par wapas jaane ke liye

       Get.snackbar("Success", "Expense Delete ",
           titleText: const Text("Success",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
           messageText: const Text("The item was successfully deleted",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
           snackPosition: SnackPosition.BOTTOM,
           duration: const Duration(seconds: 5),
           backgroundColor: Colors.green.shade100);

     }, child:  const Text("Yes",style: TextStyle(
         fontSize: 25,
         fontWeight: FontWeight.bold,
         color: Colors.red),)),

     cancel: TextButton(onPressed: (){Get.back();},
         child: const Text("No",style: TextStyle(
             fontSize: 25,fontWeight: FontWeight.bold,
             color: Colors.black),)),



   );

 }



 Future<void> selectDate(BuildContext,context) async {

   DateTime? pickedDate = await showDatePicker(
     context: context,
     initialDate: DateTime.now(),
     firstDate: DateTime(2000),
     lastDate: DateTime(2101),
   );

   if (pickedDate != null) {
     getDateController.text =
     "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
     notifyListeners();
   }
 }


 void fetchDataFromFirebase () async{
   String userId = FirebaseAuth.instance.currentUser!.uid;

   FirebaseFirestore.instance.collection('users').doc(userId).
   collection('transaction').orderBy('createdAt',
       descending: true).snapshots();
 }



 void clearControllers() {
   _categoryController.clear();
   _amountController.clear();
   _dateController.clear();
   _noteController.clear();
    notifyListeners();
 }


}
