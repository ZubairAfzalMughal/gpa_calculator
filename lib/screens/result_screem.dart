import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpa_calculator/constant.dart';
import 'package:gpa_calculator/screens/take_subject.dart';

class Result extends StatelessWidget {
  final String result;
  final int scale;
  Result({Key key, this.result, this.scale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/result.png'),
            Text(
              "Your GPA is ",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                "$result / $scale",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Best of Luck",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: 10.0,),
            FlatButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (_) => TakeSubjects()
                ), (route) => route == null);
              },
              color: Colors.white,
              child: Icon(
                Icons.exit_to_app,
                color: kMainColor,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
