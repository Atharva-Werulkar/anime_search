import 'package:anime_search/model/anime.dart';
import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/widgets/custom_image_banner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Anime anime;

  const DetailPage({Key? key, required this.anime}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _showFullSynopsis = false;
  @override
  Widget build(BuildContext context) {
    List<String> paragraphs = widget.anime.synopsis.split('\n');
    String firstParagraph = paragraphs.first;
    String restOfSynopsis = paragraphs.skip(1).join('\n');
    String rating =
        widget.anime.rating == 'null' ? 'N/A' : widget.anime.rating + '/10';

    String episodes = widget.anime.episodes == 'null'
        ? 'N/A'
        : widget.anime.episodes + ' episodes';
    String startDate = widget.anime.startDate == 'null-null-null'
        ? 'N/A'
        : widget.anime.startDate;

    String endDate = widget.anime.endDate == 'null-null-null'
        ? 'N/A'
        : widget.anime.startDate;

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Custom Anime Card
              ImageBanner(
                trailerThumbnail: widget.anime.trailerThumbnail,
                title: widget.anime.title,
                url: widget.anime.trailerUrl,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Text(
                  'Storyline',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: const TextStyle(
                      height: 1.3,
                      fontSize: 16.0,
                      color: textColor,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: firstParagraph),
                      if (_showFullSynopsis)
                        TextSpan(text: '\n' + restOfSynopsis),
                      TextSpan(
                        text: _showFullSynopsis ? ' Show Less' : ' Read More',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: primaryIconColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              _showFullSynopsis = !_showFullSynopsis;
                            });
                          },
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Rating:',
                            )
                          ],
                        ),
                      ),
                      Text('${rating}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: textColor,
                          )),
                    ],
                  )),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Episodes:',
                          )
                        ],
                      ),
                    ),
                    Text(episodes,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: textColor,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Status:',
                          )
                        ],
                      ),
                    ),
                    Text(widget.anime.status,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: textColor,
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Start Date:',
                          )
                        ],
                      ),
                    ),
                    Text(startDate,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: textColor,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Start Date:',
                          )
                        ],
                      ),
                    ),
                    Text(endDate,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: textColor,
                        )),
                  ],
                ),
              ),

              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Text(
                  'Genres',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: widget.anime.genres.map((String genre) {
                    return Chip(
                      color: MaterialStateColor.resolveWith(
                          (states) => primaryIconColor),
                      label: Text(
                        genre,
                        style: const TextStyle(
                          color: textColor,
                        ),
                      ),
                      backgroundColor: primaryColor,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
