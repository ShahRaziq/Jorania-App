import 'package:flutter/material.dart';
import 'package:Jorania/screen/service.dart';

class ListServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Senarai Servis'),
        ), // AppBar
        body: _buildListView(context),
      ); // Scaffold
}

ListView _buildListView(BuildContext context) {
  return ListView.builder(
    itemCount: 20,
    itemBuilder: (_, index) {
      return ListTile(
        title: Text('Servis item #$index'),
        subtitle: Text('masa: 8.00pg - 10.00mlm'),
        leading: Icon(Icons.store),
        trailing: Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => ServiceDetail(index))));
        },
      );
    },
  );
}
