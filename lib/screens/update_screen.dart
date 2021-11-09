part of 'screens.dart';

class updateScreen extends StatefulWidget {
  final String dataEdit;
  const updateScreen({Key? key, required this.dataEdit}) : super(key: key);

  @override
  _updateScreenState createState() => _updateScreenState();
}

class _updateScreenState extends State<updateScreen> {
  late Map<String, dynamic> dataNew;
  String email = "", password = "", role = "", name = "", image = "";
  int id = 0;
  final _controllerEmail = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerRole = TextEditingController();
  final _controllerImage = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataNew = json.decode(widget.dataEdit);
    id = dataNew['id'] ?? 0;
    email = dataNew['email'] ?? "";
    name = dataNew['name'] ?? "";
    role = dataNew['role'] ?? "";
    image = dataNew['image'] ?? "";

    _controllerEmail.text = dataNew['email'] ?? "";
    _controllerName.text = dataNew['name'] ?? "";
    _controllerRole.text = dataNew['role'] ?? "";
    _controllerImage.text = dataNew['image'] ?? "";
  }

  void update() async {
    var data = {
      'email': email,
      'password': password,
      'role': role,
      'name': name
    };
    var res = await Network().authData(data, '/update/' + id.toString());
    var body = json.decode(res.body);
    print(body);
    if (body['status'] == 1) {
      // Navigator.of(context).pushNamed('/home');
      final sp = await SharedPreferences.getInstance();
      String? emailUser = sp.getString('email');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => splashScreenPage(email: emailUser!)));
    } else {
      var pesanError = "";
      if (body['reason'] != null) {
        pesanError = body['reason'];
      } else {
        pesanError = "Gagal UPDATE";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(pesanError)));
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
                                Text('UDPATE DATA ',
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
                            style: TextStyle(color: Colors.white),
                            controller: _controllerEmail,
                            onChanged: (value) => email = value,
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
                        SizedBox(height: 20),

                        //FIELD NAMA
                        TextField(
                            style: TextStyle(color: Colors.white),
                            controller: _controllerName,
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
                        SizedBox(height: 20),

                        //FIELD PASSWORD
                        TextField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (value) => password = value,
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

                        //FIELD ROLE
                        TextField(
                            style: TextStyle(color: Colors.white),
                            controller: _controllerRole,
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
                        SizedBox(height: 20),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width -
                              2 * defaultMargin,
                          child: ElevatedButton(
                              onPressed: () => update(),
                              child: Text(
                                'UPDATE',
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
