import 'package:flutter/material.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}



class _CounterAppState extends State<CounterApp> {
  int count = 0;

  void incrementCounter() {
    setState((){
      count++;
    });
  }

  void decrementCounter() {
    setState(() {
      count--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Center(
            child: Text(
          "Counter App",
          style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold ),
        )),
      ),
      body: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Padding(
            padding: const EdgeInsets.only(left:170 ,top: 90 ),
            child: Row(
              children: [
                Center(
                    child: Text(count.toString(),style: const TextStyle(fontSize: 100,color: Colors.red)
                  ,

                ))
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 50),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: incrementCounter,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
                SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: decrementCounter,
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 50,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
