import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentora/core/themes/app_colors.dart';

class AnimatedItemMarker extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const AnimatedItemMarker({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  State<AnimatedItemMarker> createState() => _AnimatedItemMarkerState();
}

class _AnimatedItemMarkerState extends State<AnimatedItemMarker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -_animation.value),
            child: child,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: widget.imageUrl.isNotEmpty
                    ? Image.network(
                        widget.imageUrl,
                        width: 40.r,
                        height: 40.r,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildFallbackIcon(),
                      )
                    : _buildFallbackIcon(),
              ),
            ),
            SizedBox(height: 2.h),
            Icon(
              Icons.location_on,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      width: 40.r,
      height: 40.r,
      color: AppColors.grey,
      child: Icon(Icons.image, color: AppColors.white, size: 20.sp),
    );
  }
}
