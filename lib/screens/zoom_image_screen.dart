import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImageScreen extends StatefulWidget {
  final String? image;
  final String? id;

  ZoomImageScreen(this.image,this.id);


  @override
  _ZoomImageScreenState createState() => _ZoomImageScreenState();
}

class _ZoomImageScreenState extends State<ZoomImageScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Hero(
            tag: widget.id.toString(),
            child: PhotoView(
              imageProvider: Image.network(
                widget.image!,
                loadingBuilder: (context, child, loadingProgress) {
                  return Loader();
                },
              ).image,
            ),
          ),
          IconButton(iconSize: 20, padding: EdgeInsets.zero, icon: Icon(Icons.arrow_back_ios,color: Colors.white), onPressed: () => finish(context)).paddingOnly(top: context.statusBarHeight + 20),
        ],
      ),
    );
  }
}