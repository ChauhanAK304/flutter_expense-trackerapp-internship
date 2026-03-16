import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final formKey=GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  void initState(){
    super.initState();

    if (Get.arguments != null && Get.arguments is Map && Get.arguments['isEditing'] == true) {
      var oldData = Get.arguments['oldData'];

      titleController.text = oldData['Title'];
      amountController.text = oldData['Amount'].toString();
      dateController.text = oldData['Date'] ?? "";
      noteController.text = oldData['Note'] ?? "";
    }


  }

  void saveIncomeToFirebase() async {

    final bool isEditing = Get.arguments != null && Get.arguments['isEditing'] == true;
    final String? docId = isEditing ? Get.arguments['docId'] : null;

    try {
      final firestore = FirebaseFirestore.instance;


      Map<String, dynamic> transactionData = {
        'Title': titleController.text.trim(),
        'Amount': double.tryParse(amountController.text) ?? 0.0,
        'Date': dateController.text,
        'Note': noteController.text.trim(),
        'Type': 'income',
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (isEditing && docId != null) {
        //  Agar Edit kar rahe hain toh UPDATE karne k liye
        await firestore.collection('transection').doc(docId).update(transactionData);
        debugPrint("Data Update ho gaya!");
      } else {
        // Agar Nayi entry hai toh ADD karne k liye
        transactionData['createdAt'] = FieldValue.serverTimestamp();
        await firestore.collection('transection').add(transactionData);
        debugPrint("Naya Data Save ho gaya!");
      }

      Get.offAll(() => const HomeScreen());

    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar("Error", "Kuch gadbad hui: $e");
    }
  }

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {

        dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Get.arguments != null ? "Update Income" : "Add Income",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/addincome.png'), //
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Title Field
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty){return "Enter Valid Title";}
                      else{return null;}
                    },
                      controller: titleController,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.title_sharp),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.green, width: 3), borderRadius: BorderRadius.circular(15)),
                          hintText: "Title",
                          hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  const SizedBox(height: 15),
                  // Amount Field
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty){return "Enter Valid Amount";}
                      else{return null;}
                    },
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.currency_rupee),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.green, width: 3), borderRadius: BorderRadius.circular(15)),
                          hintText: "Amount",
                          hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  const SizedBox(height: 15),
                  // Date Field
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty){return "Enter Valid Date";}
                        else{return null;}
                      },
                      controller: dateController,
                      readOnly: true,
                      onTap: () {
                        selectDate();
                      },
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.date_range),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.green, width: 3), borderRadius: BorderRadius.circular(15)),
                          hintText: "Select Date",
                          hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  const SizedBox(height: 15),
                  // Note Field
                  TextField(
                      controller: noteController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.abc,size: 33,),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.green, width: 3), borderRadius: BorderRadius.circular(15)),
                          hintText: "Note",
                          hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  const SizedBox(height: 50),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 150),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.green.shade500),
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          saveIncomeToFirebase();
                          debugPrint("All good");
                        }
                      },
                      child: const Text("Save", style: TextStyle(fontSize: 25, color: Colors.white))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

