part of 'screens.dart';

class splashScreenPage extends StatelessWidget {
  final String email;
  const splashScreenPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new SplashScreen(
      seconds: 6,
      navigateAfterSeconds:
          email == "" ? const welcomeScreen() : homeScreen(dataEmail: email),
      title: Text(email),
      photoSize: 150.0,
    );
  }
}
