import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show DefaultTabController, Theme, Colors, TabBarIndicatorSize, Icons, Tab, TabBar, TabBarView;

import '../../../tasks/presentation/pages/TasksPage.dart';

class Tabbar extends StatelessWidget {
  const Tabbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ───── TITLE ─────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              "Your Task",
              style: theme.textTheme.displayMedium?.copyWith(fontSize: 20),
            ),
          ),

          // ───── TAB BAR ─────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 48,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: theme.dividerColor.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: theme.colorScheme.onSurface,
                unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bolt_rounded, size: 16),
                        const SizedBox(width: 6),
                        const Text("المستعجلة"),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "3",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.calendar_today_rounded, size: 16),
                        SizedBox(width: 6),
                        Text("اليومية"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ───── TAB VIEWS ─────
          Expanded(  // 👈 هذا هو المفتاح
            child: TabBarView(
              children: [
                const Center(child: Text("المهام المستعجلة")),
                TasksPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}