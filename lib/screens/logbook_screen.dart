import 'package:flutter/material.dart';
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
