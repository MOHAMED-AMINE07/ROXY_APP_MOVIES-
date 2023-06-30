import 'package:flutter/material.dart';
import 'package:roxy1/constant/colors.dart';
import 'package:roxy1/widget/text_custom.dart';

class CoverCustom extends StatelessWidget {
  final String image;
  final String title;
  final String body;
  final double voteAverage;
  final double width;

  const CoverCustom(
      {super.key,
      required this.image,
      required this.title,
      this.body = "",
      this.width = 150,
      required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            width: width,
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              body,
              style: const TextStyle(color: Color(0x89FDFDFF), fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 19,
              color: Colors.amber[600],
            ),
            const SizedBox(
              width: 8,
            ),
            TextCustom(text: "${double.parse("$voteAverage")}"),
          ],
        )
      ]),
    );
  }
}
