import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/logbook_provider.dart';
import '../widgets/log_item.dart';

class LogbookScreen extends StatelessWidget {
  static const routeName = '/logbook';
  @override
  Widget build(BuildContext context) {
    final logs = Provider.of<LogBookProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              alignment: AlignmentDirectional.topStart,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Divider(
                    thickness: 3.0,
                    color: Colors.black45,
                    indent: 55.0,
                  ),
                ),
                Text(
                  DateFormat("dd/MM").format(DateTime.now()),
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => LogItem(logs.items.values.toList()[i].id,
                  logs.items.values.toList()[i].title),
              itemCount: logs.medCount,
            ),
          ),
        ],
      ),
    );
  }
}
