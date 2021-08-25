import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:tesscase/helper/size.dart';

class PesanContactByName extends StatefulWidget {
  final List items;
  final String rules;
  PesanContactByName({
    Key key,
    @required this.items,
    @required this.rules,
  }) : super(key: key);

  @override
  _PesanContactByNameState createState() => _PesanContactByNameState();
}

class _PesanContactByNameState extends State<PesanContactByName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Message By Sender"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: GroupedListView<dynamic, String>(
        elements: widget.items,
        groupBy: (element) => widget.rules == "sender"
            ? element["from"]
            : DateFormat(
                "dd-MM-y",
              ).format(DateTime.fromMillisecondsSinceEpoch(
                int.parse(element["timestamp"]) * 1000)),
        groupSeparatorBuilder: (String groupByValue) => Padding(
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
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(
                AdaptiveSize.width(5),
              ),
            ),
            child: Text("From : " + groupByValue),
          ),
        ),
        itemBuilder: (context, dynamic element) => Builder(builder: (_) {
          if (element["attachment"] == "contact") {
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
                                "From " + element["from"],
                              ),
                              Text(
                                "To " + element["to"],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AdaptiveSize.height(10),
                          ),
                          Builder(builder: (_) {
                            if (element["body"] != null) {
                              return Text(
                                "Message : " + element["body"],
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
                            "Attachment : " + element["attachment"],
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
                                    int.parse(element["timestamp"]) * 1000)),
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
        // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
        // useStickyGroupSeparators: true, // optional
        // floatingHeader: true, // optional
        // order: GroupedListOrder.ASC, // optional
      ),
    );
  }
}
