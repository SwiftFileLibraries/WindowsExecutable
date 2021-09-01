//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/26/21.
//

public struct Characteristics: OptionSet, Decodable, CustomStringConvertible, Hashable {
    
    // MARK: - Properties
    
    public var rawValue: UInt16
    
    // MARK: - Initialization
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    // MARK: - Options
    
    /// Indicates that the file does not contain base relocations and must therefore be loaded at its preferred base address. If the base address is not available, the loader reports an error.
    ///
    ///  The default behavior of the linker is to strip base relocations from executable (EXE) files.  Image only, Windows CE, and Microsoft Windows NT and later.
    public static let relocationsStripped = Characteristics(rawValue: 0x0001)
    
    /// Indicates that the image file is valid and can be run. If this flag is not set, it indicates a linker error. Image only.
    public static let executableImage = Characteristics(rawValue: 0x0002)
    
    /// COFF line numbers have been removed. This flag is deprecated and should be zero.
    public static let lineNumbersStripped = Characteristics(rawValue: 0x0004)
    
    /// COFF symbol table entries for local symbols have been removed. This flag is deprecated and should be zero.
    public static let localSymbolsStripped = Characteristics(rawValue: 0x0008)
    
    /// Aggressively trim working set. This flag is deprecated for Windows 2000 and later and must be zero.
    public static let aggressivelyTrimWorkingSet = Characteristics(rawValue: 0x0010)
    
    /// Application can handle > 2-GB addresses.
    public static let largeAddressAware = Characteristics(rawValue: 0x0020)
    
    /// Little endian: the least significant bit (LSB) precedes the most significant bit (MSB) in memory. This flag is deprecated and should be zero.
    public static let bytesReversedLittleEndian = Characteristics(rawValue: 0x0080)
    
    /// Machine is based on a 32-bit-word architecture.
    public static let machine32Bit = Characteristics(rawValue: 0x0100)
    
    /// Debugging information is removed from the image file.
    public static let debuggingInformationStripped = Characteristics(rawValue: 0x0200)
    
    /// If the image is on removable media, fully load it and copy it to the swap file.
    public static let runFromSwapIfRemovable = Characteristics(rawValue: 0x0400)
    
    /// If the image is on network media, fully load it and copy it to the swap file.
    public static let runFromSwapIfNetwork = Characteristics(rawValue: 0x0800)
    
    /// The image file is a system file, not a user program.
    public static let isSystemFile = Characteristics(rawValue: 0x1000)
    
    /// The image file is a dynamic-link library (DLL). Such files are considered executable files for almost all purposes, although they cannot be directly run.
    public static let isDynamicLinkLibrary = Characteristics(rawValue: 0x2000)
    
    /// The file should be run only on a uniprocessor machine.
    public static let onlyRunOnUpSystem = Characteristics(rawValue: 0x4000)
    
    /// Big endian: the MSB precedes the LSB in memory. This flag is deprecated and should be zero.
    public static let bytesReversedBigEndian = Characteristics(rawValue: 0x8000)
    
    // MARK: - Descriptions
    
    static var debugDescriptions: [Characteristics: String] = {
        var descriptions = [Characteristics: String]()
        descriptions[.relocationsStripped] = "relocationsStripped"
        descriptions[.executableImage] = "executableImage"
        descriptions[.lineNumbersStripped] = "lineNumbersStripped"
        descriptions[.localSymbolsStripped] = "localSymbolsStripped"
        descriptions[.aggressivelyTrimWorkingSet] = "aggressivelyTrimWorkingSet"
        descriptions[.largeAddressAware] = "largeAddressAware"
        descriptions[.bytesReversedLittleEndian] = "bytesReversedLittleEndian"
        descriptions[.machine32Bit] = "machine32Bit"
        descriptions[.debuggingInformationStripped] = "debuggingInformationStripped"
        descriptions[.runFromSwapIfRemovable] = "runFromSwapIfRemovable"
        descriptions[.runFromSwapIfNetwork] = "runFromSwapIfNetwork"
        descriptions[.isSystemFile] = "isSystemFile"
        descriptions[.isDynamicLinkLibrary] = "isDynamicLinkLibrary"
        descriptions[.onlyRunOnUpSystem] = "onlyRunOnUpSystem"
        descriptions[.bytesReversedBigEndian] = "bytesReversedBigEndian"
        return descriptions
    }()
    
    public var description: String {
        var result = [String]()
        for key in Characteristics.debugDescriptions.keys {
            guard self.contains(key), let description = Characteristics.debugDescriptions[key] else {
                continue
            }
            result.append(description)
        }
        return "Characteristics(rawValue: \(self.rawValue)) \(result)"
    }
    
}
