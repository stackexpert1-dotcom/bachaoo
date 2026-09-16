import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bachaoo/common_widgets/business_code_digits_row.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class BusinessCodeInput extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String initialValue;
  final double boxSize;

  /// Optional externally-owned [FocusNode], shared with the parent so the
  /// parent can programmatically dismiss the software keyboard (by calling
  /// [FocusNode.unfocus]) without reaching into this widget's state.
  ///
  /// When null (the default), the widget creates and owns its own node.
  final FocusNode? focusNode;

  /// When true, the widget gives up focus (closing the software keyboard) as
  /// soon as the 4th digit is entered. Useful for flows where the next action
  /// is a confirm button that would otherwise inherit the open keyboard.
  final bool unfocusOnComplete;

  const BusinessCodeInput({
    super.key,
    this.onChanged,
    this.onCompleted,
    this.initialValue = '',
    this.boxSize = AppDimensions.businessCodeBoxSize,
    this.focusNode,
    this.unfocusOnComplete = false,
  });

  @override
  State<BusinessCodeInput> createState() => _BusinessCodeInputState();
}

class _BusinessCodeInputState extends State<BusinessCodeInput> {
  late final FocusNode _focusNode;
  late final bool _ownsFocusNode;
  late final VoidCallback _focusListener;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _ownsFocusNode = widget.focusNode == null;
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() => setState(() {}));
    _focusListener = () => setState(() {});
    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_focusListener);
    // External nodes are owned (and disposed) by whoever passed them in.
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final code = _controller.text;
    final focusedIndex = _focusNode.hasFocus ? code.length.clamp(0, 3) : -1;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Stack(
        children: [
          BusinessCodeDigitsRow(
            code: code,
            focusedIndex: focusedIndex,
            boxSize: widget.boxSize,
          ),
          // Captures input but stays invisible — the boxes above are
          // what the person actually sees typing happen into.
          Opacity(
            opacity: 0,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(counterText: ''),
              onChanged: (value) {
                widget.onChanged?.call(value);
                if (value.length == 4) {
                  // Dismiss the software keyboard as soon as the code is
                  // complete, so it is never still open when the parent
                  // reacts (e.g. navigating away on "Confirm"). This also
                  // prevents the keyboard's viewInsets from briefly shrinking
                  // the next screen and triggering a layout overflow.
                  if (widget.unfocusOnComplete) {
                    _focusNode.unfocus();
                  }
                  widget.onCompleted?.call(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
