import 'package:flutter/material.dart';
import 'package:valburytestapp/Widget/tabbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List banner = [
    'assets/images/banner.jpg',
    'assets/images/banner.jpg',
    'assets/images/banner.jpg',
    'assets/images/banner.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.home, size: 24, color: Colors.black,),
          title: Text(
            'Valbury',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Icon(Icons.shopping_cart, size: 24, color: Colors.black,),
            SizedBox(width: 16,)
          ],
          bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 20, bottom: 8),
                    alignment: Alignment.center,
                    child: Text('Label'),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38)
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(right: 20, bottom: 8),
                    alignment: Alignment.center,
                    child: Text('Label'),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38)
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size(34,34),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rumah Sakit'),
                  Text('Lihat Semua'),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Tabbar(type: 'Rumah Sakit',),
            ),
            SizedBox(height: 24,),
            Container(
              height: 100,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: banner.length,
                itemBuilder: (context, i){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(banner[i], fit: BoxFit.cover,)
                    ),
                  );
                }
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Klinik'),
                  Text('Lihat Semua'),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Tabbar(type: 'Klinik',),
            ),
          ],
        ),
      ),
    );
  }
}