import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackaton/screens/post_details_screen.dart';
import '../models/Objava.dart';
import './category_bubble.dart';
import 'package:hackaton/models/Kategorija.dart';

import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Objava card;

  PostCard(this.card, {super.key});

  // Objava (id, tip, naslov, tekst, slika, datum, kreatorId, kategorija, univerzitet)

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 22;

    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[600]!, width: 1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: cardWidth / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image.network(
                card.slika.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: cardWidth / 3 * 2,
            padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.naslov.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card.datum.toString(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CategoryItem(card.kategorija.name),
                  ],
                ),
                Text(
                  card.tekst.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      width: double.infinity,
                    )),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetailsScreen(card)));
                      },
                      child: Text('Detaljnije'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.white),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 20))),
                    ),
                    SizedBox(
                      width: 6,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
