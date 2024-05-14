import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  runApp(const MyApp7());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          "BF6BOtNwxZkbjwy22IkPxMxQej_7non6FFm_GDKJrhNlu4A9Zyon-doTjZQ-o6YgqNPP8fzUutkm3-JeJYeuaZE",
      appId: "1:241216409987:android:b08571d8441fbb271666b6",
      messagingSenderId: "241216409987",
      projectId: "led1-39197",
      databaseURL: "https://led1-39197-default-rtdb.firebaseio.com/",
    ),
  );
  runApp(const MyApp7());
}

class MyApp7 extends StatefulWidget {
  const MyApp7({super.key});

  @override
  State<MyApp7> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp7> {
  bool a = false;
  bool b = false;
  final dbr = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    loadInitialValues();
  }

  Future<void> loadInitialValues() async {
    DataSnapshot snapshotA = await dbr.child('bulb1').get();
    DataSnapshot snapshotB = await dbr.child('bulb2').get();

   

    setState(() {
      a = snapshotA.value as bool? ?? false;
      b = snapshotB.value as bool? ?? false;
    });
  }

  Future<void> toggleLightA() async {
    setState(() {
      a = !a;
    });
    await dbr.child('bulb1').set(a);
  }

  Future<void> toggleLightB() async {
    setState(() {
      b = !b;
    });
    await dbr.child('bulb2').set(b);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My app 07"),
          backgroundColor: Colors.pink,
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              a
                  ? const Icon(
                      Icons.lightbulb,
                      size: 100,
                      color: Color.fromARGB(255, 248, 19, 3),
                    )
                  : const Icon(Icons.lightbulb,
                      size: 100, color: Color.fromARGB(255, 3, 3, 3)),
              ElevatedButton(
                  onPressed: toggleLightA,
                  child: a ? const Text("OFF") : const Text("ON")),
              b
                  ? const Icon(
                      Icons.lightbulb,
                      size: 100,
                      color: Color.fromARGB(255, 60, 248, 3),
                    )
                  : const Icon(Icons.lightbulb,
                      size: 100, color: Color.fromARGB(255, 3, 3, 3)),
              ElevatedButton(
                  onPressed: toggleLightB,
                  child: b ? const Text("OFF") : const Text("ON")),
            ],
          ),
        ),
      ),
    );
  }
}
