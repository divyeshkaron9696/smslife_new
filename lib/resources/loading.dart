import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: new BoxDecoration(
        color: Colors.black.withOpacity(0.45),
      ),
      child: Card(
        elevation: 10.0,
        color: Colors.black.withOpacity(0.70),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: new Container(
          width: 150.0,
          height: 120.0,
          alignment: AlignmentDirectional.center,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: new CircularProgressIndicator(
                    value: null,
                    strokeWidth: 4.0,
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: new Center(
                  child: new Text(
                    "Please Wait...",
                    style: TextStyle(color: Colors.white,fontSize: 16
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
