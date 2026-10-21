import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CampusVisualCarousel extends StatefulWidget {
  final bool compact;

  const CampusVisualCarousel({super.key, this.compact = false});

  @override
  State<CampusVisualCarousel> createState() => _CampusVisualCarouselState();
}

class _CampusVisualCarouselState extends State<CampusVisualCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  static const _slides = [
    _VisualSlide(
      title: 'Life at SGU',
      subtitle: 'Explore campus spaces, student services and everyday university life.',
      icon: Icons.location_city_outlined,
      button: 'Explore Campus',
    ),
    _VisualSlide(
      title: 'Your Academic Journey',
      subtitle: 'Keep courses, attendance, assignments and academic progress in one place.',
      icon: Icons.school_outlined,
      button: 'View Academics',
    ),
    _VisualSlide(
      title: 'Connect. Learn. Grow.',
      subtitle: 'Discover events, clubs and opportunities happening around your campus.',
      icon: Icons.groups_outlined,
      button: 'View Events',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _index = (_index + 1) % _slides.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.compact ? 150.0 : 176.0;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _slides.length,
              onPageChanged: (value) {
                setState(() => _index = value);
              },
              itemBuilder: (context, index) {
                return _buildSlide(_slides[index], index);
              },
            ),
            Positioned(
              left: 18,
              bottom: 12,
              child: Row(
                children: List.generate(
                  _slides.length,
                  (dotIndex) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.only(right: 5),
                    width: dotIndex == _index ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: dotIndex == _index ? .95 : .45,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(_VisualSlide slide, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/sgu_campus.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.darkRed, AppTheme.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            );
          },
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.darkRed.withValues(alpha: .92),
                AppTheme.red.withValues(alpha: .48),
                Colors.black.withValues(alpha: .12),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/sgu_logo.png'),
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'SANJAY GHODAWAT UNIVERSITY',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .88),
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: .4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      slide.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 540),
                      child: Text(
                        slide.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: .90),
                          fontSize: 11,
                          height: 1.25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 30,
                      child: FilledButton.tonalIcon(
                        onPressed: () {},
                        icon: Icon(slide.icon, size: 14),
                        label: Text(
                          slide.button,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!widget.compact)
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .16),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .45),
                    ),
                  ),
                  child: Icon(
                    slide.icon,
                    color: Colors.white,
                    size: 31,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VisualSlide {
  final String title;
  final String subtitle;
  final IconData icon;
  final String button;

  const _VisualSlide({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.button,
  });
}
