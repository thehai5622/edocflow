class UrgencyLevel {
  static String getUrgencyLevel(int level) {
    switch (level) {
      case 1:
        return "Hỏa tốc";
      case 2:
        return "Thượng khẩn";
      case 3:
        return "Khẩn";
      default:
        return "Bình thường";
    }
  }
}
