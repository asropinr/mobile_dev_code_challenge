import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tesscase/helper/size.dart';
import 'package:tesscase/screen/pesancontact/PesanContactByName.dart';
import 'package:tesscase/screen/pesangambar/PesanGambarByEmptyTittle.dart';
import 'package:tesscase/screen/pesangambar/PesanGambarByName.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];
  // List pesanTeks = [];
  // List teks = [];
  int selectButton = 0;

  List bar = [
    {
      "name": "Semua",
      "id": 0,
    },
    {
      "name": "Pesan Teks",
      "id": 1,
    },
    {
      "name": "Pesan Gambar",
      "id": 2,
    },
    {
      "name": "Pesan Doc",
      "id": 3,
    },
    {
      "name": "Pesan Con",
      "id": 4,
    },
  ];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/massage_dataset.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["data"];
    });

    _items.sort((a, b) {
      return a["timestamp"].toString().compareTo(b["timestamp"].toString());
    });
    print(_items);
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Aplication"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: AdaptiveSize.height(20)),
        children: [
          SizedBox(
            height: AdaptiveSize.height(20),
          ),
          Row(
            children: List.generate(
                bar.length,
                (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectButton = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: AdaptiveSize.width(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveSize.width(8),
                          vertical: AdaptiveSize.height(14),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(AdaptiveSize.width(10))),
                          border: Border.all(
                            color: selectButton == index
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            bar[index]["name"],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: selectButton == index
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )),
          ),
          SizedBox(
            height: AdaptiveSize.height(20),
          ),
          Builder(builder: (_) {
            if (selectButton == 1) {
              return PesanTeks(data: _items);
            } else if (selectButton == 2) {
              return PesanGambar(data: _items);
            } else if (selectButton == 3) {
              return PesanDoc(data: _items);
            } else if (selectButton == 4) {
              return PesanContact(data: _items);
            } else {
              return AllPesan(data: _items);
            }
          })
        ],
      ),
    );
  }
}

class PesanTeks extends StatefulWidget {
  final List data;
  PesanTeks({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _PesanTeksState createState() => _PesanTeksState();
}

class _PesanTeksState extends State<PesanTeks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.data.length,
        (index) => Builder(builder: (_) {
          if (widget.data[index]["attachment"] == null) {
            return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AdaptiveSize.width(16),
                    vertical: AdaptiveSize.height(5)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AdaptiveSize.width(5),
                    ),
                    border: Border.all(color: Colors.grey[300])),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 12,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                            topLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveSize.width(12),
                          vertical: AdaptiveSize.height(8),
                        ),
                        child: Text(
                          "Pesan Teks",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AdaptiveSize.width(16),
                        vertical: AdaptiveSize.height(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "From " + widget.data[index]["from"],
                              ),
                              Text(
                                "To " + widget.data[index]["to"],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AdaptiveSize.height(10),
                          ),
                          Builder(builder: (_) {
                            if (widget.data[index]["body"] != null) {
                              return Text(
                                "Message : " + widget.data[index]["body"],
                              );
                            } else {
                              return Text(
                                "Message : -",
                              );
                            }
                          }),
                          SizedBox(
                            height: AdaptiveSize.height(10),
                          ),
                          // Builder(builder: (_) {
                          //   if (_items[index]["attachment"] !=
                          //       null) {
                          //     return Text(
                          //       "Attachment : " +
                          //           _items[index]["attachment"],
                          //     );
                          //   } else {
                          //     return Text(
                          //       "Attachment : -",
                          //     );
                          //   }
                          // }),
                          // SizedBox(
                          //   height: AdaptiveSize.height(10),
                          // ),
                          //_items[index]["timestamp"]
                          Text(
                            "Timestamp : " +
                                DateFormat(
                                  "dd-MM-y",
                                ).format(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(widget.data[index]["timestamp"]) *
                                        1000)),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class PesanGambar extends StatefulWidget {
  final List data;
  PesanGambar({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _PesanGambarState createState() => _PesanGambarState();
}

class _PesanGambarState extends State<PesanGambar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PesanGambarByName(
                rules: "sender",
                items: widget.data,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: AdaptiveSize.width(16),
              vertical: AdaptiveSize.height(12),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(
                AdaptiveSize.width(5),
              ),
            ),
            height: AdaptiveSize.height(50),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("Group By Sender"),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PesanGambarByName(
                rules: "date",
                items: widget.data,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: AdaptiveSize.width(16),
              vertical: AdaptiveSize.height(12),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(
                AdaptiveSize.width(5),
              ),
            ),
            height: AdaptiveSize.height(50),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("Group By Date"),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PesanGambarByEmptyTitle(
                items: widget.data,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: AdaptiveSize.width(16),
              vertical: AdaptiveSize.height(12),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(
                AdaptiveSize.width(5),
              ),
            ),
            height: AdaptiveSize.height(50),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("Group By Empty Title"),
            ),
          ),
        )
      ],
    );
  }
}

