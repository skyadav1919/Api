import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api_3 extends StatefulWidget {
  const Api_3({Key? key}) : super(key: key);

  @override
  State<Api_3> createState() => _Api_3State();
}

class _Api_3State extends State<Api_3> {
  List<Metals> metalslist = [];
  Future<List<Metals>> getMetals() async {
    final response = await http.get(Uri.parse(
        'https://12xbull.foundercodes.com/admin/api/Mobile_app/get_metel'));
    var data = jsonDecode(response.body.toString())['data'];
    print(data);
    print("skldfjlasdk");
    if (response.statusCode == 200) {
      for (var o in data) {
        Metals abcd = Metals(
          metel_type:  o["metel_type"],
          meteltypehindi: o["meteltypehindi"],
          metal_icon:  o["metal_icon"],
        );
        metalslist.add(abcd);
      }
      return metalslist;
    } else {
      return metalslist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text('Api 3'),
      ),
      body: FutureBuilder<List<Metals>>(
          future: getMetals(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage("https://12xbull.foundercodes.com/admin/uploads/"+snapshot.data![index].metal_icon.toString()),
                          ),
                          title: Center(child: Text(snapshot.data![index].metel_type.toString())),
                          subtitle: Center(child: Text(snapshot.data![index].meteltypehindi.toString())),
                        )
                      ],
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class Metals {
  String metel_type;
  String meteltypehindi;
  String metal_icon;

  Metals({
    required this.metel_type,
    required this.meteltypehindi,
    required this.metal_icon
  });
}
