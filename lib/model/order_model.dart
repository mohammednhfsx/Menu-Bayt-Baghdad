// lib/model/order_model.dart


import 'package:flutter/material.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:get/get.dart';

enum OrderStatus { newOrder, preparing, ready, delivered }

class OrderModel {
  final String id;
  final String tableNumber;
  final List<OrderItemModel> items;
  final OrderStatus status;
  final DateTime createdAt;
  final double total;
   final RxInt secondsLeft;

  OrderModel({
    required this.id,
    required this.tableNumber,
    required this.items,
    required this.status,
    required this.createdAt,
    required this.total,
     int initialSeconds = 30 * 60,
  }): secondsLeft = RxInt(initialSeconds); 

  // حسابات العداد
  String get timeFormatted {
    final m = secondsLeft.value ~/ 60;
    final s = secondsLeft.value % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get progress => 1 - (secondsLeft.value / (30 * 60));

  bool get isAlmostDone => secondsLeft.value < 5 * 60;

  // تحويل الـ status من نص (Supabase) إلى enum
  static OrderStatus statusFromString(String s) {
    switch (s) {
      case 'preparing': return OrderStatus.preparing;
      case 'ready':     return OrderStatus.ready;
      case 'delivered': return OrderStatus.delivered;
      default:          return OrderStatus.newOrder;
    }
  }

  // معلومات العرض لكل حالة
  static ({String label, Color color, IconData icon})
      statusInfo(OrderStatus status) {
    switch (status) {
      case OrderStatus.newOrder:
        return (label: 'جديد', color:AppColors.blue, icon: Icons.fiber_new);
      case OrderStatus.preparing:
        return (label: 'يُحضَّر', color: AppColors.Orange, icon: Icons.restaurant);
      case OrderStatus.ready:
        return (label: 'جاهز!', color: AppColors.green, icon: Icons.check_circle);
      case OrderStatus.delivered:
        return (label: 'تم التسليم', color: AppColors.greyText, icon: Icons.done_all);
    }
  }
}

class OrderItemModel {
  final String name;
  final int quantity;
  final double price;

  OrderItemModel({
    required this.name,
    required this.quantity,
    required this.price,
  });
}