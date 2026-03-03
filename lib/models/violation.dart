class Violation {
  final String title;
  final int fineFirst;
  final int fineRepeat;
  final bool licenseSeizable;
  final bool vehicleSeizable;
  final bool receiptMandatory;
  final bool cashAllowed;
  final String simpleExplanation;

  const Violation({
    required this.title,
    required this.fineFirst,
    required this.fineRepeat,
    required this.licenseSeizable,
    required this.vehicleSeizable,
    required this.receiptMandatory,
    required this.cashAllowed,
    required this.simpleExplanation,
  });
}
