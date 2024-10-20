import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RxProgressIndicator extends StatefulWidget
    implements PreferredSizeWidget {
  const RxProgressIndicator({super.key, required this.operationRelay});

  final PublishSubject<bool> operationRelay;

  @override
  State<StatefulWidget> createState() => _RxProgressIndicatorState();

  @override
  Size get preferredSize => const Size.fromHeight(3);
}

class _RxProgressIndicatorState extends State<RxProgressIndicator> {
  final CompositeSubscription subscriptions = CompositeSubscription();
  bool _isLoading = true;

  void setIsLoading(bool isLoading) => setState(() {
        _isLoading = isLoading;
      });

  @override
  void initState() {
    super.initState();
    widget.operationRelay.listen(setIsLoading).addTo(subscriptions);
  }

  @override
  void dispose() {
    subscriptions.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: Colors.deepPurple,
      value: _isLoading ? null : 0.0,
    );
  }
}
