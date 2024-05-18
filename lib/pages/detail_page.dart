import 'package:anime_search/model/anime.dart';
import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/widgets/custom_image_banner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// DetailPage widget displays detailed information about a specific Anime
class DetailPage extends StatefulWidget {
  final Anime anime;

  const DetailPage({super.key, required this.anime});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _showFullSynopsis = false;

  // Helper function to handle null values in Anime details
  String getAnimeDetail(String detail, String fallback) {
    return detail == 'null' || detail == 'null-null-null' ? fallback : detail;
  }

  // Function to build a widget for displaying Anime details
  Widget buildAnimeDetail(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '$title:',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                )
              ],
            ),
          ),
          Text(detail,
              style: const TextStyle(
                fontSize: 16.0,
                color: textColor,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Splitting the synopsis into paragraphs
    List<String> paragraphs = widget.anime.synopsis.split('\n');
    String firstParagraph = paragraphs.first;
    String restOfSynopsis = paragraphs.skip(1).join('\n');

    // Preparing Anime details
    String rating = '${getAnimeDetail(widget.anime.rating, 'N/A')}/10';
    String episodes =
        '${getAnimeDetail(widget.anime.episodes, 'N/A')} episodes';
    String startDate = getAnimeDetail(widget.anime.startDate, 'N/A');
    String endDate = getAnimeDetail(widget.anime.endDate, 'N/A');

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          physics: const PageScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Displaying the Anime banner
              ImageBanner(
                trailerThumbnail: widget.anime.trailerThumbnail,
                title: widget.anime.title,
                url: widget.anime.trailerUrl,
              ),
              // Displaying the Anime synopsis
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
                    horizontal: 15.0, vertical: 10.0),
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
                        TextSpan(text: '\n$restOfSynopsis'),
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
              // Displaying the Anime details
              buildAnimeDetail('Rating', rating),
              const SizedBox(height: 10.0),
              buildAnimeDetail('Episodes', episodes),
              const SizedBox(height: 10.0),
              buildAnimeDetail('Status', widget.anime.status),
              const SizedBox(height: 10.0),
              buildAnimeDetail('Start Date', startDate),
              const SizedBox(height: 10.0),
              buildAnimeDetail('End Date', endDate),
              const SizedBox(height: 10.0),
              // Displaying the Anime genres
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Genres',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              // Displaying the Anime genres as chips
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
