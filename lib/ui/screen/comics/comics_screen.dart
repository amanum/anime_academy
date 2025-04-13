import 'dart:async';
import 'dart:io';
import 'package:anime_academy/ani_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';

class ComicsScreen extends StatefulWidget {
  const ComicsScreen({
    required this.url,
    super.key,
  });

  final String url;

  @override
  State<ComicsScreen> createState() => _ComicsScreenState();
}

class _ComicsScreenState extends State<ComicsScreen> {
  String? path;

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((file) {
      setState(() {
        path = file.path;
      });
    });
  }

  void _loadPdf() async {}

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    final url = '${AniConfig.baseUrl}${widget.url}';
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: path != null
          ? PDFView(
              filePath: path!,
              enableSwipe: true,
              autoSpacing: false,
              pageFling: false,
              backgroundColor: Colors.grey,
              onRender: (_pages) {
                // setState(() {
                //   pages = _pages;
                //   isReady = true;
                // });
              },
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                // _controller.complete(pdfViewController);
              },
              // onPageChanged: (int page, int total) {
              //   print('page change: $page/$total');
              // },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
