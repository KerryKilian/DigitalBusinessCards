import 'package:digital_business_cards/database/CardModel.dart';
import 'package:digital_business_cards/screens/CardInformation.dart';
import 'package:digital_business_cards/utils/colors.dart';
import 'package:digital_business_cards/utils/constants.dart';
import 'package:digital_business_cards/widgets/AppText.dart';
import 'package:flutter/material.dart';

class SmallCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const SmallCard({Key? key, required this.data}) : super(key: key);

  @override
  State<SmallCard> createState() => _SmallCardState();
}

class _SmallCardState extends State<SmallCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CardInformation(data: widget.data,)),
        );

      },
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.data["photoUrl"] == "" || widget.data["photoUrl"] == null ? Icon(Icons.person) : Image.network(widget.data["photoUrl"], fit: BoxFit.cover,),
            ),
          ),
          SizedBox(width: padding,),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.data["logoUrl"] == "" || widget.data["logoUrl"] == null ? Icon(Icons.house, size: 50,) : Image.network(widget.data["logoUrl"], fit: BoxFit.cover,),
            ),
          ),
          SizedBox(width: padding,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: widget.data["name"], fontWeight: FontWeight.bold),
                widget.data["job"] != "" ? AppText(text: widget.data["job"]) : SizedBox(height: 0,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
