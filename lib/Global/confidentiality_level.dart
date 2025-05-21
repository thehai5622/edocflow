class ConfidentialityLevel {
  static String getConfidentialityLevel(int level) {
    switch (level) {
      case 1:
        return 'Tuyệt mật-A';
      case 2:
        return 'Tối mật-B';
      case 3:
        return 'Mật-C';
      default:
        return 'Bình thường';
    }
  }
}
