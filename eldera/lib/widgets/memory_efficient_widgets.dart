import 'package:flutter/material.dart';
import '../utils/memory_optimizer.dart';
import '../services/optimized_image_service.dart';

/// Memory-efficient widgets optimized for low-end devices
class MemoryEfficientWidgets {
  
  /// Lazy-loaded list view that builds items only when needed
  static Widget buildLazyListView({
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    bool shrinkWrap = false,
  }) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Add memory optimization for budget devices
        if (MemoryOptimizer.isBudgetDevice()) {
          return RepaintBoundary(
            child: itemBuilder(context, index),
          );
        }
        return itemBuilder(context, index);
      },
      // Optimize cache extent for low-end devices
      cacheExtent: MemoryOptimizer.isBudgetDevice() ? 250.0 : 500.0,
    );
  }

  /// Memory-efficient grid view
  static Widget buildLazyGridView({
    required int itemCount,
    required Widget Function(BuildContext context, int index) itemBuilder,
    required SliverGridDelegate gridDelegate,
    ScrollController? controller,
    EdgeInsetsGeometry? padding,
    bool shrinkWrap = false,
  }) {
    return GridView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      gridDelegate: gridDelegate,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (MemoryOptimizer.isBudgetDevice()) {
          return RepaintBoundary(
            child: itemBuilder(context, index),
          );
        }
        return itemBuilder(context, index);
      },
      cacheExtent: MemoryOptimizer.isBudgetDevice() ? 200.0 : 400.0,
    );
  }

  /// Optimized card widget with reduced shadows for budget devices
  static Widget buildOptimizedCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    final isLowEnd = MemoryOptimizer.isBudgetDevice();
    
    return Card(
      margin: margin,
      color: color,
      elevation: isLowEnd ? (elevation ?? 2.0) * 0.5 : elevation,
      shape: shape,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: isLowEnd ? RepaintBoundary(child: child) : child,
      ),
    );
  }

  /// Memory-efficient image with placeholder
  static Widget buildOptimizedImage({
    required String assetPath,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? placeholder,
    Widget? errorWidget,
  }) {
    return OptimizedImageService.buildLazyImage(
      assetPath: assetPath,
      width: width,
      height: height,
      fit: fit,
      placeholder: placeholder,
    );
  }

  /// Optimized container with reduced decorations for budget devices
  static Widget buildOptimizedContainer({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    Decoration? decoration,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
  }) {
    final isLowEnd = MemoryOptimizer.isBudgetDevice();
    
    // Reduce visual effects on budget devices
    final optimizedDecoration = decoration ?? BoxDecoration(
      color: color,
      borderRadius: borderRadius,
      boxShadow: isLowEnd 
          ? (boxShadow?.map((shadow) => BoxShadow(
              color: shadow.color.withOpacity(shadow.color.opacity * 0.5),
              blurRadius: shadow.blurRadius * 0.5,
              offset: shadow.offset,
              spreadRadius: shadow.spreadRadius * 0.5,
            )).toList())
          : boxShadow,
    );

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: optimizedDecoration,
      child: isLowEnd ? RepaintBoundary(child: child) : child,
    );
  }

  /// Optimized animated container for smooth animations on low-end devices
  static Widget buildOptimizedAnimatedContainer({
    required Widget child,
    required Duration duration,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    Decoration? decoration,
    Curve curve = Curves.linear,
  }) {
    final isLowEnd = MemoryOptimizer.isBudgetDevice();
    
    return AnimatedContainer(
      duration: isLowEnd 
          ? Duration(milliseconds: (duration.inMilliseconds * 0.7).round())
          : duration,
      curve: isLowEnd ? Curves.easeOut : curve,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration ?? BoxDecoration(color: color),
      child: isLowEnd ? RepaintBoundary(child: child) : child,
    );
  }

  /// Optimized text widget with reduced font features for budget devices
  static Widget buildOptimizedText(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    final isLowEnd = MemoryOptimizer.isBudgetDevice();
    
    return Text(
      text,
      style: style?.copyWith(
        // Disable font features that consume memory on budget devices
        fontFeatures: isLowEnd ? [] : style.fontFeatures,
      ) ?? (isLowEnd ? const TextStyle(fontFeatures: []) : null),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Optimized button with reduced effects for budget devices
  static Widget buildOptimizedElevatedButton({
    required VoidCallback? onPressed,
    required Widget child,
    ButtonStyle? style,
    double? elevation,
  }) {
    final isLowEnd = MemoryOptimizer.isBudgetDevice();
    
    return ElevatedButton(
      onPressed: onPressed,
      style: style?.copyWith(
        elevation: isLowEnd 
            ? MaterialStateProperty.all((elevation ?? 2.0) * 0.5)
            : null,
      ) ?? (isLowEnd 
          ? ElevatedButton.styleFrom(
              elevation: (elevation ?? 2.0) * 0.5,
            )
          : null),
      child: child,
    );
  }

  /// Optimized scaffold with memory management
  static Widget buildOptimizedScaffold({
    PreferredSizeWidget? appBar,
    Widget? body,
    Widget? floatingActionButton,
    Widget? drawer,
    Widget? endDrawer,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
    bool resizeToAvoidBottomInset = true,
  }) {
    return Scaffold(
      appBar: appBar,
      body: MemoryOptimizer.isBudgetDevice() && body != null
          ? RepaintBoundary(child: body)
          : body,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// Build a memory-efficient loading indicator
  static Widget buildOptimizedLoadingIndicator({
    Color? color,
    double? strokeWidth,
    double? size,
  }) {
    final isLowEnd = MemoryOptimizer.isBudgetDevice();
    final indicatorSize = size ?? (isLowEnd ? 20.0 : 24.0);
    
    return SizedBox(
      width: indicatorSize,
      height: indicatorSize,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: strokeWidth ?? (isLowEnd ? 2.0 : 3.0),
      ),
    );
  }

  /// Build an optimized refresh indicator
  static Widget buildOptimizedRefreshIndicator({
    required Widget child,
    required Future<void> Function() onRefresh,
    Color? color,
  }) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color,
      strokeWidth: MemoryOptimizer.isBudgetDevice() ? 2.0 : 3.0,
      child: child,
    );
  }
}