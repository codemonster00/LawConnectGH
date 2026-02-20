import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/app_colors.dart';

/// Shimmer loading widget for better UX
class ShimmerLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  
  const ShimmerLoading({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceVariant,
      highlightColor: AppColors.surface,
      period: const Duration(milliseconds: 1000),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}

/// Shimmer loading for list tiles
class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ShimmerLoading(
        width: 56,
        height: 56,
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      title: const ShimmerLoading(
        width: 120,
        height: 16,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 8),
          ShimmerLoading(
            width: 80,
            height: 12,
          ),
          SizedBox(height: 4),
          ShimmerLoading(
            width: 60,
            height: 12,
          ),
        ],
      ),
      trailing: const ShimmerLoading(
        width: 24,
        height: 16,
      ),
    );
  }
}

/// Shimmer loading for cards
class ShimmerCard extends StatelessWidget {
  final double? height;
  
  const ShimmerCard({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 150,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const ShimmerLoading(
                    width: 50,
                    height: 50,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ShimmerLoading(
                          width: double.infinity,
                          height: 16,
                        ),
                        const SizedBox(height: 8),
                        ShimmerLoading(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const ShimmerLoading(
                width: double.infinity,
                height: 12,
              ),
              const SizedBox(height: 8),
              ShimmerLoading(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer loading for grids
class ShimmerGrid extends StatelessWidget {
  final int itemCount;
  final double? itemHeight;
  
  const ShimmerGrid({
    super.key,
    this.itemCount = 6,
    this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return const ShimmerLoading(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        );
      },
    );
  }
}