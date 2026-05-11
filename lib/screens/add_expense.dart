


import 'package:expense_tracker/provider/data_provider.dart';
import 'package:expense_tracker/screens/expense_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


 class AddExpenseScreen extends StatefulWidget {




     const AddExpenseScreen({super.key});

   @override
   State<AddExpenseScreen> createState() => _AddExpenseState();
 }

class _AddExpenseState extends State<AddExpenseScreen> {
   String category  = "Select Category";
   final formKey=GlobalKey<FormState>();
   bool oneTime = false;


   @override
   void didChangeDependencies() {
     super.didChangeDependencies();
     if(!oneTime) {
       var provider = Provider.of<DataProvider>(context, listen: false);
       if (Get.arguments != null && Get.arguments is Map &&
           Get.arguments['isEditing'] == true) {
         var oldData = Get.arguments['oldData'];

         provider.getCategoryController.text = (oldData['category'] ?? "").toString();
         provider.getAmountController.text = oldData['Amount'].toString();
         provider.getDateController.text = oldData['Date'] ?? "";
         provider.getNoteController.text = oldData['Note'] ?? "";
       }
       oneTime = true;
     }

   }

   Future<void> selectDate() async {
     var provider = Provider.of<DataProvider>(context,listen: false);
     DateTime? pickedDate = await showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(2000),
       lastDate: DateTime(2101),
     );

     if (pickedDate != null) {
       setState(() {

         provider.getDateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
       });
     }
   }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataProvider>(context,listen: false);
     final bool isEditing = Get.arguments != null && Get.arguments['isEditing'] == true;
     final String? docId = isEditing ? Get.arguments['docId'] : null;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            provider.clearControllers();
          }
        },
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text(Get.arguments != null ? "Update Expense" : "Add Expense",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    height: height*0.2,
                    width: width*0.4,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/addexpense.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Category Field
                  TextFormField(

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Pls Enter Category";
                        }
                        return null;
                      },
                      controller: provider.getCategoryController,
                      readOnly: true,
                      onTap: () async {
                        final result = await Get.to(()=> const ExpenseCategoryScreen());
                        debugPrint(result);
                        setState(() {
                          provider.getCategoryController.text = result;
                        });


                      },
                      style: const TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black),
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                          prefixIcon: const Icon(Icons.category,color: Colors.black,),
                          filled: true,
                          fillColor: Colors.grey.shade400,
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue, width: 3), borderRadius: BorderRadius.circular(15)),
                          hintText: category,
                          hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  const SizedBox(height: 15),

                  // Amount Field
                  TextFormField(

                    validator: (value) {
                      if(value!.isEmpty){return "Pls Enter Amount";}
                      else{return null;}
                    },
                      controller: provider.getAmountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black),
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            color: Colors.red, // Error color fix
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: const Icon(Icons.currency_rupee,color: Colors.black,),
                          filled: true,
                          fillColor: Colors.grey.shade400,
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue, width: 3), borderRadius: BorderRadius.circular(15)),
                          hintText: "Amount",
                          hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  const SizedBox(height: 15),

                  // Date Field
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){return "Pls Enter Date";}
                      else{return null;}
                    },
                      controller: provider.getDateController,
                      readOnly: true,
                      onTap: () {
                        selectDate();
                      },
                      style: const TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.black),
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          prefixIcon: const Icon(Icons.date_range,color: Colors.black,),
                          filled: true,
                          fillColor: Colors.grey.shade400,
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue, width: 3), borderRadius: BorderRadius.circular(15)),
                          hintText: "Select Date",
                          hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  const SizedBox(height: 15),

                  // Note Field
                  TextField(
                      controller: provider.getNoteController,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.abc,size: 33,color: Colors.black,),
                          filled: true,
                          fillColor: Colors.grey.shade400,
                          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.black54, width: 3), borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.blue, width: 3), borderRadius: BorderRadius.circular(15)),
                          hintText: "Note",
                          hintStyle: const TextStyle(fontSize: 20, color: Colors.black54),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: width*1.0 ,
                     height: 60,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.blue),
                        onPressed: () {

                          if(formKey.currentState!.validate()) {
                            provider.saveExpenseToFirebase(isEditing,docId);
                            debugPrint("All good");
                          }
                        },
                        child: const Text("Save", style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

