part of 'screens.dart';

class modalLogin extends StatefulWidget {
  const modalLogin({Key? key}) : super(key: key);

  @override
  _modalLoginState createState() => _modalLoginState();
}

class _modalLoginState extends State<modalLogin> {
  String email = "", password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future login() async {
    var data = {'email': email, 'password': password};
    print(data);
    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    print(body);
    if (body['status'] == 1) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Login Berhasil")));
      final sp = await SharedPreferences.getInstance();
      sp.setString('email', emailController.text.toString());

      String? emailUser = sp.getString('email');
      // Navigator.of(context).pushNamed('/');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => splashScreenPage(email: emailUser!)));
    } else {
      var pesanError = "";
      if (body['reason'] != null) {
        pesanError = body['reason'];
      } else {
        pesanError = "Gagal Login";
      }
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(pesanError)));
      Fluttertoast.showToast(
          msg: pesanError,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  bool _isObscure = true;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Wrap(
            children: [
              Container(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 103, 102, 1),
                        Colors.teal.shade800,
                        Colors.tealAccent.shade700,
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Welcome Back...',
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('LOGIN ',
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Spacer(),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  'assets/images/closeBtn.png',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 25),
                        //FIELD EMAIL
                        TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            onChanged: (value) => email = value,
                            decoration: InputDecoration(
                                focusColor: Colors.white,
                                hoverColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(0, 143, 142, 1),
                                      width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Email",
                                labelText: "Email",
                                hintStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                  ),
                                ))),
                        SizedBox(height: 20),
                        //FIELD PASSWORD
                        TextField(
                            controller: passController,
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) => password = value,
                            obscureText: _isObscure,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(0, 143, 142, 1),
                                      width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Password",
                                labelText: "Password",
                                hintStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ))),
                        SizedBox(height: 20),

                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Color(0xFFD7D7D7),
                                  border:
                                      Border.all(color: primaryColor, width: 3),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Checkbox(
                                value: _isChecked,
                                checkColor: Color(0xFFD7D7D7),
                                onChanged: (value) {
                                  setState(() {
                                    this._isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Text("Remember Me",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            Spacer(),
                            Text("Forgot Password",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ],
                        ),

                        SizedBox(height: 20),

                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin,
                          child: ElevatedButton(
                              onPressed: () => login(),
                              child: Text(
                                'Login',
                                style: secondaryTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
                                      borderRadius:
                                          BorderRadius.circular(15)))),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ",
                                style: secondaryTextStyle.copyWith(
                                    color: whiteColor, fontSize: 10)),
                            Text(
                              "Register",
                              style: secondaryTextStyle.copyWith(
                                  color: whiteColor,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            )
                          ],
                        ),
                        SizedBox(height: defaultMargin)
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
