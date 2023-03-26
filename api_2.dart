import 'dart:convert';
import 'package:api/api_3.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Api_2 extends StatefulWidget {
  const Api_2({Key? key}) : super(key: key);

  @override
  State<Api_2> createState() => _Api_2State();
}

class _Api_2State extends State<Api_2> {
  @override
  Widget build(BuildContext context) {
    List<Photos> photolist=[];
    Future<List<Photos>> getPhotos()async{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      var data = jsonDecode(response.body.toString());
      if(response.statusCode==200){
        for(Map i in data){
          Photos photos = Photos(title: i['title'], url: i['url'],id: i['id']);
          photolist.add(photos);
        }
        return photolist;
      }else{
        return photolist;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('api 2'),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Api_3()));
          },
              icon: Icon(Icons.arrow_forward_ios))
        ],
      ),
      body: FutureBuilder(
          future: getPhotos(),
          builder: (context,AsyncSnapshot<List<Photos>>snapshot){
        return ListView.builder(
            itemCount: photolist.length,
            itemBuilder: (context,index){
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
          ),
          title: Text(snapshot.data![index].id.toString()),
          subtitle: Text(snapshot.data![index].title.toString()),
        );
    });
      }),
    );
  }
}

class Photos{
  String title , url;
  int id;
  Photos({required this.title,required this.url,required this.id});
}
