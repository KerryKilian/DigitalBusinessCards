
import 'package:digital_business_cards/database/CardProvider.dart';
import 'package:digital_business_cards/database/DatabaseHelper.dart';
import 'package:digital_business_cards/screens/CardInformation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCard extends StatefulWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
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

    return Consumer<CardProvider>(
      builder: (context, cardProvider, _) {
        List<Map<String, dynamic>> result = cardProvider.data;

        if (_isLoading) {
          return CircularProgressIndicator();
        } else if (result.isEmpty) {
          return Text('No data available');
        }

        Iterable<Map<String, dynamic>> userCardIterable = result.where((element) => element["userCard"] == 1);
        Map<String, dynamic> data = userCardIterable.first;


        return CardInformation(data: data);

      },
    );

  }
}


