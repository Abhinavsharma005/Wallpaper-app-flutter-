import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageurl;

  const FullScreen({Key? key, required this.imageurl}) : super(key: key);

  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setWallpaper() async {
    try {
      final file = await DefaultCacheManager().getSingleFile(widget.imageurl);

      // Choose location
      int location = WallpaperManager.HOME_SCREEN; // or LOCK_SCREEN / BOTH_SCREENS

      bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ? "Wallpaper applied!" : "Failed to set wallpaper"),
        ),
      );
    } catch (e) {
      debugPrint("Error setting wallpaper: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Image.network(widget.imageurl, fit: BoxFit.cover)),
          InkWell(
            onTap: setWallpaper,
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Set Wallpaper',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
