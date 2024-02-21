import 'package:farectory/TabBarPages/lands_page.dart';
import 'package:farectory/TabBarPages/machineries_page.dart';
import 'package:farectory/TabBarPages/seeds_page.dart';
import 'package:flutter/material.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {

  final List<Tab> tabs = [
    const Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.landscape),
          SizedBox(
            width: 8,
          ),
          Text('LANDS'),
        ],
      ),
    ),
    const Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.car_repair),
          SizedBox(
            width: 8,
          ),
          Text('MACHINERIES')
        ],
      ),
    ),
    const Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.energy_savings_leaf),
          SizedBox(
            width: 8,
          ),
          Text('SEEDS')
        ],
      ),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  bottom: 10, top: 25, left: 15, right: 15),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline,
                      color: Colors.white,)),
                        Text('MARKETPLACE', style: TextStyle(color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),),
                      
                      IconButton(
                        icon: Icon(Icons.trolley,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        
                      },),
                    
                    ],
                  ),
                  
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.blue),
                    child: TabBar(
            dividerColor: Colors.transparent,
            automaticIndicatorColorAdjustment: false,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: tabs,
          ),
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 15),
Expanded(
  child: TabBarView(
                            children: [
                                LandPage(),
                                MachineriesPage(),
                                SeedsPage(),
                            ],
                          ),
),
  
            
          ],
        ),
      ),
    );
  }
}