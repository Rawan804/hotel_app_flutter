import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/Auth/data/datasource/auth_local_datasource.dart';
import 'package:hotel_app/features/news/presentation/widgets/BottomBar/bottombar.dart';
import 'package:hotel_app/features/news/presentation/widgets/HeaderCard.dart';
import 'package:hotel_app/features/news/presentation/widgets/NewsCards.dart';
import 'package:hotel_app/features/tasks/presentation/pages/TasksPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/util/date_formatter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../tasks/domain/entites/task.dart';
import '../../../tasks/presentation/cubit/task_details_cubit.dart';
import '../../../tasks/presentation/cubit/task_details_state.dart';
import '../cubit/news_cubit.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NewsCubit>().getAllNews();
      context.read<TaskDetailsCubit>().getAllTask();
    });
  }

  Future<Map<String, String?>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'image': prefs.getString('image'),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: const Bottombar(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            context.read<NewsCubit>().getAllNews(),
            context.read<TaskDetailsCubit>().getAllTask(),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TaskDetailsCubit, TaskState>(
                builder: (context, state) {
                  List<TaskEntity> tasks = [];

                  if (state is TaskSuccses) {
                    tasks = state.tasks;
                  } else if (state is TaskToggle) {
                    tasks = context.read<TaskDetailsCubit>().cachedTasks;
                  }

                  final totalTasks = tasks.length;

                  final completedTasks = tasks
                      .where((task) => isTaskCompleted(task.status))
                      .length;

                  return FutureBuilder<Map<String, String?>>(
                    future: _getUserData(),
                    builder: (context, snapshot) {
                      return HeaderCard(
                        name: snapshot.data?['name'] ?? '',
                        imageUrl: snapshot.data?['image'] ??
                            'https://i.pravatar.cc/179',
                        totalItems: totalTasks,
                        completedItems: completedTasks,
                      );
                    },
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  right: 30,
                  left: 20,
                  bottom: 8,
                ),
                child: Text(
                  l.hotelNews,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(
                height: 220,
                child: Newscards(),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  l.yourTasks,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontSize: 18,
                  ),
                ),
              ),

              TasksPage(),
            ],
          ),
        ),
      ),
    );
  }
}