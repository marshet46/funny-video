
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'homescreen.dart';
import 'splashscreen.dart';
import 'webview.dart';
  List<int> intervals = [30, 60, 65, 75,85];
Random random = Random();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setAppId("<YOUR_ONESIGNAL_APP_ID>");
  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    event.complete(event.notification);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EthioTikTok',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  String responseText = '';


int randomIndex = random.nextInt(intervals.length);
  @override
 void initState() {
  super.initState();
  Timer.periodic(Duration(minutes: intervals[random.nextInt(intervals.length)]), (timer) {
    fetchAPIResponse();
  });
}


  Future<void> fetchAPIResponse() async {
    final response = await http.get(Uri.parse('https://ethiotiktok.abyssiniasoftware.com/posts'));
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
       final title =data['title'];
      final website = data['website'];
      final telegram = data['telegram'];
      setState(() {
        responseText = title;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                          Container(
                           margin: EdgeInsets.only(bottom: 10),
                            child:  Text(
                                'Description: ${data['description']}',
                                style: TextStyle(
                                  fontSize: 16, // Set the font size
                                  fontWeight: FontWeight.bold, // Set the font weight
                                  color: Colors.black, // Set the text color
                                ),
                              ),

                              ),
                              Container(
                           margin: EdgeInsets.only(bottom: 10),
                            child:  Text(
                                'Address: ${data['address']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 11, 195, 219),
                                ),
                              ),
                              ),
                                 Container(
                           margin: EdgeInsets.only(bottom: 10),
                            child:  Text(
                                'Phone: ${data['phone']}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Color.fromARGB(255, 231, 34, 34),
                                ),
                              ),
                                 ),
                                 InkWell(
                          onTap: () => openTelegram(telegram),
                          child: Text(
                            'Join Us'+telegram,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        )
                            ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(fontSize: 16),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          launch(website);
                        },
                        child: Text('View More'),
                      ),
                    ),

                     Container(
                          margin: EdgeInsets.all(8),
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 238, 33, 67)),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                const TextStyle(fontSize: 16),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                              ),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
void openTelegram(String username) async {
  final url = 'https://t.me/$username';
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
    routes: {
  '/': (context) => SplashScreen(),
  '/home': (context) => HomeScreen(),
  '/main': (context) => WebviewTwo(url: 'https://www.tiktok.com/',),

},
    );
  }
}


