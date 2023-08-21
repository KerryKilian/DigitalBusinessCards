import 'package:digital_business_cards/database/CardProvider.dart';
import 'package:digital_business_cards/database/DatabaseHelper.dart';
import 'package:digital_business_cards/utils/constants.dart';
import 'package:digital_business_cards/widgets/AppText.dart';
import 'package:digital_business_cards/widgets/Background.dart';
import 'package:digital_business_cards/widgets/SmallCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedCards extends StatefulWidget {
  const SavedCards({Key? key}) : super(key: key);

  @override
  State<SavedCards> createState() => _SavedCardsState();
}

class _SavedCardsState extends State<SavedCards> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
    Provider.of<CardProvider>(context, listen: false).listenToDataChanges();
  }

  void loadData() async {
    List<Map<String, dynamic>> data =
    await DatabaseHelper.getData();

    CardProvider cardProvider =
    Provider.of<CardProvider>(context, listen: false);
    cardProvider.updateData(data);

    setState(() {
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Background(
        child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  AppText(text: "Gespeicherte QR Codes", title: true,),
                  SizedBox(height: padding,),
                  Expanded(
                    child: Consumer<CardProvider>(
                      builder: (context, cardProvider, _) {
                        List<Map<String, dynamic>> data = cardProvider.data;

                        if (_isLoading) {
                          return CircularProgressIndicator();
                        } else if (data.isEmpty) {
                          return Text('No data available');
                        }

                        return ListView.builder(
                          itemCount: data.length,
                            itemBuilder: (BuildContext, int index) {
                            if (data[index]["userCard"] == 1) {
                              return SizedBox(height: 0,);
                            }
                          return ListTile(
                            title: SmallCard(data: data[index]),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}
