
// MARK: Public

public enum EncodeStrategy {
    case normal
    case omitOneDigit
}

/// Encode to RLE string.
/// - Parameters:
///   - string: target string
///   - strategy: encoding strategy
/// - Returns: Encoded string. Return `nil` when encode is failed.
public func encode(_ string: String, strategy: EncodeStrategy = .normal) -> String? {
    guard !string.isEmpty else { return "" }
    
    if string.contains(where: isDigit) {
        return nil
    }
    
    return string.group(by: ==).map {
        let count = $0.count
        let character = $0.first!
        
        if strategy == .omitOneDigit && count == 1 {
            return "\(character)"
        } else {
            return "\(count)\(character)"
        }
    }.joined()
}

/// Decode from RLE string.
/// - Parameter string: Target string that encoded by RLE.
/// - Returns: Decoded string. Return `nil` when decode is failed.
public func decode(_ string: String) -> String? {
    guard !string.isEmpty else { return "" }
    
    if string.allSatisfy(isDigit) || string.last.flatMap(isDigit) == true {
        return nil
    }
    
    return string
        .group {
            (isDigit($0) && !isDigit($1)) || // e.g. "1A"
            (isDigit($0) &&  isDigit($1))    // e.g. "12"
        }
        .map { group in
            if group.count == 1 {
                return "\(group.first!)"
            } else {
                let nums = group.prefix(while: isDigit).map(String.init)
                let count = toDigit(nums.joined())
                let character = group.last!
                return String(repeating: character, count: count)
            }
        }
        .joined()
}

// MARK: Internal

extension Sequence {
    func group(by condition: (Element, Element) -> Bool) -> [[Element]] {
        self.reduce(into: [[Element]]()) { result, element in
            if let latest = result.last?.last, condition(latest, element) {
                var xs = result.removeLast()
                xs.append(element)
                result.append(xs)
            } else {
                result.append([element])
            }
        }
    }
}

func isDigit(_ c: Character) -> Bool {
    Int("\(c)") != nil
}

func toDigit(_ c: Character) -> Int {
    Int("\(c)")!
}

func toDigit(_ s: String) -> Int {
    Int("\(s)")!
}