class PesanDoc extends StatefulWidget {
  final List data;
  PesanDoc({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _PesanDocState createState() => _PesanDocState();
}

class _PesanDocState extends State<PesanDoc> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.data.length,
        (index) => Builder(builder: (_) {
          if (widget.data[index]["attachment"] == "document") {
            return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AdaptiveSize.width(16),
                    vertical: AdaptiveSize.height(5)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AdaptiveSize.width(5),
                    ),
                    border: Border.all(color: Colors.grey[300])),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 12,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                            topLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveSize.width(12),
                          vertical: AdaptiveSize.height(8),
                        ),
                        child: Text(
                          "Pesan Document",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AdaptiveSize.width(16),
                        vertical: AdaptiveSize.height(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "From " + widget.data[index]["from"],
                              ),
                              Text(
                                "To " + widget.data[index]["to"],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AdaptiveSize.height(10),
                          ),
                          Builder(builder: (_) {
                            if (widget.data[index]["body"] != null) {
                              return Text(
                                "Message : " + widget.data[index]["body"],
                              );
                            } else {
                              return Text(
                                "Message : -",
                              );
                            }
                          }),
                          SizedBox(
                            height: AdaptiveSize.height(10),
                          ),
                          Text(
                            "Attachment : " + widget.data[index]["attachment"],
                          ),
                          SizedBox(
                            height: AdaptiveSize.height(10),
                          ),
                          //_items[index]["timestamp"]
                          Text(
                            "Timestamp : " +
                                DateFormat(
                                  "dd-MM-y",
                                ).format(DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(widget.data[index]["timestamp"]) *
                                        1000)),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class PesanContact extends StatefulWidget {
  final List data;
  PesanContact({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _PesanContactState createState() => _PesanContactState();
}

class _PesanContactState extends State<PesanContact> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PesanContactByName(
                rules: "sender",
                items: widget.data,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: AdaptiveSize.width(16),
              vertical: AdaptiveSize.height(12),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(
                AdaptiveSize.width(5),
              ),
            ),
            height: AdaptiveSize.height(50),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("Group By Sender"),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PesanContactByName(
                rules: "date",
                items: widget.data,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: AdaptiveSize.width(16),
              vertical: AdaptiveSize.height(12),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(
                AdaptiveSize.width(5),
              ),
            ),
            height: AdaptiveSize.height(50),
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("Group By Date"),
            ),
          ),
        ),
      ],
    );
  }
}

class AllPesan extends StatefulWidget {
  final List data;
  AllPesan({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _AllPesanState createState() => _AllPesanState();
}

class _AllPesanState extends State<AllPesan> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        widget.data.length,
        (index) => Container(
            margin: EdgeInsets.symmetric(
                horizontal: AdaptiveSize.width(16),
                vertical: AdaptiveSize.height(5)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AdaptiveSize.width(5),
                ),
                border: Border.all(color: Colors.grey[300])),
            child: Stack(
              children: [
                Positioned(
                  bottom: 12,
                  right: 0,
                  child: Builder(builder: (_) {
                    if (widget.data[index]["attachment"] == null) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                            topLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveSize.width(12),
                          vertical: AdaptiveSize.height(8),
                        ),
                        child: Text(
                          "Pesan Teks",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (widget.data[index]["attachment"] == "image") {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                            topLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveSize.width(12),
                          vertical: AdaptiveSize.height(8),
                        ),
                        child: Text(
                          "Pesan Gambar",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (widget.data[index]["attachment"] == "contact") {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                            topLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveSize.width(12),
                          vertical: AdaptiveSize.height(8),
                        ),
                        child: Text(
                          "Pesan Contact",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                            topLeft: Radius.circular(
                              AdaptiveSize.width(5),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveSize.width(12),
                          vertical: AdaptiveSize.height(8),
                        ),
                        child: Text(
                          "Pesan Document",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  }),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AdaptiveSize.width(16),
                    vertical: AdaptiveSize.height(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "From " + widget.data[index]["from"],
                          ),
                          Text(
                            "To " + widget.data[index]["to"],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AdaptiveSize.height(10),
                      ),
                      Builder(builder: (_) {
                        if (widget.data[index]["body"] != null) {
                          return Text(
                            "Message : " + widget.data[index]["body"],
                          );
                        } else {
                          return Text(
                            "Message : -",
                          );
                        }
                      }),
                      SizedBox(
                        height: AdaptiveSize.height(10),
                      ),
                      Builder(builder: (_) {
                        if (widget.data[index]["attachment"] != null) {
                          return Text(
                            "Attachment : " + widget.data[index]["attachment"],
                          );
                        } else {
                          return Text(
                            "Attachment : -",
                          );
                        }
                      }),
                      SizedBox(
                        height: AdaptiveSize.height(10),
                      ),
                      //_items[index]["timestamp"]
                      Text(
                        "Timestamp : " +
                            DateFormat(
                              "dd-MM-y",
                            ).format(DateTime.fromMillisecondsSinceEpoch(
                                int.parse(widget.data[index]["timestamp"]) *
                                    1000)),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
