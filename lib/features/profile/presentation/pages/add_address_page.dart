import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Brand tokens (screen-local)
// ---------------------------------------------------------------------------
const _primary = Color(0xFFCF0269);
const _bgLight = Color(0xFFF8F5F7);
const _slate900 = Color(0xFF0F172A);
const _slate500 = Color(0xFF64748B);

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();
  final _stateCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _houseCtrl = TextEditingController();
  final _roadCtrl = TextEditingController();

  bool _isDefault = false;

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _phoneCtrl.dispose();
    _pincodeCtrl.dispose();
    _stateCtrl.dispose();
    _cityCtrl.dispose();
    _houseCtrl.dispose();
    _roadCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: Column(
        children: [
          const _AddAddressAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name
                    _FormField(
                      label: 'Full Name',
                      controller: _fullNameCtrl,
                      hint: 'Enter your full name',
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 4),

                    // Phone Number
                    _PhoneField(controller: _phoneCtrl),
                    const SizedBox(height: 4),

                    // Pincode + State (side by side)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _FormField(
                            label: 'Pincode',
                            controller: _pincodeCtrl,
                            hint: '6-digit pincode',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: _StateField(controller: _stateCtrl)),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // City
                    _FormField(
                      label: 'City',
                      controller: _cityCtrl,
                      hint: 'Enter city',
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 4),

                    // House No. / Building Name
                    _FormField(
                      label: 'House No. / Building Name',
                      controller: _houseCtrl,
                      hint: 'Enter house no. or building name',
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 4),

                    // Road Name / Area / Colony
                    _FormField(
                      label: 'Road Name / Area / Colony',
                      controller: _roadCtrl,
                      hint: 'Enter area details',
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 8),

                    // Set as Default toggle
                    _DefaultToggle(
                      value: _isDefault,
                      onChanged: (v) => setState(() => _isDefault = v),
                    ),
                    const SizedBox(height: 20),

                    // Save Address button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor: _primary.withValues(alpha: 0.25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // TODO: dispatch save address event
                          }
                        },
                        child: const Text(
                          'Save Address',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Use Current Location
                    Center(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: _primary,
                          backgroundColor: _primary.withValues(alpha: 0.10),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        icon: const Icon(Icons.my_location, size: 18),
                        label: const Text(
                          'Use Current Location',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          // TODO: request location permission and auto-fill
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App bar — centered title, balanced back button
// ---------------------------------------------------------------------------

class _AddAddressAppBar extends StatelessWidget {
  const _AddAddressAppBar();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Material(
      color: _bgLight.withValues(alpha: 0.92),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: top),
          SizedBox(
            height: 56,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: pop navigation
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Add Address',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 48), // visual balance
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Generic labeled text field
// ---------------------------------------------------------------------------

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _slate900,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            inputFormatters: inputFormatters,
            readOnly: readOnly,
            onTap: onTap,
            style: const TextStyle(fontSize: 15, color: _slate900),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: _slate500, fontSize: 14),
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _primary.withValues(alpha: 0.20)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _primary.withValues(alpha: 0.20)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _primary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Phone number field with +91 prefix
// ---------------------------------------------------------------------------

class _PhoneField extends StatelessWidget {
  const _PhoneField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: _slate900,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            style: const TextStyle(fontSize: 15, color: _slate900),
            decoration: InputDecoration(
              hintText: 'Enter 10-digit mobile number',
              hintStyle: const TextStyle(color: _slate500, fontSize: 14),
              prefixText: '+91  ',
              prefixStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: _slate500,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _primary.withValues(alpha: 0.20)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: _primary.withValues(alpha: 0.20)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _primary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// State field — read-only with dropdown chevron
// ---------------------------------------------------------------------------

class _StateField extends StatelessWidget {
  const _StateField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return _FormField(
      label: 'State',
      controller: controller,
      hint: 'Select State',
      readOnly: true,
      suffixIcon: const Icon(Icons.expand_more, color: _slate500, size: 22),
      onTap: () {
        // TODO: show state picker bottom sheet
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Set as Default Address toggle row
// ---------------------------------------------------------------------------

class _DefaultToggle extends StatelessWidget {
  const _DefaultToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Set as Default Address',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _slate900,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Use this address for all future orders',
                  style: TextStyle(fontSize: 11, color: _slate500),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: _primary,
            activeTrackColor: _primary.withValues(alpha: 0.30),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFCBD5E1),
          ),
        ],
      ),
    );
  }
}
