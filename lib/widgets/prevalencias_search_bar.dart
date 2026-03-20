import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prevalencias/core/app_colors.dart';
import 'dart:ui';
import 'dart:math' as math;

class PrevalenciasSearchBar extends StatelessWidget {
  final SearchController controller;
  final String hintText;
  final int itemCount;
  final Iterable<Widget> Function(BuildContext, SearchController)
  suggestionsBuilder;
  final EdgeInsetsGeometry padding;

  const PrevalenciasSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.itemCount,
    required this.suggestionsBuilder,
    this.padding = const EdgeInsets.only(bottom: 20.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SearchAnchor(
        isFullScreen: false,
        searchController: controller,
        viewConstraints: BoxConstraints(
          maxHeight: (math.min(itemCount, 6) * 56.0) + 16.0,
        ),
        viewBackgroundColor: Colors.white,
        viewElevation: 8,
        viewSurfaceTintColor: Colors.transparent,
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.shade100, width: 1),
        ),
        builder: (BuildContext context, SearchController searchController) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SearchBar(
                controller: searchController,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.04,
                ),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onTap: () => searchController.openView(),
                onChanged: (_) => searchController.openView(),
                leading: const Icon(Icons.search, color: AppColors.main1),
                hintText: hintText,
                hintStyle: WidgetStatePropertyAll<TextStyle>(
                  GoogleFonts.inter(
                    color: AppColors.primaryBrown.withOpacity(0.5),
                    fontSize: 14,
                  ),
                ),
                elevation: const WidgetStatePropertyAll<double>(0),
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.white.withOpacity(0.7),
                ),
                side: WidgetStatePropertyAll<BorderSide>(
                  BorderSide(color: Colors.white.withOpacity(0.5), width: 1.5),
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          );
        },
        suggestionsBuilder: suggestionsBuilder,
      ),
    );
  }
}
