import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bachaoo/common_widgets/business_code_digits_row.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class BusinessCodeInput extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final String initialValue;
  final double boxSize;

  const BusinessCodeInput({
    super.key,
    this.onChanged,
    this.onCompleted,
    this.initialValue = '',
    this.boxSize = AppDimensions.businessCodeBoxSize,
  });

  @override
  State<BusinessCodeInput> createState() => _BusinessCodeInputState();
}

class _BusinessCodeInputState extends State<BusinessCodeInput> {
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() => setState(() {}));
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
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
                if (value.length == 4) widget.onCompleted?.call(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
