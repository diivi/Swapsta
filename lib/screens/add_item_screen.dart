import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  void onValueChange() {
    setState(() {
      _titleController.text;
      _descriptionController.text;
    });
  }

  @override
  void initState() {
    _titleController.addListener(onValueChange);
    _descriptionController.addListener(onValueChange);
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

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    var initialValue;
    if (arguments['title'] == null) {
      initialValue = '';
    } else {
      initialValue = arguments['title'];
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
                      controller: _titleController
                        ..text = (arguments['title'] != null)
                            ? arguments['title']
                            : '',
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
                          )),
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
                      Container(
                        padding: const EdgeInsets.all(40),
                        decoration: const BoxDecoration(
                          color: Color(0XFFFFDDC3),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ElevatedButton(
                          child: const Icon(
                            Icons.add_rounded,
                            color: Colors.orange,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const CircleBorder()),
                          onPressed: () {},
                        ),
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
                    controller: _descriptionController
                      ..text = (arguments['description'] != null)
                          ? arguments['description']
                          : '',
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
                  onTap: () {},
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
