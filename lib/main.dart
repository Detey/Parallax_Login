import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _controller = ScrollController();

  double rateone = 0;
  double ratetwo = 0;
  double ratethree = 0;
  double ratefour = 0;

  String asset;
  double top;

  void _animateToIndex(double i) {
    _controller.animateTo(i, duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        _animateToIndex(400.0);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        // ignore: missing_return
        onNotification: (v) {
          if(v is ScrollUpdateNotification){
            setState(() {
              ratefour -= v.scrollDelta / 1;
              ratethree -= v.scrollDelta / 2;
              ratetwo -= v.scrollDelta / 3;
              rateone -= v.scrollDelta / 4;
            });
          }
        },
        child: Stack(
          children: [
            ParallaxWidget(top: rateone, asset: "img1"),
            ParallaxWidget(top: ratetwo, asset: "img2"),
            ParallaxWidget(top: ratethree, asset: "img3"),
            ParallaxWidget(top: ratefour, asset: "img4"),
            ListView(
              controller: _controller,
              children: [
                Container(
                  height: 400,
                  color: Colors.transparent,
                ),
                Container(
                  height: 600,
                  color: Color(0xff30122c),
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w900,
                            color: Colors.white
                        ),
                      ),
                      Text(
                        "Back!",
                        style: TextStyle(
                            fontSize: 90,
                            fontWeight: FontWeight.w900,
                            color: Colors.white
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 100,left: 20,right: 20
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.white
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(color: Colors.blueAccent)
                                  )
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Colors.white
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.white)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        borderSide: BorderSide(color: Colors.blueAccent)
                                    )
                                ),
                              ),
                            ),

                            Container(
                              height: 60,
                              width: 450,
                              margin: EdgeInsets.only(top: 25.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  "Login",style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key key,
    @required this.top,
    @required this.asset,
  }) : super(key: key);

  final double top;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: top,
      child: Container(
        height: 685,
        width: 415,
        child: Image.asset("assets/images/$asset.png",fit: BoxFit.fill,),
      ),
    );
  }
}

