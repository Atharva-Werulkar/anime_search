// import 'package:flutter/material.dart';
//
// class AnimeCard extends StatelessWidget {
//   const AnimeCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8.0),
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             snapshot.data![index].title,
//             style: const TextStyle(
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Image.network(
//               snapshot.data![index].trailerThumbnail),
//           const SizedBox(height: 8.0),
//           Text(
//             'URL: ${snapshot.data![index].url}',
//             style: const TextStyle(
//               fontSize: 14.0,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             'Trailer URL: ${snapshot.data![index].trailerUrl}',
//             style: const TextStyle(
//               fontSize: 14.0,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//
// }
import 'package:anime_search/utiles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class AnimeCard extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String url;
  final String trailerUrl;

  const AnimeCard({
    Key? key,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
    required this.trailerUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShadowOverlay(
          shadowColor: Colors.black,
          shadowWidth: 900,
          shadowHeight: 150,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(thumbnailUrl),
                fit: BoxFit.fill,
              ),
            ),
            // Anime Rating At top left
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ],
    );

    // Container(
    //   decoration: BoxDecoration(
    //     color: secondaryColor,
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    //   child: Stack(
    //     children: [
    //       ShadowOverlay(
    //         shadowColor: Colors.black,
    //         shadowWidth: 900,
    //         shadowHeight: 150,
    //         child: Padding(
    //           padding: const EdgeInsets.all(5.0),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(10.0),
    //             ),
    //             child: Image.network(
    //               thumbnailUrl,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: Text(
    //           title,
    //           textAlign: TextAlign.center,
    //           style: const TextStyle(
    //             fontSize: 15.0,
    //             fontWeight: FontWeight.bold,
    //             color: textColor,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
