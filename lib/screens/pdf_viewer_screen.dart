import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;

class PdfViewerScreen extends StatefulWidget {
  final String title;
  final String pdfUrl;

  const PdfViewerScreen({
    super.key,
    required this.title,
    required this.pdfUrl,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  PdfControllerPinch? _controller;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final uri = Uri.parse(widget.pdfUrl);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final document = PdfDocument.openData(response.bodyBytes);
        setState(() {
          _controller = PdfControllerPinch(
            document: document,
            initialPage: 1,
          );
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load PDF (code: ${response.statusCode})';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load PDF';
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : PdfViewPinch(
        controller: _controller!,
        padding: 0,
        backgroundDecoration:
        const BoxDecoration(color: Colors.white),
      ),
    );
  }
}