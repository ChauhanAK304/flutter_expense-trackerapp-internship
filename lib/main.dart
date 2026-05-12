import 'package:expense_tracker/provider/auth_provider.dart';
import 'package:expense_tracker/provider/data_provider.dart';
import 'package:expense_tracker/provider/profile_provider.dart';
import 'package:expense_tracker/services/notification_service.dart';
import 'package:expense_tracker/utils/controller.dart';
import 'package:expense_tracker/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'auth/wrapper.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Notifications ko Web par skip karein
  if (!kIsWeb) {
    await NotificationHelper.initializeNotification();
  }

  await GetStorage.init();

  // 2. Firebase Initialization (Check parameters again if needed)
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDj9dn82Qf1duTtoyV_BgU5KiRYoN8H4GI",
        authDomain: "expensetrackerapp-61678.firebaseapp.com",
        projectId: "expensetrackerapp-61678",
        storageBucket: "expensetrackerapp-61678.firebasestorage.app",
        messagingSenderId: "809977872811",
        appId: "1:809977872811:web:365c676fdb44011aa692ee",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  Get.put(ThemeController());

  // 3. MyApp load karna zaroori hai (Kyuki MaterialApp vahi hai)
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => ProfileImage()),
        ChangeNotifierProvider(create: (context) => AuthProvider1(
            )),
      ],
      child: const MyHomePage(), // Yahan WrapperScreen nahi, MyApp aayega
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage ({super.key});


  @override
  Widget build(BuildContext context) {
    // Controller ko check ke saath find karein
    ThemeController themeController;
    try {
      themeController = Get.find<ThemeController>();
    } catch (e) {
      // Agar nahi milta toh naya put karein (Null safety backup)
      themeController = Get.put(ThemeController());
    }

    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: lightTheme,
      darkTheme: darkTheme,
      // Null check se bachne ke liye direct access
      themeMode: themeController.theme,
      home: const WrapperScreen(),
    ));
  }
}



//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

