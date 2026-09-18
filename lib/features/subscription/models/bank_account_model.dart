class BankAccountField {
  final String label;
  final String value;

  const BankAccountField({required this.label, required this.value});
}

class BankAccountModel {
  final String bankName;
  final List<BankAccountField> fields;

  const BankAccountModel({required this.bankName, required this.fields});
}
