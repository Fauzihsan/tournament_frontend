part of 'screens.dart';

class modalRegister extends StatefulWidget {
  const modalRegister({Key? key}) : super(key: key);

  @override
  _modalRegisterState createState() => _modalRegisterState();
}

class _modalRegisterState extends State<modalRegister> {
  String emailDaftar = "",
      passwordDaftar = "",
      role = "",
      name = "",
      img64 = "";

  File foto = File("");

  TextEditingController emailController = TextEditingController();
  void register() async {
    var data = {
      'email': emailDaftar,
      'password': passwordDaftar,
      'role': role,
      'name': name,
      'image': img64,
    };

    var res = await Network().authData(data, '/register');
    var body = json.decode(res.body);

    print(body);
    if (body['status'] == 1) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text("Register Berhasil")));
      final sp = await SharedPreferences.getInstance();
      sp.setString('email', emailController.text.toString());

      String? emailUser = sp.getString('email');
      // Navigator.of(context).pushNamed('/home');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => splashScreenPage(email: emailUser!)));
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

  Future getImage(ImageSource media) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: media);

    setState(() {
      if (image != null) {
        foto = File(image.path);

        var extension = "";
        try {
          extension = path.extension(image.path).replaceAll('.', '');
        } catch (e) {
          extension = "jpg";
        }
        try {
          final bytes = IO.File(image.path).readAsBytesSync();
          img64 = "data:image/" + extension + ";base64," + base64Encode(bytes);
        } catch (e) {
          print(e);
        }

        // final bytes = IO.File(foto.path.split('/').last).readAsBytesSync();
        // img64 = base64Encode(foto.readAsBytesSync());
        // print(img64.substring(0, 100));
        print(img64);
        print(foto);
        print("HAI");
      } else {
        print('No image selected.');
      }
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

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
                          topLeft: Radius.circular(40))),
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
                        SizedBox(height: 20),
                        //FIELD EMAIL
                        TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) => emailDaftar = value,
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
                        SizedBox(height: 10),

                        //FIELD NAMA
                        TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) => name = value,
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
                                hintText: "Name",
                                labelText: "Name",
                                hintStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                  ),
                                ))),
                        SizedBox(height: 10),

                        //FIELD PASSWORD
                        TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) => passwordDaftar = value,
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
                        SizedBox(height: 10),

                        //FIELD ROLE
                        TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) => role = value,
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
                                hintText: "Role",
                                labelText: "Role",
                                hintStyle: TextStyle(color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.admin_panel_settings,
                                    color: Colors.white,
                                  ),
                                ))),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            MaterialButton(
                                color: Colors.red,
                                child: Text("UPLOAD IMAGE"),
                                onPressed: () => myAlert()),
                            Spacer(),
                            // foto == null
                            //     ? CircleAvatar(
                            //         radius: 30,
                            //       )
                            //     :
                            Container(
                              width: 200,
                              height: 200,
                              color: Colors.black26,
                              child: foto != null
                                  ? Image.file(
                                      foto,
                                      fit: BoxFit.fill,
                                    )
                                  : Text("Test"),
                            ),
                          ],
                        ),
                        Text(foto.path),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin,
                          child: ElevatedButton(
                              onPressed: () => register(),
                              child: Text(
                                'Register',
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
                            Text("Already have account? ",
                                style: secondaryTextStyle.copyWith(
                                    color: whiteColor, fontSize: 10)),
                            Text(
                              "Login",
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
