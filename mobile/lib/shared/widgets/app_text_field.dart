import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';

/// Standardized text field with consistent styling and validation
class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final String? helperText;
  final String? errorText;
  final bool showCounter;
  final AutovalidateMode autovalidateMode;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.helperText,
    this.errorText,
    this.showCounter = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.contentPadding,
  });

  /// Email input constructor
  const AppTextField.email({
    super.key,
    this.label = 'Email',
    this.hint = 'Enter your email',
    this.initialValue,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.helperText,
    this.errorText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.contentPadding,
  })  : keyboardType = TextInputType.emailAddress,
        textInputAction = TextInputAction.next,
        obscureText = false,
        maxLines = 1,
        minLines = null,
        maxLength = null,
        inputFormatters = null,
        validator = null,
        prefixText = null,
        suffixText = null,
        showCounter = false,
        textCapitalization = TextCapitalization.none,
        textAlign = TextAlign.start;

  /// Password input constructor
  const AppTextField.password({
    super.key,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.initialValue,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefixIcon,
    this.helperText,
    this.errorText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.contentPadding,
  })  : keyboardType = TextInputType.visiblePassword,
        textInputAction = TextInputAction.done,
        obscureText = true,
        maxLines = 1,
        minLines = null,
        maxLength = null,
        inputFormatters = null,
        validator = null,
        suffixIcon = null,
        prefixText = null,
        suffixText = null,
        showCounter = false,
        textCapitalization = TextCapitalization.none,
        textAlign = TextAlign.start;

  /// Phone input constructor
  AppTextField.phone({
    super.key,
    this.label = 'Phone Number',
    this.hint = '024 123 4567',
    this.initialValue,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.suffixIcon,
    this.helperText,
    this.errorText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.contentPadding,
  })  : keyboardType = TextInputType.phone,
        textInputAction = TextInputAction.next,
        obscureText = false,
        maxLines = 1,
        minLines = null,
        maxLength = 15,
        inputFormatters = [FilteringTextInputFormatter.digitsOnly],
        validator = null,
        prefixIcon = const Icon(Icons.phone),
        prefixText = '+233',
        suffixText = null,
        showCounter = false,
        textCapitalization = TextCapitalization.none,
        textAlign = TextAlign.start;

  /// Search input constructor
  const AppTextField.search({
    super.key,
    this.label,
    this.hint = 'Search...',
    this.initialValue,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.suffixIcon,
    this.helperText,
    this.errorText,
    this.contentPadding,
  })  : keyboardType = TextInputType.text,
        textInputAction = TextInputAction.search,
        obscureText = false,
        maxLines = 1,
        minLines = null,
        maxLength = null,
        inputFormatters = null,
        validator = null,
        prefixIcon = const Icon(Icons.search),
        prefixText = null,
        suffixText = null,
        showCounter = false,
        autovalidateMode = AutovalidateMode.disabled,
        textCapitalization = TextCapitalization.none,
        textAlign = TextAlign.start;

  /// Multiline text area constructor
  const AppTextField.multiline({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.enabled = true,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.helperText,
    this.errorText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textCapitalization = TextCapitalization.sentences,
    this.contentPadding,
  })  : keyboardType = TextInputType.multiline,
        textInputAction = TextInputAction.newline,
        obscureText = false,
        maxLines = null,
        minLines = 3,
        inputFormatters = null,
        validator = null,
        prefixIcon = null,
        suffixIcon = null,
        prefixText = null,
        suffixText = null,
        showCounter = true,
        textAlign = TextAlign.start;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          initialValue: widget.initialValue,
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          autovalidateMode: widget.autovalidateMode,
          textCapitalization: widget.textCapitalization,
          textAlign: widget.textAlign,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: widget.enabled ? AppColors.textPrimary : AppColors.textTertiary,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textTertiary,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: _buildSuffixIcon(),
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            helperText: widget.helperText,
            errorText: widget.errorText,
            counterText: widget.showCounter ? null : '',
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: widget.enabled 
                ? (_hasFocus ? AppColors.surface : AppColors.surfaceVariant)
                : AppColors.surfaceVariant.withValues(alpha: 0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border.withValues(alpha: 0.5)),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        onPressed: _toggleObscureText,
        icon: Icon(
          _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.textTertiary,
        ),
      );
    }
    return widget.suffixIcon;
  }
}