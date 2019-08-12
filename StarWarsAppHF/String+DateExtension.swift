import Foundation

extension String {
  public func date() -> Date {
    var date = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    if let isoDate = isoDateFormatter.date(from: self) {
      date = isoDate
    }
    return date
  }
}
