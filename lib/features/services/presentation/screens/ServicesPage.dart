import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_app/features/news/presentation/widgets/BottomBar/bottombar.dart';
import 'package:hotel_app/features/services/presentation/cubit/services_cubit.dart';
import 'package:hotel_app/features/services/presentation/cubit/services_state.dart';
import 'package:hotel_app/features/services/presentation/widgets/service_filterbar.dart';
import 'package:hotel_app/l10n/app_localizations.dart';
import '../widgets/ServiceCard.dart';
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    return Scaffold(
      bottomNavigationBar: Bottombar(),
      appBar: AppBar(

        title:  Text(l!.serviceFromCustomer,    style: theme.textTheme.displayMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,

        ),),
        backgroundColor: theme.colorScheme.surface,

        elevation: 0,
        centerTitle:false,
      ),
      body: BlocBuilder<ServicesCubit, ServicesState>(
        builder: (context, state) {
          if (state is ServicesLoading || state is ServicesInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ServiceFail) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 42),
                  const SizedBox(height: 10),
                  Text(state.message),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ServicesCubit>().getAllServices(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (state is ServiceSuccess) {
            return RefreshIndicator(
              onRefresh: () => context.read<ServicesCubit>().getAllServices(),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ServiceFilterbar(currentFilter: state.filter),
                  const SizedBox(height: 12),
                  Expanded(
                    child: state.services.isEmpty
                        ? ListView(
                      children: const [
                        SizedBox(height: 120),
                        Center(child: Text('لا يوجد طلبات ')),
                      ],
                    )
                        : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: state.services.length,
                      itemBuilder: (context, index) {
                        final service = state.services[index];
                        return ServiceCard(
                          service: service,
                          isLoading:
                          state.loadingIds.contains(service.id),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}