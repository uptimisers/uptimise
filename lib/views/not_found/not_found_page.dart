import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: const [
          Expanded(
            child: Image(
              image: AssetImage('images/error404_pgNotFound.gif'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'Error 404',
              style: TextStyle(
                  fontSize: 35, fontFamily: 'NotoMono', color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(67),
            child: Text(
              'Page not found',
              style: TextStyle(fontSize: 35, fontFamily: 'NotoMono'),
            ),
          )
        ],
      )),
    );
  }
}
