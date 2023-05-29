import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    builder: EasyLoading.init(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isApiSaved = false;
  bool _isLoaded = false;
  bool _isConnected = false;
  SharedPreferences? prefs;

  var apiController = TextEditingController();
  var nameController = TextEditingController();
  var imageController = TextEditingController();
  DateTime dateController = DateTime.now();
  var searchController = TextEditingController();

  DioConnect? dioConnect;

  var users = [];
  var searchResults = [];

  @override
  void initState() {
    super.initState();

    isApiSaved();
    getData(apiController.text);
    imageController.text = 'assets/profile.png';
  }

  void isApiSaved() async {
    prefs = await SharedPreferences.getInstance();
    String? key = prefs?.getString('key');
    bool apiSaved = (key != null) ? true : false;

    if (apiSaved) {
      apiController.text = key;
      dioConnect = DioConnect(key);
      if (key != '' && await dioConnect!.getResponse()) {
        setState(() {
          _isConnected = true;
          showNotifier('Connected');
          getData(key);
          _isApiSaved = true;
        });
      } else {
        setState(() {
          _isConnected = false;
          apiController.text = '';
        });
      }
    }
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
                    setState(() {
                      _isLoaded = false;
                    });
                    EasyLoading.show(status: 'Loading...');
                    dioConnect = DioConnect(apiController.text);
                    if (apiController.text != '' &&
                        await dioConnect!.getResponse()) {
                      setState(() {
                        _isConnected = true;
                        _isLoaded = true;
                        _isApiSaved = true;
                      });
                    } else {
                      setState(() {
                        _isConnected = false;
                      });
                    }
                    if (_isLoaded) {
                      EasyLoading.dismiss();
                    }
                    Get.back();

                    if (_isConnected) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('key', apiController.text);
                    } else {
                      showNotifier('Error');
                    }
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
        searchResults = users;
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
                    onPressed: () async {
                      setState(() {
                        _isLoaded = false;
                      });
                      EasyLoading.show();


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
                      _isLoaded = true;
                      if (_isLoaded) {
                        EasyLoading.dismiss();
                      }
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
                        dioConnect!.updateData(users[chosenIndex].id, {
                          'image': imageController.text,
                          'name': nameController.text,
                          'age': DateTime.now().year - dateController.year,
                          'sign': 'Taurus',
                        });

                        print(users[chosenIndex]);
                        nameController.text = '';
                        dateController = DateTime.now();
                        getData(apiController.text);

                        searchResults = users;
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

  void _deleteData(int chosenIndex) {
    setState(() {
      dioConnect!.deleteData(users[chosenIndex].id, {
        'image': imageController.text,
        'name': nameController.text,
        'age': DateTime.now().year - dateController.year,
        'sign': UserModel.getSign(dateController.month, dateController.day),
      });
      users.remove(users[chosenIndex]);
      searchResults = users;
    });
  }

  void showNotifier(String message) {
    showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          alignment: Alignment.bottomCenter,
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
        );
      },
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
      body: _isConnected
          ? (_isApiSaved
              ? (users.isEmpty
                  ? const NoData()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SearchBar(
                            elevation: MaterialStateProperty.all(0.0),
                            controller: searchController,
                            side: MaterialStateBorderSide.resolveWith(
                                (Set<MaterialState> states) {
                              return const BorderSide(color: Colors.black);
                            }),
                            hintText: 'Search Anything',
                            leading: const Icon(Icons.search),
                            trailing: List.of(
                              {
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        searchController.text = '';
                                      });
                                    },
                                    icon: const Icon(Icons.close)),
                              },
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchResults = users.where((element) => element.name.toLowerCase().startsWith(value.toLowerCase())).toList();
                              });
                              },
                          ),
                        ),
                        Expanded(
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: Image.asset('${(searchResults[index]).image}'),
                                        ),
                                      ),
                                      const VerticalDivider(indent: 8.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(searchResults[index].name),
                                          Text('${searchResults[index].age} years old'),
                                          Text(searchResults[index].sign),
                                        ],
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _showUpdateForm(index);
                                              },
                                              icon: const Icon(
                                                  Icons.mode_edit_outlined),
                                              color: Colors.grey,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                _deleteData(index);
                                              },
                                              icon: const Icon(
                                                  Icons.delete_forever),
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
                            itemCount: searchResults.length,
                          ),
                        ),
                      ],
                    ))
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal.shade400,
                  ),
                ))
          : const NoConnection(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            backgroundColor: _isConnected ? Colors.teal.shade400 : Colors.red,
            onPressed: () {
              _showAPIConnect();
            },
            child: const Icon(Icons.compass_calibration_outlined),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            backgroundColor: _isConnected
                ? Colors.teal.shade400
                : const Color.fromARGB(255, 160, 159, 159),
            onPressed: _isConnected
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

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No Data!'),
      ),
    );
  }
}
