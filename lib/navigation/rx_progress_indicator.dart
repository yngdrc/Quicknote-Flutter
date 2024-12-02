import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RxProgressIndicator extends StatefulWidget {
  const RxProgressIndicator({super.key, required this.operationRelay});

  final PublishSubject<bool> operationRelay;

  @override
  State<StatefulWidget> createState() => _RxProgressIndicatorState();
}

class _RxProgressIndicatorState extends State<RxProgressIndicator> {
  final CompositeSubscription subscriptions = CompositeSubscription();
  bool _isLoading = true;

  void setIsLoading(bool isLoading) => setState(() {
        _isLoading = isLoading;
      });

  @override
  void initState() {
    widget.operationRelay.listen(setIsLoading).addTo(subscriptions);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RxProgressIndicator oldWidget) {
    subscriptions.clear();
    widget.operationRelay.listen(setIsLoading).addTo(subscriptions);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    subscriptions.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isLoading,
      child: const LinearProgressIndicator(
        backgroundColor: Colors.transparent,
        color: Colors.deepPurple,
      ),
    );
  }
}
