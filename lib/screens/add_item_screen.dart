import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../globals.dart' as globals;

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  static const routeName = '/add-item';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final categories = globals.categories;
  late List<Map<String, dynamic>> dropdownItems = [];
  String selectedValue = "1";
  double rating = 0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // void onValueChange() {
  //   setState(() {
  //     _titleController.text;
  //     _descriptionController.text;
  //   });
  // }

  @override
  void initState() {
    categories.asMap().forEach((index, value) => {
          if (index != 0)
            {
              dropdownItems.add({
                "text": value.name,
                "emoji": value.emoji,
                "value": value.id,
              }),
            }
        });
    super.initState();
  }

  void dispose() {
    print("dispose");
    // This is the line that breaks when called inside setState() of onPressed() method
    _titleController.dispose();
    super.dispose();
  }

  List<String> imageUrls = [];
  List<File> imageFile = [];
  final picker = ImagePicker();
  Future selectImageCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imageFile.add(File(pickedFile.path));
      } else {
        return;
      }
    });
  }

  Future selectImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile.add(File(pickedFile.path));
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var item_id = Uuid().v4();
    Future<void> addItemToDatabase() async {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;
      print("HIT HERE");
      print(imageUrls);
      if (user != null) {
        final userId = user.email; // Use the user's email as the document ID
        final userDocument = firestore.collection('users').doc(userId);
        final itemDocument = firestore.collection('items').doc(item_id);

        final newItem = {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'category': selectedValue,
          'condition': rating,
          'dateCreated': DateTime.now(),
          'swapped': false,
          'id':
              item_id, // You can use a package like 'uuid' to generate a unique ID
          'imageUrls': imageUrls,
        };
        print(newItem);
        // Update the 'items' array in the user document
        try {
          await userDocument.update({
            'items': FieldValue.arrayUnion([newItem]),
          });
        } on Exception catch (e) {
          print(e);
        }

        await itemDocument.set(newItem);
      }
      return;
    }

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    var initialValue;
    if (arguments['title'] == null) {
      initialValue = '';
    } else {
      initialValue = arguments['title'];
    }
    bool isLoading = true;
    Future<void> uploadFile(imagePath) async {
      File file = imagePath;
      if (isLoading) {
        showDialog(
          // The user CANNOT close this dialog  by pressing outsite it
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    // Some text
                    Text('Loading...')
                  ],
                ),
              ),
            );
          },
        );
      }
      String imageName =
          'productImages/${DateTime.now().millisecondsSinceEpoch}';
      String downloadUrl = '';
      try {
        await FirebaseStorage.instance.ref(imageName).putFile(file);
        downloadUrl =
            await FirebaseStorage.instance.ref(imageName).getDownloadURL();
        setState(() {
          imageUrls.add(downloadUrl);
        });
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: _buildAppBar(arguments['header']),
        backgroundColor: const Color(0xFFF9F6F2),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      maxLength: 50,
                      controller: _titleController,
                      decoration: InputDecoration(
                        counterText: "${_titleController.text.length} / 50",
                        labelText: 'Title',
                        contentPadding: const EdgeInsets.all(8),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .03),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Images',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(40),
                            decoration: const BoxDecoration(
                              color: Color(0XFFFFDDC3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ElevatedButton(
                              child: const Icon(
                                Icons.add_rounded,
                                color: Colors.orange,
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const CircleBorder()),
                              onPressed: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: ((context, setState) {
                                        return Container(
                                          padding: const EdgeInsets.only(
                                            left: 30,
                                            right: 30,
                                            top: 25,
                                            bottom: 40,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Select One Option',
                                                style: TextStyle(fontSize: 22),
                                              ),
                                              const SizedBox(height: 20),
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: selectImageCamera,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color: Colors.orange,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 16.0,
                                                            vertical: 16.0,
                                                          ),
                                                          child: Text(
                                                            'Choose from camera',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: selectImageGallery,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons.image_outlined,
                                                          color: Colors.orange,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 16.0,
                                                            vertical: 16.0,
                                                          ),
                                                          child: Text(
                                                            'Choose from Gallery',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    );
                                  }),
                            ),
                          ),
                          (imageFile.isNotEmpty)
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * .36,
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imageFile.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          imageFile[index],
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 200,
                    controller: _descriptionController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        counterText:
                            "${_descriptionController.text.length} / 200",
                        labelText: 'Description',
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                  ),
                  const SizedBox(
                    height: 25,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedValue,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down_rounded,
                            color: Colors.orange,
                          ),
                          items: dropdownItems.map((e) {
                            return DropdownMenuItem<String>(
                              child: Row(
                                children: [
                                  Text(e['emoji']),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .05,
                                  ),
                                  Text(e['text']),
                                ],
                              ),
                              value: e['value'],
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Condition',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      RatingBar.builder(
                        minRating: 1,
                        itemSize: 22,
                        allowHalfRating: true,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            this.rating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Ink(
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.orange,
                  ),
                  color: Colors.orange,
                ),
                child: InkWell(
                  splashColor: const Color.fromRGBO(
                    255,
                    255,
                    255,
                    0.1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      for (File item in imageFile) {
                        await uploadFile(item);
                      }
                      await addItemToDatabase();
                      print("hehehehehhe");
                      setState(() {
                        isLoading = false;
                        imageFile.clear();
                        _titleController.clear();
                        _descriptionController.clear();
                        selectedValue = "1";
                        rating = 0;
                      });
                    } catch (error) {
                      setState(() {
                        isLoading = false;
                      });
                    }

                    setState(() {
                      isLoading = false;
                    });
                    Fluttertoast.showToast(msg: 'Your item has been added');
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Submit',
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildAppBar(String? header) {
  if (header == null) {
    return Text(
      'Add Item',
      textAlign: TextAlign.left,
    );
  }
  return Text(
    'Edit Item',
    textAlign: TextAlign.left,
  );
}
