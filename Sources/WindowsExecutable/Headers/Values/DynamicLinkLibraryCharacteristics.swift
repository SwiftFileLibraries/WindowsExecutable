//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/27/21.
//

public struct DynamicLinkLibraryCharacteristics: OptionSet, Decodable {
    
    // MARK: - Properties
    
    public var rawValue: UInt16
    
    // MARK: - Initialization
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    // MARK: - Options
    
    /// Image can handle a high entropy 64-bit virtual address space.
    public static let highEntropyVirtualAddressSpace = DynamicLinkLibraryCharacteristics(rawValue: 0x0020)
    
    /// DLL can be relocated at load time.
    public static let dynamicBase = DynamicLinkLibraryCharacteristics(rawValue: 0x0040)
    
    /// Code Integrity checks are enforced.
    public static let forceIntegrity = DynamicLinkLibraryCharacteristics(rawValue: 0x0080)
    
    /// Image is NX compatible.
    public static let nxCompatible = DynamicLinkLibraryCharacteristics(rawValue: 0x0100)
    
    /// Isolation aware, but do not isolate the image.
    public static let noIsolation = DynamicLinkLibraryCharacteristics(rawValue: 0x0200)
    
    /// Does not use structured exception (SE) handling. No SE handler may be called in this image.
    public static let noStructuredExceptionHandling = DynamicLinkLibraryCharacteristics(rawValue: 0x0400)
    
    /// Do not bind the image.
    public static let noBind = DynamicLinkLibraryCharacteristics(rawValue: 0x0800)
    
    /// Image must execute in an AppContainer.
    public static let executeInAppContainer = DynamicLinkLibraryCharacteristics(rawValue: 0x1000)
    
    /// A WDM driver.
    public static let wdmDriver = DynamicLinkLibraryCharacteristics(rawValue: 0x2000)
    
    /// Image supports Control Flow Guard.
    public static let supportsControlFlowGuard = DynamicLinkLibraryCharacteristics(rawValue: 0x4000)
    
    /// Terminal Server aware.
    public static let terminalServerAware = DynamicLinkLibraryCharacteristics(rawValue: 0x8000)
    
}
