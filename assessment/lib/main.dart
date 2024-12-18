
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: 
         Center(
           child: Row(mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ElevatedButton(
                  child: const Text('Dart'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondRoute()),
                    );
                  },
                   ),
               ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                             child: const Text('About internship'),
                             onPressed: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => const thirdroute()),
                               );
                             },
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                             child: const Text('Flutter'),
                             onPressed: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => const fourthroute()),
                               );
                             },
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                     child: const Text('Feedback'),
                     onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) =>  FifthRoute()),
                             );
                     },
                   ),
                 ),
                 
             ],
           ),
         )
      
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    var arrnames=['Function','Named Paramter','Arrow function','OOPSin Dart','Classes And Objects','Constructors','Inheritance','Polymorphism','Lists','APIS','MAPS','Dart Advanced'];
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ListView.separated(itemBuilder:(context, index) {
          return ListTile(
            leading: Text('${index+1}',style: TextStyle(fontSize:20,fontStyle: FontStyle.italic,color: Colors.black87,fontWeight: FontWeight.bold),),
            title: Text(arrnames[index],style: TextStyle(fontSize:20,fontStyle: FontStyle.italic,color: Colors.red,fontWeight: FontWeight.bold),),
            trailing: Icon(Icons.app_registration),
          
          );
        },
        itemCount:arrnames.length ,
         separatorBuilder: (BuildContext context, int index) {
          return Divider(height:20,thickness:1);

          },)
    )
    );
  }
}
class thirdroute extends StatelessWidget {
  const thirdroute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('third route'),
      ),
      body: Center(
        child: Container(
          height:double.infinity,
          width: double.infinity,
          
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 500,width: 500,
                    child:Image.asset("assets/images/WhatsApp Image 2023-11-06 at 17.20.01.jpeg")),
                  Container(height: 500,width: 500,child: Image.asset("assets/images/stock-photo-internship-written-on-notebook-concept.jpg")),
                  Container(height: 500,width: 500,child: Image.asset("assets/images/depositphotos_50400183-stock-photo-job-internship.webp"))
                ],
              ),
              Text("It was a decent internship."),
              Text("Got to learn a lot"),
              Text("Made new friends and learnt some basics of flutter."),
            ],
          ),
      
        ),
      )
    );
  }
}
class fourthroute extends StatelessWidget {
  const fourthroute({super.key});

  @override
  Widget build(BuildContext context) {
    var arrnames=['Installation','Adding container','Adding images','Padding','Columns And Rows','Stateful and Statless widgets','Uses Of Main.dart','Circle Avatar','Floating Action Button','Alert Message','Drawer Button','Adding Icons and Themes',' Adding Video Player'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('fourthroute'),
      ),
      body:
      Center(
        child: ListView.separated(itemBuilder:(context, index) {
          return ListTile(
            leading: Text('${index+1}',style: TextStyle(fontSize:20,fontStyle: FontStyle.italic,color: Colors.black87,fontWeight: FontWeight.bold),),
            title: Text(arrnames[index],style: TextStyle(fontSize:20,fontStyle: FontStyle.italic,color: Colors.red,fontWeight: FontWeight.bold),),
            trailing: Icon(Icons.app_registration),
            

          );
        },
        itemCount:arrnames.length ,
         separatorBuilder: (BuildContext context, int index) {
          return Divider(height:20,thickness:1);

          },)
    )
    );
  }
}
class FifthRoute extends StatefulWidget {
  @override
  _FifthRouteState createState() => _FifthRouteState();
}

class _FifthRouteState extends State<FifthRoute> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String selectedExperience = 'Good'; // Default experience value

  final List<String> experiences = ['Bad', 'Average', 'Good'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              value: selectedExperience,
              items: experiences.map((experience) {
                return DropdownMenuItem(
                  value: experience,
                  child: Text(experience),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedExperience = value!;
                });
              },
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: messageController,
              decoration: InputDecoration(labelText: 'Message'),
              maxLines: 4,
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the feedback submission here
                // You can access the input values using the controllers
                String fullName = nameController.text;
                String email = emailController.text;
                int age = int.tryParse(ageController.text) ?? 0;
                String phoneNumber = phoneController.text;
                String message = messageController.text;

                // Implement your logic to process the feedback data

                // For now, we just print the feedback data
                print('Overall Experience: $selectedExperience');
                print('Full Name: $fullName');
                print('E-mail: $email');
                print('Age: $age');
                print('Phone Number: $phoneNumber');
                print('Message: $message');
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}