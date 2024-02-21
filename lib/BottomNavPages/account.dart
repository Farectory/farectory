import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child:  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.black, Color.fromARGB(255, 45, 51, 228),Colors.blue, Color.fromARGB(255, 45, 51, 228)])),
          child: Column(
            children: [
              SizedBox(height: 30,),
              SizedBox(height: 250,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('images/farectory_trans_icon.png',
                      height: 60,
                      color: Colors.white,
                      ),
                      Row(
                        children: [
                          TextButton(
                        onPressed: () {}, 
                        child: Icon(Icons.settings_overscan,
                        color: Colors.white,
                        size: 37,)),
                        SizedBox(
                          width: 15,
                        )
                        ],
                      )
                      
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2, color: Colors.transparent)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [ 
                          Text('Your balance is', style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w300
                          
                          ),),
                          Row(
                            children: [
                              Text('₦ 500,234.34',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 40
                              ),),
                              SizedBox(width: 5),
                              Text('Today ${DateFormat('d EEE ').format(DateTime.now())}',
                              style: TextStyle(color: Colors.white),),

                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [ 
                                  Text('last deposit ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300
                              )),
                              Text('₦ 100,000',
                              style: TextStyle(
                                color: Colors.white,
                              ),),
                                ],
                              ),
                              
                              Row(
                                children: [
                                  TextButton(
                              onPressed: () {
                                
                              },
                              child: Text('+  Card',
                              style: TextStyle(
                                color: Colors.white
                              )),),
                              Text('59934***',
                              style: TextStyle(
                                color: Colors.white,
                              ),),
                              SizedBox(width: 10,)
                                ],
                              )
                              
                            ],
                          )
                        ],
                      )
                  )
                ],
                
              ),),
              Expanded(
                child: Container(
width: double.infinity,
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.only( topLeft: Radius.circular(60),
                    topRight: Radius.circular(60)),
                    color: Colors.white
                  ),
                  child:  Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        height: 50,
                        margin: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Transaction history',
                            style: TextStyle(fontSize: 20,
                            color: Colors.white),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
