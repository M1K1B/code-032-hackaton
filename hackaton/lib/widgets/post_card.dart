import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackaton/models/Tip.dart';
import 'package:hackaton/screens/post_details_screen.dart';
import '../models/Objava.dart';
import './category_bubble.dart';
import 'package:hackaton/models/Kategorija.dart';

import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Objava card;

  PostCard(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width - 22;

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostDetailsScreen(card)));
          },
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: double.infinity,
                height: 140,
                child: Image.asset(
                  'bg.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: card.tip != Tip.REKLAMA
                      ? Colors.white.withOpacity(0.93)
                      : Color.fromARGB(255, 253, 193, 53)!.withOpacity(0.85),
                  border: Border.all(color: Colors.grey[400]!, width: 1),
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
                    padding:
                        EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          card.naslov.toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 10,
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
                            if (card.tip != Tip.REKLAMA)
                              CategoryItem(card.kategorija.name),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          card.tekst.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}
