import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/constants/app_colors.dart';
import 'package:hotel_app/core/util/date_formatter.dart';
import 'package:hotel_app/features/Auth/presentation/pages/login_page.dart';
import 'package:hotel_app/features/complaints_request/presentation/page/profile.dart';
import '../../../../Notifications/presentation/notifications_page.dart';
import '../../../../guide/presentation/guid_page.dart';
import '../../../../services/presentation/cubit/services_cubit.dart';
import '../../../../services/presentation/cubit/services_state.dart';
import '../../../../services/presentation/screens/ServicesPage.dart';

import '../../cubit/BottomBar Cubit/bottomba_cubit.dart';
import '../../cubit/BottomBar Cubit/bottombar_state.dart';
import '../../screen/HomePage.dart';

class Bottombar extends StatelessWidget {
  const Bottombar({super.key});

  Widget _buildIconWithBadge({
    required IconData icon,
    required int count,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 30, color: Colors.white),
        if (count > 0)
          Positioned(
            right: -19,
            top: -9,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 1.2),
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Center(
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
      listenWhen: (previous, current) =>
      current is BottomNavigationSelected && previous.index != current.index,
      builder: (context, state) {
        return BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, servicesState) {
            // عدّل هذا السطر حسب شكل الـ state الفعلي عندك
            final pendingCount = servicesState is ServiceSuccess
                ? servicesState.services
                .where((s) => isTaskPending(s.status))
                .length
                : 0;

            final items = <Widget>[
              const Icon(Icons.person, size: 30, color: Colors.white),
              _buildIconWithBadge(
                icon: Icons.checklist_rtl_outlined,
                count: pendingCount,
              ),
              const Icon(Icons.home, size: 30, color: Colors.white),
              const Icon(Icons.menu_book, size: 30, color: Colors.white),
              const Icon(Icons.notification_add, size: 30, color: Colors.white),
            ];

            return SafeArea(
              child: CurvedNavigationBar(
                color: theme.colorScheme.surface,
                backgroundColor: Colors.transparent,
                items: items,
                height: 50,
                index: state.index,
                onTap: (index) {
                  context.read<BottomNavigationCubit>().changeIndex(index);
                },
              ),
            );
          },
        );
      },
      listener: (context, state) {
        switch (state.index) {
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ServicesPage(),
              ),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Homepage(),
              ),
            );
            break;

          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => GuidPage(),
              ),
            );

            break;
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ProfilePage(),
              ),
            );

          case 4:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => NotificationsPage(),
              ),
            );
            break;
        }
      },
    );
  }
}