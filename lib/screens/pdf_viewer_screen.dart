import 'dart:async';

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

  bool _showPageBubble = false;
  Timer? _bubbleTimer;

  // 0.0 (top) → 1.0 (bottom) : bubble position / fast-scroll position
  double _bubblePosition = 0.0;

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
          _bubblePosition = 0.0;
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
    _bubbleTimer?.cancel();
    super.dispose();
  }

  void _startHideBubbleTimer() {
    _bubbleTimer?.cancel();
    _bubbleTimer = Timer(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _showPageBubble = false;
        });
      }
    });
  }

  void _updateBubbleFromPage() {
    if (_pagesCount <= 1) {
      _bubblePosition = 0.0;
    } else {
      _bubblePosition = (_currentPage - 1) / (_pagesCount - 1);
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _showPageBubble = true;
      _updateBubbleFromPage();
    });
    _startHideBubbleTimer();
  }

  void _jumpToPageFromDrag(double dy, double trackHeight) {
    if (_pagesCount <= 1 || trackHeight <= 0) return;

    // dy 0 → trackHeight  → fraction 0..1
    double fraction = (dy / trackHeight).clamp(0.0, 1.0);
    int page = (fraction * (_pagesCount - 1)).round() + 1;

    setState(() {
      _currentPage = page;
      _bubblePosition = fraction;
      _showPageBubble = true;
    });

    final controller = _controller;
    if (controller != null) {
      controller.jumpToPage(page);
    }

    _startHideBubbleTimer();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Scaffold(
      appBar: AppBar(
        // title + ചെറിയ info left side
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
          : LayoutBuilder(
        builder: (context, constraints) {
          final fullHeight = constraints.maxHeight;

          return Stack(
            children: [
              // ---------- PDF VIEW ----------
              Positioned.fill(
                child: PdfViewPinch(
                  controller: controller!,
                  padding: 0,
                  backgroundDecoration:
                  const BoxDecoration(color: Colors.white),
                  onPageChanged: _onPageChanged,
                ),
              ),

              // ---------- FAST-SCROLL AREA + BUBBLE ----------
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: SizedBox(
                  width: 48, // thin zone on right
                  child: LayoutBuilder(
                    builder: (context, trackConstraints) {
                      final trackHeight = trackConstraints.maxHeight;

                      // bubble vertical position
                      final bubbleY = 16 +
                          (trackHeight - 32) *
                              _bubblePosition
                                  .clamp(0.0, 1.0); // padding 16 top/bottom

                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onVerticalDragStart: (details) {
                          _jumpToPageFromDrag(
                            details.localPosition.dy,
                            trackHeight,
                          );
                        },
                        onVerticalDragUpdate: (details) {
                          _jumpToPageFromDrag(
                            details.localPosition.dy,
                            trackHeight,
                          );
                        },
                        onVerticalDragEnd: (_) {
                          _startHideBubbleTimer();
                        },
                        child: Stack(
                          children: [
                            // thin transparent track line (optional)
                            Positioned(
                              right: 20,
                              top: 16,
                              bottom: 16,
                              child: Container(
                                width: 2,
                                decoration: BoxDecoration(
                                  color: Colors.black
                                      .withOpacity(0.10),
                                  borderRadius:
                                  BorderRadius.circular(2),
                                ),
                              ),
                            ),

                            // thumb circle – always visible (small)
                            Positioned(
                              right: 12,
                              top: 16 +
                                  (trackHeight - 32) *
                                      _bubblePosition
                                          .clamp(0.0, 1.0),
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.grey
                                      .withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),

                            // page bubble – only when _showPageBubble
                            if (_showPageBubble && _pagesCount > 0)
                              Positioned(
                                right: 40,
                                top: bubbleY,
                                child: Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black
                                        .withOpacity(0.7),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '$_currentPage / $_pagesCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}