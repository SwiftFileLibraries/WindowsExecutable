//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/30/21.
//

import Foundation

extension Data {
    
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    internal func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let hexDigits = options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef"
        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            let utf8Digits = Array(hexDigits.utf8)
            return String(unsafeUninitializedCapacity: 2 * self.count) { (ptr) -> Int in
                var p = ptr.baseAddress!
                for byte in self {
                    p[0] = utf8Digits[Int(byte / 16)]
                    p[1] = utf8Digits[Int(byte % 16)]
                    p += 2
                }
                return 2 * self.count
            }
        } else {
            let utf16Digits = Array(hexDigits.utf16)
            var chars: [unichar] = []
            chars.reserveCapacity(2 * self.count)
            for byte in self {
                chars.append(utf16Digits[Int(byte / 16)])
                chars.append(utf16Digits[Int(byte % 16)])
            }
            return String(utf16CodeUnits: chars, count: chars.count)
        }
    }
    
    /// Swaps every other byte in the data.
    func swapUInt16Data() -> Data {
        var mdata = self // make a mutable copy
        let count = self.count / MemoryLayout<UInt16>.size
        mdata.withUnsafeMutableBytes { (i16ptr: UnsafeMutablePointer<UInt16>) in
            for i in 0..<count {
                i16ptr[i] =  i16ptr[i].byteSwapped
            }
        }
        
        return mdata
    }
    
}
