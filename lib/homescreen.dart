import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Locale _currentLocale = Locale('en'); // Default language is English
  int _currentPage = 0;
  final List<String> _titles = [
  'Make money on TikTok with EthioTikTok',
  'Get Important Notifications on How to Make Money and Get Followers on TikTok Daily',
  'Promote Your Social Media Address to All App Users',
  'Discover More Funny Ethiopian TikTok Videos',
  'Post Your Business or Other Advertisements to All App Users',
];

final List<String> _descriptions = [
  'You can use your official TikTok account. No need to create a new account if you already have one. EthioTikTok is fast, easy, and uses less data.',
  'You will get important tips on how to make money on TikTok, how to get followers, how to make viral videos, daily TikTok updates, and more TikTok tips.',
  'You can promote your TikTok account and Telegram channel to all app users. This enables you to reach all users at once and increase your followers on social media.',
  'You will get your favorite videos based on your view history. Most videos are Ethiopian videos. Inappropriate videos will not be shown to you.',
  'You can promote your business by using https://ethiotiktok.abyssiniasoftware.com or by contacting @ethiotiktok1 or calling 0940637672 or 0951050364.',
];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 11),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.repeat(reverse: false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    setState(() {
      if (_currentPage < _titles.length - 1) {
        _currentPage++;
      }
    });
  }

  void _getStarted() {
    // Navigate to the main screen
    Navigator.pushReplacementNamed(context, '/main');
  }

  void _launchWebsite() async {
    String url = 'https://ethiotiktok.abyssiniasoftware.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 231, 14, 14).withOpacity(_animation.value),
                      Color.fromARGB(255, 32, 31, 31).withOpacity(_animation.value),
                      Color.fromARGB(255, 8, 31, 34).withOpacity(_animation.value),
                      Color.fromARGB(255, 6, 168, 218).withOpacity(_animation.value),
                    ],
                  ),
                ),
              );
            },
          ),
        Container(
  margin: EdgeInsets.symmetric(horizontal: 16),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _titles[_currentPage],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 10, 190, 64),
          ),
        ),
        SizedBox(height: 16),
        Text(
          _descriptions[_currentPage],
          style: const TextStyle(
            fontSize: 21,
            color: Color.fromARGB(255, 7, 160, 45)
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32),
        if (_currentPage < _titles.length - 1)
          ElevatedButton(
            onPressed: _nextPage,
            child: Text('Next'),

          )
        else
          ElevatedButton(
            onPressed: _getStarted,
            child: Text('Get Started'),
          ),
              InkWell(
        onTap: () => openTelegram('@ethiotiktok1'),
        child: Container(
          child: Text(
            'To post advertizment on the app Contact us @ethiotiktok1 0r call 0951050364',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 11, 171, 235),
            ),
          ),
        ),
      )
      ],
    ),
  ),
),


        ],
      ),
             bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey[200],
        child:    ElevatedButton(
                onPressed: _launchWebsite,
                child: Text('Post Advertizement on the app'),
              ),
      ),

    );
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
}