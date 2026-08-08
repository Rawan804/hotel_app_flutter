import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/services/domain/entites/services.dart';
import 'package:hotel_app/features/services/presentation/cubit/services_cubit.dart';
import 'package:hotel_app/l10n/app_localizations.dart';

class ServiceCard extends StatelessWidget {
  final ServiceEntity service;
  final bool isLoading;

  const ServiceCard({
    super.key,
    required this.service,
    required this.isLoading,
  });

  Color _statusColor() {
    switch (service.status) {
      case 'pending':
        return  Colors.red;
      case 'in_progress':
        return Colors.orange;
      case 'done':
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  // String _statusLabel() {
  //   switch (service.status) {
  //     case 'pending':
  //       return 'قيد الانتظار';
  //     case 'in_progress':
  //       return 'جارية';
  //     case 'done':
  //       return 'منتهية';
  //     default:
  //       return service.status;
  //   }
  // }

  IconData _statusIcon() {
    switch (service.status) {
      case 'pending':
        return Icons.hourglass_bottom_rounded;
      case 'in_progress':
        return Icons.autorenew_rounded;
      case 'done':
        return Icons.check_circle_rounded;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l  = AppLocalizations.of(context);
    final color = _statusColor();
    final isDone = service.status == l!.done;
final theme=Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          right: BorderSide(color: color, width: 3), // شريط الحالة الملوّن
          top: BorderSide(color: color, width: 3), // شريط الحالة الملوّن


        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_statusIcon(), color: color, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    service.service_name,
                 style: theme.textTheme.displayMedium?.copyWith( fontSize: 16, fontWeight: FontWeight.w700, ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    service.status,
                    style: theme.textTheme.displayMedium?.copyWith( fontSize: 12, fontWeight: FontWeight.w700,color: color ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                Icon(Icons.location_on,
                    size: 15, color: Colors.brown),
                const SizedBox(width: 4),
                Text(
                  service.service_location,
                  style: theme.textTheme.displayMedium?.copyWith( fontSize: 10, fontWeight: FontWeight.w700, ),
                ),
              ],
            ),
            if (service.details.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                service.details,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.displayMedium?.copyWith( fontSize: 16, fontWeight: FontWeight.w700, ),
              ),
            ],
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildAction(context, color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(BuildContext context, Color color) {
    final theme = Theme.of(context);
   final l = AppLocalizations.of(context);
    if (isLoading) {
      return SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(strokeWidth: 2.2, color: color),
      );
    }

    switch (service.status) {
      case 'pending':
        return Row(
          children: [
            const Spacer(),
            _actionButton(
              theme: theme,
              color: color,
              label: l!.start,
              icon: Icons.play_arrow_rounded,
              onPressed: () =>
                  context.read<ServicesCubit>().startService(service.id),
            ),
          ],
        );
      case 'in_progress':
        return Row(
          children: [
            const Spacer(),
            _actionButton(
              theme: theme,
              color: color,
              label: l!.end,
              icon: Icons.timelapse_sharp,
              onPressed: () =>
                  context.read<ServicesCubit>().endService(service.id),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _actionButton({
    required ThemeData theme,
    required Color color,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(.75)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}