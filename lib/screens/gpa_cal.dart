import 'package:flutter/material.dart';
import 'package:gpa_calculator/constant.dart';
import 'package:gpa_calculator/screens/gpa_model.dart';
import 'package:gpa_calculator/screens/result_screem.dart';

class Gpa extends StatefulWidget {
  final String subject;
  final int scale;

  const Gpa({Key key, this.subject, this.scale}) : super(key: key);

  @override
  _GpaState createState() => _GpaState();
}

class _GpaState extends State<Gpa> {
  int length;
  bool isShowHint = true;
  List<String> selectedItem = new List();
  List<String> selectedCD = new List();
  List<bool> hintGrades = new List();
  List<bool> hintCp = new List();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    length = int.parse(widget.subject);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 5.0,
        title: Text('GPA Calculator'),
      ),
      backgroundColor: kMainColor,
      body: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: ListView.builder(
            itemCount: length + 1,
            itemBuilder: (context, index) {
              for (int i = 0; i < 7; i++) {
                selectedItem.add("A");
              }
              for (int i = 0; i < 4; i++) {
                selectedCD.add("1");
              }
              for (int i = 0; i < this.length; i++) {
                hintGrades.add(false);
              }
              for (int i = 0; i < this.length; i++) {
                hintCp.add(false);
              }
              if (index == 0) {
                return getHeader();
              }
              return _buildList(context, index);
            }),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 70.0,
        decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 20.0),
            ]),
        child: FlatButton(
          onPressed: _onPressed,
          child: Text(
            'Result',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  // Showing header
  getHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 20.0,
          ),
          Text(
            'Grades',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20.0),
          ),
          Text(
            'Credit Hour',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }

  // Building List of Credit hours and Grades
  _buildList(context, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Subject $index:',
            style: kSubjectColor,
          ),
          DropdownButton(
            underline: Container(
              color: Colors.white,
            ),
            iconEnabledColor: Colors.white,
            style: kSubjectColor,
            dropdownColor: kMainColor,
            hint: Text(
              'Grades $index',
              style: kSubjectColor,
            ),
            value: hintGrades[index] ? selectedItem[index] : null,
            items: ['A', 'A+', 'B', 'B+', 'C', 'C+', 'D', 'F']
                .map<DropdownMenuItem>((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: kSubjectColor,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedItem[index] = value;
                hintGrades[index] = true;
              });
            },
          ),
          DropdownButton<String>(
            value: hintCp[index] ? selectedCD[index] : null,
            dropdownColor: kMainColor,
            iconEnabledColor: Colors.white,
            hint: Text(
              'Credit Hour',
              style: kSubjectColor,
            ),
            items: ['1', '2', '3', '4', '5'].map((cp) {
              return DropdownMenuItem<String>(
                value: cp,
                child: Text(
                  cp,
                  style: kSubjectColor,
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCD[index] = value;

                hintCp[index] = true;
              });
            },
          ),
        ],
      ),
    );
  }

  _onPressed() {
    for (int i = 1; i < this.length + 1; i++) {
      double grade = widget.scale == 4
          ? unWeightedGrade(selectedItem[i])
          : weightedGrade(selectedItem[i]);
      double ch = double.parse(selectedCD[i]);
      double tempC = ch;
      total += (tempC * grade);
      totalCh += ch;
    }
    result = total / totalCh;
    // Validation for moving to next page
    for (var c in hintCp) {
      if (c) {
        safeI = true;
      }
    }
    for (var g in hintGrades) {
      if (g) {
        safeG = true;
      }
    }
    if (safeI && safeG) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => Result(
            result: result.toStringAsFixed(2),
            scale: widget.scale,
          ),
        ),
      );
    } else {
      alert();
    }
  }

  bool safeI = false;
  bool safeG = false;
  double result;
  double totalCh = 0.0;
  double total = 0.0;

  alert() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "No Field Should be Empty",
        style: kSubjectColor,
      ),
      backgroundColor: kMainColor.withOpacity(0.3),
      duration: Duration(seconds: 2),
    ));
  }
}
