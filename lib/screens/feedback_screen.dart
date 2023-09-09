import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  static const routeName = '/feedback_screen';

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: DropdownMenuItem(
            child: Text('Feature'),
          ),
          value: "1"),
      DropdownMenuItem(
        child: Text('Design'),
        value: "2",
      ),
      DropdownMenuItem(
        child: Text('Request'),
        value: "3",
      ),
      DropdownMenuItem(
        child: Text('Appreciation'),
        value: "4",
      ),
    ];
    return menuItems;
  }

  String selectedValue = "1";
  double rating = 0;
  
  final TextEditingController _descriptionController = TextEditingController();
  void onValueChange() {
    setState(() {
      _descriptionController.text;
    });
  }

  @override
  void initState() {
    _descriptionController.addListener(onValueChange);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Feedback',
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color(0xFFF9F6F2),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'We value your feedback!',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Text(
                      'Please spare a few minutes of your time and provide us with your feedback to help us improve further.',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .03),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rate our services:',
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .1,
                      ),
                      RatingBar.builder(
                        minRating: 1,
                        itemSize: 26,
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
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .03),
                child: Row(
                  children: [
                    Text(
                      'Your issue:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .12,
                    ),
                    Flexible(
                      child: DropdownButtonFormField(
                        value: selectedValue,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        items: dropdownItems,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'Describe your feedback:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 200,
                    controller: _descriptionController,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        counterText: "${_descriptionController.text.length} / 200",
                        // contentPadding: const EdgeInsets.only(
                        // top: -50, bottom: 60, right: 10, left: 10),
                        labelText: 'Description',
                        // alignLabelWithHint: true,
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
              const SizedBox(height: 20),
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
