import 'dart:developer';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';


void main()=>runApp(Myapp());

class Myapp extends StatefulWidget{

  State<StatefulWidget>createState ()
{
 return MyappState();
}

}
class MyappState extends State<Myapp>{

  TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  Model user;
  List data;
  var counter = 0; //to increment post request

  Future <Model> createuser(String name, String jobtitle ) async{
    String clear = ""; 

    final String url = "https://reqres.in/api/users";
    final response =  await http.post(Uri.parse(url) ,
    body : {
      "name" : name ,
      "job" :jobtitle
    }
    
    );
   if(response.statusCode ==201){
     this.nameController.text = clear;
     this.jobController.text = clear;
     return modelFromJson(response.body);
    
   }
   else{
     return null;
   }

   setState(() {
     var conv = json.decode(response.body);
     data = conv['results'];
   });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
          body :Container(
            padding: EdgeInsets.all(32),
            child :
              Column(
                children: [

                  TextField(


                 controller :nameController,

                   ),
                  TextField(
                    controller :jobController,



                  ),

              SizedBox(
                height: 30.0,
              )   ,
              if(user== null)
                Container()
              else 
                ListView.builder(

                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Card(
                          child: Container(
                              child: Text(data[index]['name']),

                              padding: const EdgeInsets.all(20.0)


                          ),
                        ),
                      ],
                    ),
                  )
                  );
                }
                ),

                // Container(
                //   child: Text("The ${user.name} is created successfully at ${user.createdAt.toIso8601String()} with job id ${user.id}"),
                  
                // ),
              
              ],

            )






        ),

        floatingActionButton: FloatingActionButton(

          onPressed: () async  {

            final String name = nameController.text;
            final String jobtitle = jobController.text;
            final Model m =  await createuser(name, jobtitle);
            counter++;
            setState(() {
              user = m;
            });
          },
          child: Icon(Icons.add),
        ),




      )

    );

  }

}