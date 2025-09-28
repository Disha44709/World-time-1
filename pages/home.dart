import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    final routeargs = ModalRoute.of(context)?.settings.arguments;
    if (routeargs!=null && routeargs is Map){
      data = routeargs;
    }
    print(data);

    //set background
    String bgimage = data['isdaytime'] ?? true ? 'daytime.jpg' :'night.jpg';
    Color bgcolor = data['isdaytime'] ?? true ? Colors.lightBlue : Colors.indigo[700]!;


    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/$bgimage'),
                  fit: BoxFit.cover,
                )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time' : result['time'],
                          'location': result['location'],
                          'isdaytime': result['isdaytime'],
                          'flag': result['flag']
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],

                    ),
                    label: Text('edit location',
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'] ?? 'Unknown Location',
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Center(
                    child: Text(
                      data['time'] ?? 'Unknown Time',
                      style: TextStyle(
                        fontSize: 66.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

      ),

    );
  }
}