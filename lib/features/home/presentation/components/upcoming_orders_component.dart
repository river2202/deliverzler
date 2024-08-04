import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliverzler/features/home/domain/order.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/extensions/future_extensions.dart';
import '../../../../core/presentation/helpers/localization_helper.dart';
import '../../../../core/presentation/routing/app_router.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../../../../core/presentation/utils/fp_framework.dart';
import '../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../core/presentation/widgets/loading_widgets.dart';
import '../../../../core/presentation/widgets/platform_widgets/platform_refresh_indicator.dart';
import '../../../../core/presentation/widgets/seperated_sliver_child_builder_delegate.dart';
import '../../domain/value_objects.dart';
import '../providers/selected_order_provider.dart';
import '../providers/upcoming_orders_provider.dart';
import '../providers/update_delivery_status_provider/update_delivery_status_provider.dart';
import 'card_item_component.dart';

class UpcomingOrdersComponent extends ConsumerWidget {
  const UpcomingOrdersComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return getWidget([
    //   AppOrder(
    //     id: 'id1',
    //     date: DateTime(2014, 08, 01, 10).millisecondsSinceEpoch,
    //     pickupOption: PickupOption.delivery,
    //     paymentMethod: 'card',
    //     address: const Address(
    //       street: 'Kingsway',
    //       city: 'Glen Waverley',
    //       state: 'VIC',
    //       mobile: '123456',
    //       geoPoint: const GeoPoint(37.33773013 + 0.0005, -122.02788954 + 0.0005),
    //     ),
    //     userId: 'userId',
    //     userName: 'Peter',
    //     userImage:
    //         'https://cdn.shopify.com/s/files/1/0617/0915/6559/files/driver01.png?v=1722658491',
    //     userPhone: 'userPhone',
    //     userNote: 'userNote',
    //     employeeCancelNote: 'employeeCancelNote',
    //     deliveryStatus: DeliveryStatus.delivered,
    //     deliveryId: 'deliveryId1',
    //     deliveryGeoPoint: const GeoPoint(37.33773013 + 0.005, -122.02788954),
    //   ),
    //   AppOrder(
    //     id: 'id2',
    //     date: DateTime(2014, 08, 01, 10, 10).millisecondsSinceEpoch,
    //     pickupOption: PickupOption.delivery,
    //     paymentMethod: 'card',
    //     address: const Address(
    //       street: 'Kingsway',
    //       city: 'Glen Waverley',
    //       state: 'VIC',
    //       mobile: '123456',
    //       geoPoint: GeoPoint(37.33773013 + 0.0005, -122.02788954 + 0.0005),
    //     ),
    //     userId: 'userId',
    //     userName: 'George',
    //     userImage:
    //         'https://cdn.shopify.com/s/files/1/0617/0915/6559/files/driver02.png?v=1722658491',
    //     userPhone: 'userPhone',
    //     userNote: 'userNote',
    //     employeeCancelNote: 'employeeCancelNote',
    //     deliveryStatus: DeliveryStatus.onTheWay,
    //     deliveryId: 'deliveryId2',
    //     deliveryGeoPoint: const GeoPoint(37.33773013 + 0.0005, -122.02788954 + 0.0005),
    //   ),
    //   AppOrder(
    //     id: 'id3',
    //     date: DateTime(2014, 08, 01, 10).millisecondsSinceEpoch,
    //     pickupOption: PickupOption.delivery,
    //     paymentMethod: 'card',
    //     address: const Address(
    //       street: 'Kingsway',
    //       city: 'Glen Waverley',
    //       state: 'VIC',
    //       mobile: '123456',
    //       geoPoint: const GeoPoint(37.33773013 + 0.0005, -122.02788954 + 0.0005),
    //     ),
    //     userId: 'userId',
    //     userName: 'Chris',
    //     userImage:
    //         'https://cdn.shopify.com/s/files/1/0617/0915/6559/files/driver03.png?v=1722658492',
    //     userPhone: 'userPhone',
    //     userNote: 'userNote',
    //     employeeCancelNote: 'employeeCancelNote',
    //     deliveryStatus: DeliveryStatus.upcoming,
    //     deliveryId: 'deliveryId3',
    //     deliveryGeoPoint: const GeoPoint(37.33773013 + 0.0005, -122.02788954 + 0.0005),
    //   ),
    // ], context);

    ref.easyListen(
      updateDeliveryStatusControllerProvider,
      whenData: (state) {
        state.whenOrNull(
          success: (orderId, deliveryStatus) async {
            if (deliveryStatus != DeliveryStatus.onTheWay) return;
            ref.read(selectedOrderIdProvider.notifier).update((_) => Some(orderId));
            const MapRoute().go(context);
          },
        );
      },
    );

    final upcomingOrdersAsync = ref.watch(upcomingOrdersProvider);

    Future<void> refresh() async {
      return ref.refresh(upcomingOrdersProvider.future).suppressError();
    }

    return upcomingOrdersAsync.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: !upcomingOrdersAsync.hasError,
      data: (upcomingOrders) {
        return PlatformRefreshIndicator(
          onRefresh: refresh,
          slivers: [
            if (upcomingOrders.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.screenPaddingV16,
                  horizontal: Sizes.screenPaddingH28,
                ),
                sliver: SliverList(
                  delegate: SeparatedSliverChildBuilderDelegate(
                    itemBuilder: (BuildContext context, int index) {
                      return CardItemComponent(
                        key: ValueKey(upcomingOrders[index].id),
                        order: upcomingOrders[index],
                      );
                    },
                    itemCount: upcomingOrders.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: Sizes.marginV28,
                      );
                    },
                  ),
                ),
              )
            else
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    tr(context).thereAreNoOrders,
                    style: TextStyles.f18(context),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
      error: (error, st) => PlatformRefreshIndicator(
        onRefresh: refresh,
        slivers: [
          SliverFillRemaining(
            child: Center(
              child: Text(
                '${tr(context).somethingWentWrong}\n${tr(context).pleaseTryAgain}',
                style: TextStyles.f18(context),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      loading: () => const DeliveryLoadingAnimation(),
    );
  }

  Widget getWidget(List<AppOrder> upcomingOrders, BuildContext context) {
    return PlatformRefreshIndicator(
      onRefresh: () async {},
      slivers: [
        if (upcomingOrders.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.screenPaddingV16,
              horizontal: Sizes.screenPaddingH28,
            ),
            sliver: SliverList(
              delegate: SeparatedSliverChildBuilderDelegate(
                itemBuilder: (BuildContext context, int index) {
                  return CardItemComponent(
                    key: ValueKey(upcomingOrders[index].id),
                    order: upcomingOrders[index],
                  );
                },
                itemCount: upcomingOrders.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: Sizes.marginV28,
                  );
                },
              ),
            ),
          )
        else
          SliverFillRemaining(
            child: Center(
              child: Text(
                tr(context).thereAreNoOrders,
                style: TextStyles.f18(context),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
