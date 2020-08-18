import 'package:flutter/material.dart';
import 'package:mhsapp/service/sfService.dart';

import 'home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              color: Colors.white,
              child: FutureBuilder<Map<String, dynamic>>(
                future: SfService().getSavedlogin(),
                builder: (context, snapshot) => Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      child: Icon(Icons.verified_user)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      'Selamat datang ${snapshot.data['nama']}'),
                                ],
                              ),
                            ),
                            IconButton(icon: Icon(Icons.exit_to_app), onPressed: ()=>logOut())
                          ],
                        )),
                    Center(
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.all(20),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              child: Column(children: [
                                Row(children: [Text('Data anda :')]),
                                Row(children: [
                                  Expanded(
                                      child: Text(
                                          'email : ${snapshot.data['email']}'))
                                ]),
                                Row(children: [
                                  Expanded(
                                      child: Text(
                                          'fullname : ${snapshot.data['nama']} '))
                                ])
                              ]),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
  logOut()async{
     SfService().sfLogout();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
  }
}
