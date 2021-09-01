//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/28/21.
//

import Foundation

public struct SectionTableCharacteristics: OptionSet, RawRepresentable, Decodable, Hashable {
    
    // MARK: - Properties
    
    public var rawValue: UInt32
    
    // MARK: - Initialization
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    // MARK: - Cases
    
    /// The section should not be padded to the next boundary.
    ///
    /// This flag is obsolete and is replaced by IMAGE_SCN_ALIGN_1BYTES. This is valid only for object files.
    public static let noPadding = SectionTableCharacteristics(rawValue: 0x00000008)
    
    /// The section contains executable code.
    public static let containsCode = SectionTableCharacteristics(rawValue: 0x00000020)
    
    /// The section contains initialized data.
    public static let containsInitializedData = SectionTableCharacteristics(rawValue: 0x00000040)
    
    /// The section contains uninitialized data.
    public static let containsUninitializedData = SectionTableCharacteristics(rawValue: 0x00000080)
    
    /// The section contains comments or other information.
    ///
    /// The `.drectve` section has this type. This is valid for object files only.
    public static let info = SectionTableCharacteristics(rawValue: 0x00000200)
    
    /// The section will not become part of the image. This is valid only for object files.
    public static let remove = SectionTableCharacteristics(rawValue: 0x00000800)
    
    /// The section contains COMDAT data. This is valid only for object files.
    public static let commonData = SectionTableCharacteristics(rawValue: 0x00001000)
    
    /// The section contains data referenced through the global pointer (GP).
    public static let globalPointerReferencedData = SectionTableCharacteristics(rawValue: 0x00008000)
    
    /// Align data on a 1-byte boundary. Valid only for object files.
    public static let alignTo1Byte = SectionTableCharacteristics(rawValue: 0x00100000)
    
    /// Align data on a 2-byte boundary. Valid only for object files.
    public static let alignTo2Bytes = SectionTableCharacteristics(rawValue: 0x00200000)
    
    /// Align data on a 4-byte boundary. Valid only for object files.
    public static let alignTo4Bytes = SectionTableCharacteristics(rawValue: 0x00300000)
    
    /// Align data on an 8-byte boundary. Valid only for object files.
    public static let alignTo8Bytes = SectionTableCharacteristics(rawValue: 0x00400000)
    
    /// Align data on a 16-byte boundary. Valid only for object files.
    public static let alignTo16Bytes = SectionTableCharacteristics(rawValue: 0x00500000)
    
    /// Align data on a 32-byte boundary. Valid only for object files.
    public static let alignTo32Bytes = SectionTableCharacteristics(rawValue: 0x00600000)
    
    /// Align data on a 64-byte boundary. Valid only for object files.
    public static let alignTo64Bytes = SectionTableCharacteristics(rawValue: 0x00700000)
    
    /// Align data on a 128-byte boundary. Valid only for object files.
    public static let alignTo128Bytes = SectionTableCharacteristics(rawValue: 0x00800000)
    
    /// Align data on a 256-byte boundary. Valid only for object files.
    public static let alignTo256Bytes = SectionTableCharacteristics(rawValue: 0x00900000)
    
    /// Align data on a 512-byte boundary. Valid only for object files.
    public static let alignTo512Bytes = SectionTableCharacteristics(rawValue: 0x00A00000)
    
    /// Align data on a 1024-byte boundary. Valid only for object files.
    public static let alignTo1024Bytes = SectionTableCharacteristics(rawValue: 0x00B00000)
    
    /// Align data on a 2048-byte boundary. Valid only for object files.
    public static let alignTo2048Bytes = SectionTableCharacteristics(rawValue: 0x00C00000)
    
    /// Align data on a 4096-byte boundary. Valid only for object files.
    public static let alignTo4096Bytes = SectionTableCharacteristics(rawValue: 0x00D00000)
    
    /// Align data on an 8192-byte boundary. Valid only for object files.
    public static let alignTo8192Bytes = SectionTableCharacteristics(rawValue: 0x00E00000)
    
    /// The section contains extended relocations.
    public static let containsExtendedRelocations = SectionTableCharacteristics(rawValue: 0x01000000)
    
    /// The section can be discarded as needed.
    public static let discardable = SectionTableCharacteristics(rawValue: 0x02000000)
    
    /// The section cannot be cached.
    public static let doNotCache = SectionTableCharacteristics(rawValue: 0x04000000)
    
    /// The section is not pageable.
    public static let notPageable = SectionTableCharacteristics(rawValue: 0x08000000)
    
    /// The section can be shared in memory.
    public static let shareable = SectionTableCharacteristics(rawValue: 0x10000000)
    
    /// The section can be executed as code.
    public static let `executable` = SectionTableCharacteristics(rawValue: 0x20000000)
    
    /// The section can be read.
    public static let readable = SectionTableCharacteristics(rawValue: 0x40000000)
    
    /// The section can be written to.
    public static let writable = SectionTableCharacteristics(rawValue: 0x80000000)
    
    // MARK: - Descriptions
    
    static var debugDescriptions: [SectionTableCharacteristics: String] = {
        var descriptions = [SectionTableCharacteristics: String]()
        descriptions[.noPadding] = "noPadding"
        descriptions[.containsCode] = "containsCode"
        descriptions[.containsInitializedData] = "containsInitializedData"
        descriptions[.containsUninitializedData] = "containsUninitializedData"
        descriptions[.info] = "info"
        descriptions[.remove] = "remove"
        descriptions[.commonData] = "commonData"
        descriptions[.globalPointerReferencedData] = "globalPointerReferencedData"
        descriptions[.alignTo1Byte] = "alignTo1Byte"
        descriptions[.alignTo2Bytes] = "alignTo2Bytes"
        descriptions[.alignTo4Bytes] = "alignTo4Bytes"
        descriptions[.alignTo8Bytes] = "alignTo8Bytes"
        descriptions[.alignTo16Bytes] = "alignTo16Bytes"
        descriptions[.alignTo32Bytes] = "alignTo32Bytes"
        descriptions[.alignTo64Bytes] = "alignTo64Bytes"
        descriptions[.alignTo128Bytes] = "alignTo128Bytes"
        descriptions[.alignTo256Bytes] = "alignTo256Bytes"
        descriptions[.alignTo512Bytes] = "alignTo512Bytes"
        descriptions[.alignTo1024Bytes] = "alignTo1024Bytes"
        descriptions[.alignTo2048Bytes] = "alignTo2048Bytes"
        descriptions[.alignTo4096Bytes] = "alignTo4096Bytes"
        descriptions[.alignTo8192Bytes] = "alignTo8192Bytes"
        descriptions[.containsExtendedRelocations] = "containsExtendedRelocations"
        descriptions[.discardable] = "discardable"
        descriptions[.doNotCache] = "doNotCache"
        descriptions[.notPageable] = "notPageable"
        descriptions[.shareable] = "shareable"
        descriptions[.executable] = "executable"
        descriptions[.readable] = "readable"
        descriptions[.writable] = "writable"
        return descriptions
    }()
    
    public var description: String {
        var result = [String]()
        for key in SectionTableCharacteristics.debugDescriptions.keys {
            guard self.contains(key), let description = SectionTableCharacteristics.debugDescriptions[key] else {
                continue
            }
            result.append(description)
        }
        return "SectionTableCharacteristics(rawValue: \(self.rawValue)) \(result)"
    }
}
