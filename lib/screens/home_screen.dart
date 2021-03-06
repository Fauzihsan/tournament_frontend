// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use, prefer_const_constructors

part of 'screens.dart';

class homeScreen extends StatefulWidget {
  final String dataEmail;
  const homeScreen({Key? key, required this.dataEmail}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List data = List.empty();

  final String _url =
      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg';

  Future logout() async {
    WidgetsFlutterBinding.ensureInitialized();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final sp = await _prefs;
    await sp.clear();
    Fluttertoast.showToast(
        msg: "BERHASIL LOGOUT",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

    Navigator.of(context).pushNamed('/');
  }

  void delete(id) async {
    var res = await Network().deleteData('/delete/' + id.toString());
    var body = json.decode(res.body);
    print(id);
    if (body['status'] == 1) {
      final sp = await SharedPreferences.getInstance();
      String? emailUser = sp.getString('email');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => splashScreenPage(email: emailUser!)));
    } else {
      var pesanError = "";
      if (body['reason'] != null) {
        pesanError = body['reason'];
      } else {
        pesanError = "Gagal DELETE";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(pesanError)));
    }
  }

  Future<String> getData() async {
    var res = await Network().getData('/showAll');
    var body = json.decode(res.body);

    if (body['status'] == 1) {
      print(body['data']);
      setState(() {
        data = body['data'];
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Gagal mengambil data")));
    }
    return "";
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromRGBO(0, 103, 102, 1),
        title: Text(widget.dataEmail,
            style: TextStyle(color: Color.fromRGBO(0, 103, 102, 1))),
        backgroundColor: Colors.white70,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
          MaterialButton(
              color: Colors.red,
              child: Text("LOGOUT"),
              onPressed: () => logout()),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(0, 103, 102, 1),
              Colors.green.shade600,
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: data.isEmpty ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
                child: Container(
                  // ignore: unnecessary_new
                  decoration: new BoxDecoration(
                    boxShadow: [
                      // ignore: unnecessary_new
                      new BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // CircleAvatar(
                              //   child: Image.network(
                              //       "http://192.168.100.190:8000/api/image",
                              //       fit: BoxFit.cover),
                              //   radius: 30,
                              // ),
                              CircleAvatar(
                                child: Image.network(
                                    "http://localhost:8000/api/image/",
                                    // "http://192.168.100.190:8000/api/image/",
                                    fit: BoxFit.cover),
                                radius: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index]["name"],
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(data[index]["email"]),
                                    Text(data[index]["role"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                // onPressed: () async {
                                //   int id = data[index]["id"];
                                //   var res = await Network().authData(
                                //       data, '/delete/' + id.toString());
                                //   var body = json.decode(res.body);
                                //   print(body);
                                //   if (body['status'] == 1) {
                                //     Navigator.of(context).pushNamed('/home');
                                //     print("sukses");
                                //   } else {
                                //     var pesanError = "";
                                //     if (body['reason'] != null) {
                                //       pesanError = body['reason'];
                                //     } else {
                                //       pesanError = "Gagal DELETE";
                                //     }
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(pesanError)));
                                //   }
                                // },
                                onPressed: () {
                                  delete(data[index]["id"]);
                                },
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                color: Colors.red,
                                shape: CircleBorder(),
                              ),
                              FlatButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return updateScreen(
                                            dataEdit: jsonEncode(data[index]));
                                      });
                                },
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.create_rounded,
                                  color: Colors.white,
                                ),
                                color: Colors.blue,
                                shape: CircleBorder(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ),
      ),
      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.all(10),
      //     children: [
      //       const DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //         ),
      //         child: Text('Welcome'),
      //       ),
      //       ListTile(
      //         title: const Text('Pengaturan'),
      //         onTap: () {
      //           // Update the state of the app
      //           // ...
      //           // Then close the drawer
      //           Navigator.pop(context);
      //         },
      //       ),
      //       MaterialButton(
      //           color: Colors.red,
      //           child: Text("LOGOUT"),
      //           onPressed: () => logout()),
      //     ],
      //   ),
      // ),
      drawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('Admin'),
                accountEmail: Text(widget.dataEmail),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    "U",
                    style: TextStyle(fontSize: 30),
                  ),
                  radius: 30,
                ),
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Item 1'),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                  color: Colors.red,
                  child: Text("LOGOUT"),
                  onPressed: () => logout()),
              Divider(
                height: 2.0,
              ),
            ],
          )),
    );
  }
}
