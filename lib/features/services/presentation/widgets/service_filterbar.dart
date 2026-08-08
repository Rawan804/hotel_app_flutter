import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/services/presentation/cubit/services_cubit.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

class ServiceFilterbar extends StatelessWidget {
  final String currentFilter;

   ServiceFilterbar({super.key, required this.currentFilter});


  @override
  Widget build(BuildContext context) {

    final l=AppLocalizations.of(context);

    final  _filters = {
      'all': l!.all,
      'pending': l.pending,
      'in_progress': l.in_progress,
      'done':l.done,
    };

    final _colors = {
      'all':Colors.brown,
      'pending': Colors.red,
      'in_progress': Colors.orange,
      'done': Colors.green,
    };
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final key = _filters.keys.elementAt(index);
          final label = _filters[key]!;
          final color = _colors[key]!;
          final isSelected = currentFilter == key;

          return GestureDetector(
            onTap: () => context.read<ServicesCubit>().changeFilter(key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected ? color :Theme.of(context).hoverColor,
                  width: 1.2,
                ),

              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}