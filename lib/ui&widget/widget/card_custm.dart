import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:transparent_image/transparent_image.dart';

class CardCustm extends StatefulWidget {
  final String pictureId;
  final String name;
  final String city;
  final double rating;
  final Function() onPress;

  const CardCustm({
    Key? key,
    required this.pictureId,
    required this.name,
    required this.city,
    required this.rating,
    required this.onPress,
  }) : super(key: key);

  @override
  _CardCustmState createState() => _CardCustmState();
}

class _CardCustmState extends State<CardCustm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        child: InkWell(
          onTap: widget.onPress,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.pictureId,
                    height: 50,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.name),
                      Text(widget.city),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.rating.toString(),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          RatingBar.builder(
                              allowHalfRating: true,
                              ignoreGestures: true,
                              minRating: 1,
                              maxRating: 5,
                              itemCount: 5,
                              itemSize: 14,
                              initialRating: widget.rating,
                              itemBuilder: (context, _) =>
                              const Icon(Icons.star),
                              onRatingUpdate: (rating) {})
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
