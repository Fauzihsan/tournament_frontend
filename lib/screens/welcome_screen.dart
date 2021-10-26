// ignore_for_file: prefer_const_constructors

part of 'screens.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  String email = "", password = "";

  void login() async {
    var data = {'email': email, 'password': password};
    print(data);
    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    print(body);
    if (body['status'] == 1) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Login Berhasil")));
      Navigator.of(context).pushNamed('/home');
    } else {
      var pesanError = "";
      if (body['reason'] != null) {
        pesanError = body['reason'];
      } else {
        pesanError = "Gagal Login";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(pesanError)));
    }
  }

  String emailDaftar = "", passwordDaftar = "", role = "", name = "";

  void register() async {
    var data = {
      'email': emailDaftar,
      'password': passwordDaftar,
      'role': role,
      'name': name,
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);

    print(body);
    if (body['status'] == 1) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Register Berhasil")));
      Navigator.of(context).pushNamed('/menu');
    } else {
      var pesanError = "";
      if (body['reason'] != null) {
        // pesanError = body['reason'][0];
        pesanError = body['reason'];
      } else {
        pesanError = "Gagal Register";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(pesanError)));
    }
  }

  bool _isObscure = true;
  bool _isChecked = false;
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
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
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
                                              topLeft: Radius.circular(40))),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: defaultMargin),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Hello... ',
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 20,
                                                        )),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text('REGISTER ',
                                                        style: TextStyle(
                                                            color: whiteColor,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                                onChanged: (value) =>
                                                    emailDaftar = value,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              0, 143, 142, 1),
                                                          width: 2.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 2.0),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    hintText: "Email",
                                                    labelText: "Email",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                    suffixIcon: InkWell(
                                                      onTap: () {},
                                                      child: Icon(
                                                        Icons.email_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    ))),
                                            SizedBox(height: 20),

                                            //FIELD NAMA
                                            TextField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                onChanged: (value) =>
                                                    name = value,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              0, 143, 142, 1),
                                                          width: 2.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 2.0),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    hintText: "Name",
                                                    labelText: "Name",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                    suffixIcon: InkWell(
                                                      onTap: () {},
                                                      child: Icon(
                                                        Icons.account_circle,
                                                        color: Colors.white,
                                                      ),
                                                    ))),
                                            SizedBox(height: 20),

                                            //FIELD PASSWORD
                                            TextField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                onChanged: (value) =>
                                                    passwordDaftar = value,
                                                obscureText: _isObscure,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              0, 143, 142, 1),
                                                          width: 2.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 2.0),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    hintText: "Password",
                                                    labelText: "Password",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        _isObscure
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscure =
                                                              !_isObscure;
                                                        });
                                                      },
                                                    ))),
                                            SizedBox(height: 20),

                                            //FIELD ROLE
                                            TextField(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                onChanged: (value) =>
                                                    role = value,
                                                decoration: InputDecoration(
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              0, 143, 142, 1),
                                                          width: 2.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 2.0),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    hintText: "Role",
                                                    labelText: "Role",
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                    suffixIcon: InkWell(
                                                      onTap: () {},
                                                      child: Icon(
                                                        Icons
                                                            .admin_panel_settings,
                                                        color: Colors.white,
                                                      ),
                                                    ))),
                                            SizedBox(height: 20),
                                            Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  2 * defaultMargin,
                                              child: ElevatedButton(
                                                  onPressed: () => register(),
                                                  child: Text(
                                                    'Register',
                                                    style: secondaryTextStyle
                                                        .copyWith(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors
                                                          .transparent,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)))),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Already have account? ",
                                                    style: secondaryTextStyle
                                                        .copyWith(
                                                            color: whiteColor,
                                                            fontSize: 10)),
                                                Text(
                                                  "Login",
                                                  style: secondaryTextStyle
                                                      .copyWith(
                                                          color: whiteColor,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                          );
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
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: defaultMargin),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
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
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  cursorColor: Colors.white,
                                                  onChanged: (value) =>
                                                      email = value,
                                                  decoration: InputDecoration(
                                                      focusColor: Colors.white,
                                                      hoverColor: Colors.white,
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    143,
                                                                    142,
                                                                    1),
                                                            width: 2.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 2.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hintText: "Email",
                                                      labelText: "Email",
                                                      hintStyle: TextStyle(
                                                          color: Colors.white),
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
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
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  onChanged: (value) =>
                                                      password = value,
                                                  obscureText: _isObscure,
                                                  decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    0,
                                                                    143,
                                                                    142,
                                                                    1),
                                                            width: 2.0),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.white,
                                                            width: 2.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hintText: "Password",
                                                      labelText: "Password",
                                                      hintStyle: TextStyle(
                                                          color: Colors.white),
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      suffixIcon: IconButton(
                                                        icon: Icon(
                                                          _isObscure
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            _isObscure =
                                                                !_isObscure;
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
                                                        color:
                                                            Color(0xFFD7D7D7),
                                                        border: Border.all(
                                                            color: primaryColor,
                                                            width: 3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Checkbox(
                                                      value: _isChecked,
                                                      checkColor:
                                                          Color(0xFFD7D7D7),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          this._isChecked =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text("Remember Me",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12)),
                                                  Spacer(),
                                                  Text("Forgot Password",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12)),
                                                ],
                                              ),

                                              SizedBox(height: 20),

                                              Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    2 * defaultMargin,
                                                child: ElevatedButton(
                                                    onPressed: () => login(),
                                                    child: Text(
                                                      'Login',
                                                      style: secondaryTextStyle
                                                          .copyWith(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                        primary:
                                                            Colors.transparent,
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)))),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "Don't have an account? ",
                                                      style: secondaryTextStyle
                                                          .copyWith(
                                                              color: whiteColor,
                                                              fontSize: 10)),
                                                  Text(
                                                    "Register",
                                                    style: secondaryTextStyle
                                                        .copyWith(
                                                            color: whiteColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                            );
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
