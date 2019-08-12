import Foundation

extension String {
  public func dateFormatAdjustment(dateString: String) -> String {
    var formatDate = self
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    if let date = formatter.date(from: self) {
      formatter.locale = Locale(identifier: "en_US_POSIX")
      formatter.dateFormat = dateString
      formatDate = formatter.string(from: date)
    }
    return formatDate
  }
}
