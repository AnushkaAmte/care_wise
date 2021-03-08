import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/logbook_provider.dart';
import '../widgets/log_item.dart';

class LogbookScreen extends StatefulWidget {
  static const routeName = '/logbook';

  @override
  _LogbookScreenState createState() => _LogbookScreenState();
}

class _LogbookScreenState extends State<LogbookScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<LogBookProvider>(context, listen: false)
          .fetchAndSetLogItems();
      setState(() {
        _isLoading = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logs = Provider.of<LogBookProvider>(context);
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                    itemBuilder: (ctx, i) => LogItem(logs.items[i].id,
                        logs.items[i].title, logs.items[i].day),
                    itemCount: logs.medCount,
                  ),
                ),
              ],
            ),
    );
  }
}
