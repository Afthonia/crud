import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
    as dpicker;
import 'package:url_launcher/url_launcher.dart';
import 'package:crud/routes.dart';
import 'package:crud/network/dio_connect.dart';
import 'package:crud/models/user_model.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Crud API Example App',
    initialRoute: '/home',
    getPages: appRoutes(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isConnected = false;

  var apiController = TextEditingController();
  var nameController = TextEditingController();
  var imageController = TextEditingController();
  DateTime dateController = DateTime.now();

  DioConnect? dioConnect;

  // substitute :)
  List<Map<String, dynamic>> userss = [
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
    {
      "_id": "64688f52786dbb03e878a910",
      "image":
          "assets/profile.png",
      "name": "ayşe",
      "age": 19,
      "sign": "Virgo"
    },
  ];

  var users = [];

  @override
  void initState() {
    super.initState();

    imageController.text =
        'assets/profile.png';
  }

  void _showAPIConnect() {
    Get.defaultDialog(
      title: 'ENTER API KEY',
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Api Key',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: apiController,
              cursorColor: Colors.teal.shade400,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: 'Please Enter',
                hintMaxLines: 1,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _launchURL();
              },
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Click for Api Key',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: () async {
                    dioConnect = DioConnect(apiController.text);
                    if (apiController.text != '' && await dioConnect!.getResponse()) {
                      setState(() {
                        isConnected = true;
                      });
                    } else {
                      setState(() {
                        isConnected = false;
                      });
                    }
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade400,
                  ),
                  child: const Text('Connect')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://crudcrud.com');

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void getData(key) async {
    try {
      var resp = await dioConnect!.getData();

      setState(() {
        users = resp as List<UserModel>;
      });

    } catch (e) {
      print('the error is: $e');
    }
  }

  void _showSignForm() {
    Get.defaultDialog(
      title: 'CREATE USER',
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: nameController,
              cursorColor: Colors.teal.shade400,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                hintMaxLines: 1,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: imageController,
              cursorColor: Colors.teal.shade400,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Birthday',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
              ),
              onTap: () {
                dpicker.DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(1923, 1, 1),
                  maxTime: DateTime.now(),
                  onChanged: (date) => print('change $date'),
                  onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      dateController = date;
                      // dateController.text =
                      //     '${date.month} ${date.day} ${date.year}';
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: dpicker.LocaleType.en,
                );
              },
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade400,
                    ),
                    onPressed: () {
                     setState(() {
                        dioConnect!.postData({
                        'image': imageController.text,
                        'name': nameController.text,
                        'age': DateTime.now().year - dateController.year,
                        'sign': UserModel.getSign(
                            dateController.month, dateController.day),
                      });
                        nameController.text = '';
                        dateController = DateTime.now();
                        getData(apiController.text);
                      });

                      //print(users);

                      Get.back();
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateForm(int chosenIndex) {
    Get.defaultDialog(
      title: 'UPDATE USER',
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      content: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: nameController,
              cursorColor: Colors.teal.shade400,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                hintMaxLines: 1,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: imageController,
              cursorColor: Colors.teal.shade400,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Birthday',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                ),
              ),
              onTap: () {
                dpicker.DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  minTime: DateTime(1923, 1, 1),
                  maxTime: DateTime.now(),
                  onChanged: (date) => print('change $date'),
                  onConfirm: (date) {
                    print('confirm $date');
                    setState(() {
                      dateController = date;
                      // dateController.text =
                      //     '${date.month} ${date.day} ${date.year}';
                    });
                  },
                  currentTime: DateTime.now(),
                  locale: dpicker.LocaleType.en,
                );
              },
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        dioConnect!.updateData(users[chosenIndex].id,
                          {
                            'image': imageController.text,
                            'name': nameController.text,
                            'age': DateTime.now().year - dateController.year,
                            'sign': 'Taurus',
                          }
                      );
                        nameController.text = '';
                        dateController = DateTime.now();
                        getData(apiController.text);
                      });

                      print(users);

                      Get.back();
                    },
                    child: const Text('Update'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud API Example'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade400,
      ),
      body: isConnected
          ? (users.isEmpty
              ? const Center()
              : Card(
                  child: ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width/4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.asset('${(users[index]).image}'),
                              ),
                            ),
                            const VerticalDivider(indent: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(users[index].name),
                                Text('${users[index].age} years old'),
                                Text(users[index].sign),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _showUpdateForm(index);
                                    },
                                    icon: const Icon(Icons.mode_edit_outlined),
                                    color: Colors.grey,
                                  ),
                                  IconButton(
                                    onPressed: () {

                                      setState(() {
                                        dioConnect!.deleteData(users[index].id, {
                                        'image': imageController.text,
                                        'name': nameController.text,
                                        'age': DateTime.now().year - dateController.year,
                                        'sign': UserModel.getSign(
                                            dateController.month, dateController.day),
                                      });
                                      });
                                    },
                                    icon: const Icon(Icons.delete_forever),
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: users.length,
                )))
          : const NoConnection(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            backgroundColor: isConnected ? Colors.teal.shade400 : Colors.red,
            onPressed: () {
              _showAPIConnect();
            },
            child: const Icon(Icons.compass_calibration_outlined),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            backgroundColor: isConnected
                ? Colors.teal.shade400
                : const Color.fromARGB(255, 160, 159, 159),
            onPressed: isConnected
                ? () {
                    _showSignForm();
                  }
                : null,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No Connection!'),
      ),
    );
  }
}


