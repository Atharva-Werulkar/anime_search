import 'package:anime_search/model/anime.dart';
import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/widgets/custom_image_banner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                child: Text(
                  'Rating: ${widget.anime.rating}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Text(
                  'Episodes: ${widget.anime.episodes}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Text(
                  'Aired: '
                  '${widget.anime.status}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: textColor,
                  ),
                ),
              ),

              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Text(
                  'Start Date: ${widget.anime.startDate}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Text(
                  'End Date: ${widget.anime.endDate}',
                  style: const TextStyle(fontSize: 16.0, color: textColor),
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
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Text(
                  'Trailer',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    Uri url = Uri.parse(widget.anime.url);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.inAppBrowserView);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: const Text('Watch Trailer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
