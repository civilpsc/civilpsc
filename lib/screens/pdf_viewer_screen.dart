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

  int _pagesCount = 0;
  int _currentPage = 1;

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
        final documentFuture = PdfDocument.openData(response.bodyBytes);
        final document = await documentFuture;

        setState(() {
          _controller = PdfControllerPinch(
            document: documentFuture,
            initialPage: 1,
          );
          _pagesCount = document.pagesCount;
          _currentPage = 1;
          _loading = false;
          _error = null;
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

  void _jumpToPage(int page) {
    final controller = _controller;
    if (controller == null) return;
    if (page < 1 || page > _pagesCount) return;
    controller.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Scaffold(
      appBar: AppBar(
        // Title + page info LEFT side
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (_pagesCount > 0)
              Text(
                'Page $_currentPage / $_pagesCount',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : Row(
        children: [
          /// ---------- LEFT: PDF VIEW ----------
          Expanded(
            child: PdfViewPinch(
              controller: controller!,
              padding: 0,
              backgroundDecoration:
              const BoxDecoration(color: Colors.white),
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),

          /// ---------- RIGHT: VERTICAL SLIDER + NUMBERS ----------
          if (_pagesCount > 1)
            Container(
              width: 60,
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  // മുകളിൽ: current page number
                  Text(
                    '$_currentPage',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_up),
                    onPressed: _currentPage > 1
                        ? () => _jumpToPage(_currentPage - 1)
                        : null,
                  ),

                  // നടുവിൽ: vertical slider (top -> bottom)
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Slider(
                        value: _currentPage.toDouble(),
                        min: 1,
                        max: _pagesCount.toDouble(),
                        divisions: _pagesCount > 1
                            ? _pagesCount - 1
                            : null,
                        label: '$_currentPage',
                        onChanged: (value) {
                          setState(() {
                            _currentPage = value.round();
                          });
                        },
                        onChangeEnd: (value) {
                          _jumpToPage(value.round());
                        },
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onPressed: _currentPage < _pagesCount
                        ? () => _jumpToPage(_currentPage + 1)
                        : null,
                  ),
                  // താഴെ: total pages number
                  Text(
                    '$_pagesCount',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}