import 'dart:convert';

import 'package:api/Models/PostModels.dart';
import 'package:api/api_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Api_1 extends StatefulWidget {
  const Api_1({Key? key}) : super(key: key);

  @override
  State<Api_1> createState() => _Api_1State();
}

class _Api_1State extends State<Api_1> {
  List<PostModels> postList=[];
  Future<List<PostModels>> getPostApi()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        postList.add(PostModels.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('api 1'),
      centerTitle: true,
      actions: [
        IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Api_2()));
        },
            icon: Icon(Icons.arrow_forward_ios))
      ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }else{
                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context,index){
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title\n'+postList[index].title.toString()),
                            Text('Body\n'+postList[index].body.toString()),
                          ],
                        ),
                      );
                    });
                  }
            }),
          )
        ],
      )
    );
  }
}
