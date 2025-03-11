import SwiftUI

extension URL {
    var formatted: String {
        (host ?? "").replacingOccurrences(of: "www.", with: "")
    }
}

extension Int {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Date {
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

extension Color {
    static var teal: Color {
        Color(UIColor.systemTeal)
    }
}

extension Encodable {
    func toJSONString() -> String {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(self)
            let s = String(decoding: data, as: UTF8.self)
            return s
        } catch {
            return error.localizedDescription
        }
    }
}

private let iso8601FormatterWithFractionalSecs: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    return formatter
}()

private let iso8601FormatterWithoutFractionalSecs: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter
}()

// from Karasta
class KSJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        self.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let stringValue = try container.decode(String.self)

            // Date formatter:
            // We receive two formatter within reponse.
            // 1. `yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ`
            // 2. `yyyy-MM-dd'T'HH:mm:ssZ`, very rear case, 1/1000000 maybe
            // So, do date decode with `yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ`,
            // if failed, try the `yyyy-MM-dd'T'HH:mm:ssZ`,
            // otherwise throw the decoding error.
            if let date = iso8601FormatterWithFractionalSecs.date(from: stringValue) {
                return date
            } else if let date = iso8601FormatterWithoutFractionalSecs.date(from: stringValue) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Error when decode date: \(stringValue)"
                )
            }
        }
        self.keyDecodingStrategy = .convertFromSnakeCase
    }
}

// from ChatGPT
class KSJSONEncoder: JSONEncoder {
    override init() {
        super.init()
        self.outputFormatting = [.prettyPrinted, .sortedKeys]
        self.keyEncodingStrategy = .convertToSnakeCase
        self.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            let dateString = iso8601FormatterWithFractionalSecs.string(from: date)
            try container.encode(dateString)
        }
    }
}

