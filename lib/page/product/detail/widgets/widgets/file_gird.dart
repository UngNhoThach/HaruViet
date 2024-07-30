// import 'dart:math';

// import 'package:haruviet/helper/context.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class FileGrid extends StatefulWidget {
//   const FileGrid({
//     super.key,
//     required this.imageUrls,
//     required this.onImageClicked,
//     required this.onExpandClicked,
//     this.maxImages = 5,
//   });

//   final int maxImages;
//   final List<FileInfSoMessage> imageUrls;
//   final Function(int) onImageClicked;
//   final Function onExpandClicked;

//   @override
//   createState() => _FileGridState();
// }

// class _FileGridState extends State<FileGrid> {
//   @override
//   Widget build(BuildContext context) {
//     var images = buildImages();
//     if (widget.imageUrls.length == 1) {
//       return SizedBox(
//         height: 1.sw,
//         width: 1.sw,
//         child: _item(context, 0),
//       );
//     }
//     if (widget.imageUrls.length == 2 || widget.imageUrls.length == 4) {
//       return SizedBox(
//         height: widget.imageUrls.length == 2 ? 1.sw / 2 : 1.sw,
//         child: GridView(
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 1.sw / 2,
//             crossAxisSpacing: 2,
//             mainAxisSpacing: 2,
//           ),
//           children: images,
//         ),
//       );
//     }
//     if (widget.imageUrls.length == 3) {
//       return Row(
//         children: [
//           Expanded(child: SizedBox(height: 1.sw, child: _item(context, 0))),
//           const SizedBox(
//             width: 2,
//           ),
//           SizedBox(
//             width: 1.sw / 2 - 1,
//             child: Column(
//               children: [
//                 SizedBox(height: 1.sw / 2 - 1, child: _item(context, 1)),
//                 const SizedBox(
//                   height: 2,
//                 ),
//                 SizedBox(height: 1.sw / 2 - 1, child: _item(context, 2)),
//               ],
//             ),
//           )
//         ],
//       );
//     }
//     return SizedBox(
//       height: 1.sw,
//       width: 1.sw,
//       child: Column(children: [
//         Row(
//           children: [
//             Expanded(
//                 child: SizedBox(
//                     height: 1.sw - (1.sw / 3 - 4) - 1,
//                     child: _item(context, 0))),
//             const SizedBox(
//               width: 2,
//             ),
//             Expanded(
//                 child: SizedBox(
//                     height: 1.sw - (1.sw / 3 - 4) - 1,
//                     child: _item(context, 1))),
//           ],
//         ),
//         const SizedBox(
//           height: 2,
//         ),
//         Row(
//           children: [
//             Expanded(
//                 child: SizedBox(
//                     height: 1.sw / 3 - 4 - 1, child: _item(context, 2))),
//             const SizedBox(
//               width: 2,
//             ),
//             Expanded(
//                 child: SizedBox(
//                     height: 1.sw / 3 - 4 - 1, child: _item(context, 3))),
//             const SizedBox(
//               width: 2,
//             ),
//             Expanded(
//                 child: SizedBox(
//                     height: 1.sw / 3 - 5,
//                     child: widget.imageUrls.length > 5
//                         ? GestureDetector(
//                             onTap: () => widget.onExpandClicked(),
//                             child: Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 Image.network(
//                                     widget.imageUrls[4].fileFormat == 'image'
//                                         ? widget.imageUrls[4].filePath ?? ''
//                                         : widget.imageUrls[4].thumb ?? '',
//                                     fit: BoxFit.cover),
//                                 Positioned.fill(
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     color: Colors.black54,
//                                     child: Text(
//                                       '+${widget.imageUrls.length - 5}',
//                                       style: const TextStyle(
//                                           fontSize: 24, color: colorWhite),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         : _item(context, 4))),
//           ],
//         ),
//       ]),
//     );
//   }

//   List<Widget> buildImages() {
//     int numImages = widget.imageUrls.length;
//     return List<Widget>.generate(min(numImages, widget.maxImages), (index) {
//       String imageUrl = widget.imageUrls[index].fileFormat == 'image'
//           ? widget.imageUrls[index].filePath ?? ''
//           : widget.imageUrls[index].thumb ?? '';
//       return GestureDetector(
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.network(
//               imageUrl,
//               fit: BoxFit.cover,
//             ),
//             if (widget.imageUrls[index].fileFormat == 'video')
//               Icon(
//                 Icons.play_circle_outline_outlined,
//                 color: context.appColor.colorBlue,
//                 size: 40,
//               ),
//           ],
//         ),
//         onTap: () => widget.onImageClicked(index),
//       );
//     });
//   }

//   Widget _item(BuildContext context, int index) {
//     String imageUrl =
//         widget.imageUrls[index].thumb ?? widget.imageUrls[index].filePath ?? '';
//     return GestureDetector(
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//           ),
//           if (widget.imageUrls[index].fileFormat == 'video')
//             Icon(
//               Icons.play_circle_outline_outlined,
//               color: context.appColor.colorBlue,
//               size: 40,
//             ),
//         ],
//       ),
//       onTap: () => widget.onImageClicked(index),
//     );
//   }
// }
