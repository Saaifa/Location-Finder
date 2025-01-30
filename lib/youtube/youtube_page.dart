// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class YoutubePage extends StatefulWidget {
//   const YoutubePage({super.key});
//
//   @override
//   State<YoutubePage> createState() => _YoutubePageState();
// }
//
// class _YoutubePageState extends State<YoutubePage> {
//   YoutubePlayerController _controller = YoutubePlayerController(
//     initialVideoId: 'iLnmTe5Q2Qw',
//     flags: YoutubePlayerFlags(
//       autoPlay: true,
//       mute: true,
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Youtube player page",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.white
//         ),),
//         backgroundColor: Colors.red,
//       ),
//       body: SafeArea(
//         child: Container(
//           height: double.infinity,
//           child: YoutubePlayer(
//             controller: _controller,
//             showVideoProgressIndicator: true,
//             progressIndicatorColor: Colors.amber,
//             progressColors: const ProgressBarColors(
//               playedColor: Colors.amber,
//               handleColor: Colors.amberAccent,
//             ),
//             onReady: () {
//               // _controller.addListener(listener);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
