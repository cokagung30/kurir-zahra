part of 'pages.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  UserLocalTable userLocalTable = UserLocalTable();

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    User? user = await userLocalTable.getUser();
    return Timer(duration, () {
      if (user == null) {
        Get.off(() => LoginPage());
      } else {
        Get.off(() => MainPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/kurir.png'),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Kurir Zahra',
              style: blackFontStyle3.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
