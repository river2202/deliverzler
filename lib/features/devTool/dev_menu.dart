import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../auth/presentation/providers/auth_state_provider.dart';
import '../../../../../core/presentation/styles/styles.dart';
import '../../../../../core/presentation/utils/riverpod_framework.dart';
import '../../../../../core/presentation/widgets/cached_network_image_circular.dart';
import '../home/domain/value_objects.dart';
import '../home/infrastructure/data_sources/orders_remote_data_source.dart';
import '../home/infrastructure/dtos/order_dto.dart';

class DevMenuPage extends ConsumerWidget {
  const DevMenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dev Menu'),
        ),
        body: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.name ?? 'User${user.id.substring(0, 6)}',
                        style:
                            TextStyles.f18(context).copyWith(fontWeight: FontStyles.fontWeightBold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.email,
                        style: TextStyles.f16(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Sizes.marginV2,
                ),
                CachedNetworkImageCircular(
                  imageUrl: user.image,
                  radius: Sizes.imageR28,
                ),
              ],
            ),
            TextButton(
                onPressed: () => _addNewOrder(context, ref), child: const Text('Add new order')),
          ],
        ),
      ),
    );
  }

  Future<void> _addNewOrder(BuildContext context, WidgetRef ref) async {
    final userId = ref.watch(currentUserProvider.select((user) => user.id));
    // final ordersStream = ref.watch(ordersRepoProvider).getOrder(userId);

    final remoteDataSource = ref.read(ordersRemoteDataSourceProvider);
    final allOrders = await remoteDataSource.getAllOrders();
    print('all orders: $allOrders');

    final newOrder = OrderDto(
      userId: userId,
      deliveryId: userId,
      deliveryStatus: DeliveryStatus.upcoming,
      pickupOption: PickupOption.delivery,
      date: DateTime(2024, 08, 04, 11).millisecondsSinceEpoch,
      deliveryGeoPoint: const GeoPoint(37.33296332, -122.03910939),
      paymentMethod: 'cash',
      address: const AddressDto(
        state: 'VIC',
        street: 'Boxhill',
        city: 'AU',
        mobile: '12345678',
        geoPoint: GeoPoint(37.33296332, -122.03910939),
      ),
      userName: 'George',
      userImage: 'https://cdn.shopify.com/s/files/1/0617/0915/6559/files/driver03.png?v=1722658492',
      userPhone: '12345678',
      userNote: 'userNote',
      employeeCancelNote: 'Cancel Note',
    );

    final a = newOrder.toJson();
    print('orderDto.toJson() $a');

    await remoteDataSource.addNewOrder(newOrder);
  }
}
