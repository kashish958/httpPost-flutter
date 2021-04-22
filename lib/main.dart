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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  Model user;

  Future <Model> createuser(String name, String jobtitle ) async{

    final String url = "https://reqres.in/api/users";
   final response =  await http.post(Uri.parse(url) ,
    body : {
"name" : name ,
      "job" :jobtitle

    }
    );
   if(response.statusCode ==201){
     return modelFromJson(response.body);

   }
   else{
     return null;
   }

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home:Scaffold(


          body :Container(

            padding: EdgeInsets.all(32),
            child :
              Column(
                children:  <Widget>[

                  TextField(


                 controller :nameController,

                   ),
                  TextField(
                    controller :jobController,



                  ),

              SizedBox(
                height: 30.0,
              )   ,
              if(user== null) Container()
else Text("The ${user.name} is created successfully at ${user.createdAt.toIso8601String()} with job id ${user.id}")

                ],

              )






        ),

        floatingActionButton: FloatingActionButton(

          onPressed: () async  {

            final String name = nameController.text;
            final String jobtitle = jobController.text;
         final Model m =  await createuser(name, jobtitle);

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