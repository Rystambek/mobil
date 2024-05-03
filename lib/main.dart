import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  String enteredText = '';
  final TextEditingController controller = TextEditingController();
  final TextEditingController resultController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("6-amaliy ish"),
          backgroundColor: Colors.green,
        ),
      body: Padding(
      padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage("https://t3.ftcdn.net/jpg/05/56/29/10/360_F_556291020_q2ieMiOCKYbtoLITrnt7qcSL1LJYyWrU.jpg"),
              ),
              SizedBox(height: 12),
              TextField(
                  controller: controller,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (str) {
                    print(str);
                    setState(() {
                      enteredText = str;
                    });
                    },
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  errorText: "Maydonni tuldiring",
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    enteredText = controller.text;
                    resultController.text = enteredText;
                    controller.clear();
                  });
                },
                child: Text("Yuborish"),
              ),
              SizedBox(height: 12),
              TextField(
                controller: resultController,
                enabled: false,
                decoration: InputDecoration(
                  labelText: "Kiritilgan Matn",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                ),
              ),

            ],
          ),
      ),
        bottomNavigationBar: Theme(
          data: ThemeData(canvasColor: Colors.blue),
          child: BottomNavigationBar(
              backgroundColor: Color(0xFF1E1E1E),
              fixedColor: Colors.red,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 24,
              currentIndex: currentIndex,
            onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
                },

          type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wallet), label: "Wallet"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart), label: "Pie chart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Person"),
            ],
          ),
        ),
      ),
    );
  }
}
