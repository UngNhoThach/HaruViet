enum SelectAddressStep {
  city('Thành phố'),
  district('Quận/Huyện'),
  ward('Phường/Xã'),
  address('Phường/Xã');

  const SelectAddressStep(this.value);

  final String value;
}
