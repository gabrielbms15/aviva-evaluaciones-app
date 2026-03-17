import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prevalencias/core/app_colors.dart';

class PrevalenciasAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget? leading;
  final String title;

  const PrevalenciasAppBar({
    super.key,
    this.leading,
    this.title = 'Prevalencias',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.main2,
      elevation: 0,
      scrolledUnderElevation: 2,
      leading:
          leading ??
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
      title: Text(
        title,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w800,
          fontSize: 18,
          color: const Color(0xFFFFFFFF),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Image.asset(
            'assets/logo2.png',
            height: 32,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
