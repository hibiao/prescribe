import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxWidget<T extends GetxController> extends StatefulWidget {
  final Widget Function(T value) builder;
  final T model;
  final Function(T) onModelReady;

  const GetxWidget({Key? key, required this.builder, required this.model, required this.onModelReady}) : super(key: key);

  @override
  State<GetxWidget<T>> createState() => _GetxWidgetState();
}

class _GetxWidgetState<T extends GetxController> extends State<GetxWidget<T>> {

  @override
  void initState() {
    super.initState();
    widget.onModelReady(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      init: widget.model,
      builder: (T controller) {
      return widget.builder(controller);
    },);
  }
}

