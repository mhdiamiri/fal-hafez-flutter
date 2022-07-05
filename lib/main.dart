import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fal_hafez/models/single_fal.dart';
import 'package:fal_hafez/database/data.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => HafezHome(),
      '/show': (context) => ShowFal(),
    },
  ));
}

class HafezHome extends StatelessWidget {
  double getScreenHeightExcludeSafeArea(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    return height - padding.top - padding.bottom;
  }

  TextStyle textStyle() {
    return TextStyle(
      color: Colors.black87,
      fontSize: 25,
      fontFamily: 'sans',
    );
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize =
        (2 * getScreenHeightExcludeSafeArea(context) / 3 - 20) / 6;
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text(
          "فال حافظ",
          style: TextStyle(
            color: Colors.blueGrey[100],
            fontSize: 25,
            fontFamily: 'sans',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 2 * getScreenHeightExcludeSafeArea(context) / 3 - 20,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: buttonSize,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/show');
                      },
                      child: Text(
                        'نمایش فال',
                        style: textStyle(),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: buttonSize,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/show');
                      },
                      child: Text(
                        'توسعه دهنده',
                        style: textStyle(),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: buttonSize,
                    child: ElevatedButton(
                      onPressed: () {
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      },
                      child: Text(
                        'خروج',
                        style: textStyle(),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class ShowFal extends StatefulWidget {
  const ShowFal({Key? key}) : super(key: key);

  @override
  _ShowFalState createState() => _ShowFalState();
}

class _ShowFalState extends State<ShowFal> {

  String text = '';
  String poem = '';
  bool isReady = false;

  TextStyle textStyle1() {
    return TextStyle(
      color: Colors.black,
      fontSize: 35,
      fontFamily: 'nastaliq',
    );
  }

    TextStyle textStyle() {
    return TextStyle(
      color: Colors.black,
      fontSize: 35,
      fontFamily: 'sans',
    );
  }

  Widget falText() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            poem,
            style: textStyle1(),
            textAlign: TextAlign.center,
          ),
        ),
        Divider(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            text,
            style: textStyle(),
            textAlign: TextAlign.center
          ),
        ),
      ],
    );
  }

  void getDataReady() async{
      Data data = Data();
      Fal model = await data.randomItem();
      setState(() {
        text = model.text;
        poem = model.poem;
        isReady = true;
      });

  }
  

  @override
  void initState() {
    super.initState();
    getDataReady();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text(
          "فال حافظ",
          style: TextStyle(
            color: Colors.blueGrey[100],
            fontSize: 25,
            fontFamily: 'sans',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child:
            Padding(padding: EdgeInsets.all(10), child: isReady ? falText() : CircularProgressIndicator()),
      ),
    );
  }
}
