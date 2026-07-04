import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/constants/app_colors.dart';
import 'package:hotel_app/features/Auth/presentation/pages/login_page.dart';
import 'package:hotel_app/features/Guid/presentation/guid.dart';
import 'package:hotel_app/features/complaints_request/presentation/page/profile.dart';

import '../../cubit/BottomBar Cubit/bottomba_cubit.dart';
import '../../cubit/BottomBar Cubit/bottombar_state.dart';
import '../../screen/HomePage.dart';
class Bottombar extends StatelessWidget {
  const Bottombar({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<BottomNavigationCubit, BottomNavigationState>(
      listenWhen: (previous, current) => current is BottomNavigationSelected && previous.index != current.index,
      builder: (context, state) {
        final items = <Widget>[
          const Icon(Icons.person, size: 30, color: Colors.white),
          const Icon(Icons.checklist_rtl_outlined, size: 30, color: Colors.white),
          const Icon(Icons.home, size: 30, color: Colors.white),
          const Icon(Icons.menu_book, size: 30, color: Colors.white),
          const Icon(Icons.notification_add, size: 30, color: Colors.white),
        ];
        return SafeArea(
          child: CurvedNavigationBar(
            color: theme.colorScheme.surface,
            //   buttonBackgroundColor: theme.primaryColor,
            backgroundColor:Colors.transparent,
            items: items,
            height: 50,
            index: state.index,
            onTap: (index) {
              context.read<BottomNavigationCubit>().changeIndex(index);
            },
          ),
        );
      },
      listener: (context, state) {

        switch (state.index) {
          case 1:

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
                builder: (_) => Guid(),
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

            break;
        }
      },
    );
  }
}