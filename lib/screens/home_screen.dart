// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use, prefer_const_constructors

part of 'screens.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  List data = List.empty();

  void delete(id) async {
    var res = await Network().authData(data, '/delete/' + id.toString());
    var body = json.decode(res.body);
    print(id);
    if (body['status'] == 1) {
      Navigator.of(context).pushNamed('/home');
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
        title: Text("Home",
            style: TextStyle(color: Color.fromRGBO(0, 103, 102, 1))),
        backgroundColor: Colors.white70,
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
                              CircleAvatar(
                                child: Text(
                                  data[index]["name"][0],
                                  style: TextStyle(fontSize: 30),
                                ),
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
    );
  }
}
