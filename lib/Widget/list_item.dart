import 'package:flutter/material.dart';
import 'package:valburytestapp/repository.dart';

class MyListItem extends StatefulWidget {

  final String type;
  final String category;

  const MyListItem({Key? key,required this.type, required this.category}) : super(key: key);

  @override
  _MyListItemState createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {

  List myList = List.empty(growable: true);
  double sizeImage = 60;

  @override
  void initState() {
    super.initState();
    dummyData.forEach((element) {
      if(element['type'] == widget.type){
        if(widget.category == 'SEMUA'){
          myList.add(element);
        }else{
          if(element['category'] == widget.category){
            myList.add(element);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView.builder(
          itemCount: myList.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, i){
            return Container(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 8, right: 8, bottom: 8),
                          child: Image.asset(
                            'assets/images/hospital.png', 
                            width: sizeImage, 
                            height: sizeImage,
                          )
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${myList[i]['name']}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${myList[i]['address']}',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Text('lihat detail', style: TextStyle(color: Colors.cyan),)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
