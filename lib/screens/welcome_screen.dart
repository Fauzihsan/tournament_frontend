// ignore_for_file: prefer_const_constructors

part of 'screens.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: [
              Image.asset(
                'assets/images/dashboard.png',
                height: 333,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "WELCOME",
                style: TextStyle(
                  color: Color.fromRGBO(0, 103, 102, 1),
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Hello, welcome to the Tournament Application, please use this application wisely.\nThank you",
                style: secondaryTextStyle.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return modalRegister();
                        });
                  },
                  child: Text(
                    'Create Account',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: whiteColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(0, 103, 102, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return modalLogin();
                          });
                    },
                    child: Text(
                      'Login',
                      style: secondaryTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 103, 102, 1)),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: whiteColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color.fromRGBO(0, 103, 102, 1),
                                width: 2),
                            borderRadius: BorderRadius.circular(15)))),
              ),
              SizedBox(
                height: 36,
              ),
              Row(
                children: [
                  Text(
                    '© Created by ',
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                  Text(
                    '~enthusiastic~',
                    style: secondaryTextStyle.copyWith(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' 2021',
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: defaultMargin,
              ),
            ],
          ),
        ));
  }
}
