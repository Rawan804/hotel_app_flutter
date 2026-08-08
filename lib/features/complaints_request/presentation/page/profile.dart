import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/Notifications/presentation/notifications_page.dart';
import 'package:hotel_app/features/news/presentation/widgets/BottomBar/bottombar.dart';
import 'package:hotel_app/features/services/presentation/screens/ServicesPage.dart';
import '../../../../app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../language/presentation/cubit/language_cubit.dart';
import '../../../language/presentation/cubit/language_state.dart';
import '../../../leave_request/presentation/cubit/leave_request_cubit.dart';
import '../../../leave_request/presentation/page/leave_request_page.dart';

import '../../../news/presentation/cubit/BottomBar Cubit/bottomba_cubit.dart';
import 'complaints_page.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});
  void _showLanguagePicker(BuildContext context) {
    final cubit = context.read<LanguageCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Language / اللغة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.black),
              ),
              const SizedBox(height: 20),

              // خيار العربي
              BlocBuilder<LanguageCubit, LanguageState>(
                builder: (ctx, state) => _LanguageOption(
                    flag: '🇵🇸',
                    title: 'العربية',
                    color: Colors.black,
                    subtitle: 'Arabic',
                  isSelected: state.locale.languageCode == 'ar',
                    onTap: () async {
                      await cubit.changeLanguage('ar');
                      Navigator.pop(context);

                    }
                ),
              ),

              const SizedBox(height: 12),

              // خيار الإنجليزي
              BlocBuilder<LanguageCubit, LanguageState>(
                builder: (ctx, state) => _LanguageOption(
                  flag: '🇺🇸',
                  title: 'English',
                  subtitle: 'الإنجليزية',
                  color: Colors.black,
                  isSelected: state.locale.languageCode == 'en',
                    onTap: () async {
                      await cubit.changeLanguage('en');
                      Navigator.pop(context);

                    }
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F3F0),
      bottomNavigationBar: const Bottombar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Cover Header ─────────────────────────────────────
            const _CoverHeader(),

            // ── List Sections ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
              child: Column(
                children: [
                  // Section 1
                  _MenuCard(
                    items: [
                      _MenuItem(
                        icon: Icons.task_alt,
                        label: l.myTasks,
                          onTap: () {
                            context.read<BottomNavigationCubit>().changeIndex(1);
                          }
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Section 2
                  _MenuCard(
                    items: [
                      _MenuItem(
                        icon: Icons.notifications_none_outlined,
                        label: l.notifications,
    onTap: () {
    context.read<BottomNavigationCubit>().changeIndex(4);
    }

                      ),
                      // Leaves Request
                      _MenuItem(
                        icon: Icons.request_quote_outlined,
                        label: l.leavesRequest,
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) =>LeaveRequestPage()
                        ),
                      ),

// Complaint Request
                      _MenuItem(
                        icon: Icons.add,
                        label: l.complaintRequest,
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => ComplaintForm()
                        ),
                      ),
                      // Complaint Request — موجود قبل، ما تغير



                      _MenuItem(
                        icon: Icons.language_outlined,
                        label: l.language,
                        onTap: () => _showLanguagePicker(context), // ← هاد الإضافة الوحيدة
                      ),
                      _MenuItem(
                        icon: Icons.palette_outlined,
                        label: l.theme,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ThemePage()),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Section 3 — Logout
                  _MenuCard(
                    items: [
                      _MenuItem(
                        icon: Icons.logout_rounded,
                        label: l.signOut,
                        isDestructive: true,
                        onTap: () => _confirmSignOut(context),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  Text(
                    'v2.4.1 · Grand Azure Hotel',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.black.withOpacity(0.22),
                      letterSpacing: 0.8,
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Color(0xFFBF4E30)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Cover Header ─────────────────────────────────────────────────────────────

class _CoverHeader extends StatelessWidget {
  const _CoverHeader();

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        // ── Cover image ───────────────────────────────────────────
        SizedBox(
          height: 370,
          width: 500,
          child: Image.asset(
            'images/lopi.jpg',
            fit: BoxFit.cover,
          ),
        ),

        // ── Dark gradient overlay ─────────────────────────────────
        // Positioned.fill(
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //           Colors.transparent,
        //           Color(0x99000000),
        //         ],
        //         stops: [0.4, 1.0],
        //       ),
        //     ),
        //   ),
        // ),

        // ── Top action buttons ────────────────────────────────────
        // Positioned(
        //   bottom: MediaQuery.of(context).padding.bottom + 10,
        //   right: 16,
        //   child: Row(
        //     children: [
        //       _TopIconButton(icon: Icons.favorite_border_rounded),
        //       const SizedBox(width: 8),
        //       _TopIconButton(
        //         icon: Icons.notifications_none_rounded,
        //         badge: true,
        //       ),
        //     ],
        //   ),
        // ),

        // // // ── Avatar + name + subtitle ──────────────────────────────
        // Positioned(
        //   bottom: 24,
        //   left: 10,
        //   right: 0,
        //   child: Column(
        //     children: [
        //       // Avatar
        //       Container(
        //         width: 72,
        //         height: 72,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           border: Border.all(color: Colors.white, width: 3),
        //           image: const DecorationImage(
        //             image: AssetImage('images/img.png'),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //
        //       const SizedBox(height: 10),
        //
        //       // Name
        //       const Text(
        //         'Rawan Aidi',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 20,
        //           fontWeight: FontWeight.w700,
        //           letterSpacing: 0.2,
        //         ),
        //       ),
        //
        //       const SizedBox(height: 4),
        //
        //       // Tagline / email
        //       Text(
        //         'rawan@gmail.com',
        //         style: TextStyle(
        //           color: Colors.white.withOpacity(0.70),
        //           fontSize: 13,
        //           fontWeight: FontWeight.w400,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        //
        // // ── Rounded white sheet at the bottom ────────────────────
        // Positioned(
        //   bottom: -1,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     height: 24,
        //     decoration: const BoxDecoration(
        //       color: Color(0xFFF5F3F0),
        //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// ─── Top action button ────────────────────────────────────────────────────────

class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final bool badge;

  const _TopIconButton({required this.icon, this.badge = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        if (badge)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                color: Color(0xFFBF4E30),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Menu Card ────────────────────────────────────────────────────────────────

class _MenuCard extends StatelessWidget {
  final List<_MenuItem> items;

  const _MenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _buildTile(context, items[i]),
            if (i < items.length - 1)
              Divider(
                height: 1,
                indent: 52,
                endIndent: 16,
                color: Colors.black.withOpacity(0.06),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, _MenuItem item) {
    final isDestructive = item.isDestructive;
    final iconColor =
    isDestructive ? const Color(0xFFBF4E30) : const Color(0xFF8C8884);
    final textColor =
    isDestructive ? const Color(0xFFBF4E30) : const Color(0xFF2C2A28);

    return InkWell(
      onTap: item.onTap ?? () {},
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Icon
            SizedBox(
              width: 24,
              child: Icon(item.icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),

            // Label
            Expanded(
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),

            // Chevron
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF8C8884).withOpacity(0.5),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

}

// ─── Data class ──────────────────────────────────────────────────────────────

class _MenuItem {
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.isDestructive = false,
    this.onTap,
  });
}
class _LanguageOption extends StatelessWidget {
  final String flag;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _LanguageOption({
    required this.flag,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isSelected ? const Color(0xFFF5F3F0) : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? const Color(0xFF8C8884)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.45),
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF8C8884),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}