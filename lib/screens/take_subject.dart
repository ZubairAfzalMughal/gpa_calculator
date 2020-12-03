import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpa_calculator/constant.dart';
import 'package:gpa_calculator/screens/gpa_cal.dart';

class TakeSubjects extends StatefulWidget {
  @override
  _TakeSubjectsState createState() => _TakeSubjectsState();
}

class _TakeSubjectsState extends State<TakeSubjects> {
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  bool isEnabled;
  int scale = 4;
  bool isHint = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Padding(
        padding: EdgeInsets.only(top: 100.0, left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Select Scales For Gpa",
                style: kSubjectColor.copyWith(
                    fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              DropdownButton(
                style: kSubjectColor,
                iconEnabledColor: Colors.white,
                dropdownColor: kMainColor,
                value: isHint ? null : scale,
                hint: Text(
                  'Scale',
                  style: kSubjectColor,
                ),
                onChanged: (int value) => setState(() {
                  scale = value;
                  isHint = false;
                  print(value);
                }),
                items: [4, 5]
                    .map(
                      (e) => DropdownMenuItem<int>(
                        child: Text(e.toString()),
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                autofocus: true,
                controller: controller,
                autovalidateMode: AutovalidateMode.always,
                validator: (value) => value.isEmpty ? 'Enter Subject' : null,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0)),
                    hintText: 'Enter Subject'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                width: 200.0,
                child: FlatButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: _onPressed,
                  child: Text(
                    'Next',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: kMainColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressed() {
    if (_formKey.currentState.validate()) {
      print(scale);
      if (controller.text != '0' && !isHint) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Gpa(
              subject: controller.text,
              scale: scale,
            ),
          ),
        );
      } else {
        _buildAlert(context);
      }
    }
  }

  _buildAlert(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: kMainColor,
            title: ListBody(
              children: [
                Text(
                  "Invalid Scale or",
                  style: kSubjectColor,
                ),
                Text(
                  "Subject number",
                  style: kSubjectColor,
                )
              ],
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: kSubjectColor,
                ),
              ),
            ],
          );
        });
  }
}
