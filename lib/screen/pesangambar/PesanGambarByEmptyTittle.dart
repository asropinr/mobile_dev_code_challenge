import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tesscase/helper/size.dart';

class PesanGambarByEmptyTitle extends StatefulWidget {
  final List items;
  PesanGambarByEmptyTitle({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  _PesanGambarByEmptyTitleState createState() =>
      _PesanGambarByEmptyTitleState();
}

class _PesanGambarByEmptyTitleState extends State<PesanGambarByEmptyTitle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Message By Empty Tittle"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveSize.width(16),
              vertical: AdaptiveSize.height(12),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveSize.width(10),
                vertical: AdaptiveSize.height(8),
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(
                  AdaptiveSize.width(5),
                ),
              ),
              child: Text("Empty Tittle"),
            ),
          ),
          Column(
            children: List.generate(
              widget.items.length,
              (index) => Builder(builder: (_) {
                if (widget.items[index]["attachment"] == "image" &&
                    widget.items[index]["body"] == null) {
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
                                "Pesan Image",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "From " + widget.items[index]["from"],
                                    ),
                                    Text(
                                      "To " + widget.items[index]["to"],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AdaptiveSize.height(10),
                                ),
                                Builder(builder: (_) {
                                  if (widget.items[index]["body"] != null) {
                                    return Text(
                                      "Message : " +
                                          widget.items[index]["body"],
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
                                  "Attachment : " +
                                      widget.items[index]["attachment"],
                                ),
                                SizedBox(
                                  height: AdaptiveSize.height(10),
                                ),
                                //_items[index]["timestamp"]
                                Text(
                                  "Timestamp : " +
                                      DateFormat(
                                        "dd-MM-y",
                                      ).format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(widget.items[index]
                                                      ["timestamp"]) *
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveSize.width(16),
              vertical: AdaptiveSize.height(12),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveSize.width(10),
                vertical: AdaptiveSize.height(8),
              ),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(
                  AdaptiveSize.width(5),
                ),
              ),
              child: Text("Not Empty Tittle"),
            ),
          ),
          Column(
            children: List.generate(
              widget.items.length,
              (index) => Builder(builder: (_) {
                if (widget.items[index]["attachment"] == "image" &&
                    widget.items[index]["body"] != null) {
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
                                "Pesan Image",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "From " + widget.items[index]["from"],
                                    ),
                                    Text(
                                      "To " + widget.items[index]["to"],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AdaptiveSize.height(10),
                                ),
                                Builder(builder: (_) {
                                  if (widget.items[index]["body"] != null) {
                                    return Text(
                                      "Message : " +
                                          widget.items[index]["body"],
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
                                  "Attachment : " +
                                      widget.items[index]["attachment"],
                                ),
                                SizedBox(
                                  height: AdaptiveSize.height(10),
                                ),
                                //_items[index]["timestamp"]
                                Text(
                                  "Timestamp : " +
                                      DateFormat(
                                        "dd-MM-y",
                                      ).format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(widget.items[index]
                                                      ["timestamp"]) *
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
          ),
        ],
      ),
    );
  }
}
