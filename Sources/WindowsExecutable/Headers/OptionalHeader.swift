//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/27/21.
//

import BinaryCodable

public struct OptionalHeader: Decodable {
    
    // MARK: - Standard Properties
    
    /// The magic number determines whether an image is a PE32 or PE32+ executable.
    public var executableFormat: PortableExecutableFormat
    
    /// The linker's major version number.
    public var majorLinkerVersion: UInt8
    
    /// The linker's minor version number.
    public var minorLinkerVersion: UInt8
    
    /// The size of the code (text) section, or the sum of all code sections if there are multiple sections.
    public var codeSize: UInt32
    
    /// The size of the initialized data section, or the sum of all such sections if there are multiple data sections.
    public var initializedDataSize: UInt32
    
    /// The size of the uninitialized data section (BSS), or the sum of all such sections if there are multiple BSS sections.
    public var uninitializedDataSize: UInt32
    
    /// The address of the entry point relative to the image base when the executable file is loaded into memory. For program images, this is the starting address. For device drivers, this is the address of the initialization function. An entry point is optional for DLLs. When no entry point is present, this field must be zero.
    public var entryPointAddress: UInt32
    
    /// The address that is relative to the image base of the beginning-of-code section when it is loaded into memory.
    public var baseCodeAddress: UInt32
    
    /// The address that is relative to the image base of the beginning-of-data section when it is loaded into memory.
    public var baseDataAddress: UInt32?
    
    // MARK: - Windows Specific Properties
    
    /// The preferred address of the first byte of image when loaded into memory; must be a multiple of 64 K.
    ///
    /// The default for DLLs is 0x10000000. The default for Windows CE EXEs is 0x00010000. The default for Windows NT, Windows 2000, Windows XP, Windows 95, Windows 98, and Windows Me is 0x00400000.
    public var baseImageAddress: UInt64
    
    /// The alignment (in bytes) of sections when they are loaded into memory. It must be greater than or equal to FileAlignment. The default is the page size for the architecture.
    public var sectionAlignment: UInt32
    
    /// The alignment factor (in bytes) that is used to align the raw data of sections in the image file. The value should be a power of 2 between 512 and 64 K, inclusive. The default is 512. If the SectionAlignment is less than the architecture's page size, then FileAlignment must match SectionAlignment.
    public var fileAlignment: UInt32
    
    /// The major version number of the required operating system.
    public var majorOperatingSystemVersion: UInt16
    
    /// The minor version number of the required operating system.
    public var minorOperatingSystemVersion: UInt16
    
    /// The major version number of the image.
    public var majorImageVersion: UInt16
    
    /// The minor version number of the image.
    public var minorImageVersion: UInt16
    
    /// The major version number of the subsystem.
    public var majorSubsystemVersion: UInt16
    
    /// The minor version number of the subsystem.
    public var minorSubsystemVersion: UInt16
    
    /// Reserved, must be zero.
    public var windows32Version: UInt32
    
    /// The size (in bytes) of the image, including all headers, as the image is loaded in memory. It must be a multiple of SectionAlignment.
    public var imageSize: UInt32
    
    /// The combined size of an MS-DOS stub, PE header, and section headers rounded up to a multiple of FileAlignment.
    public var headerSize: UInt32
    
    /// The image file checksum. The algorithm for computing the checksum is incorporated into IMAGHELP.DLL. The following are checked for validation at load time: all drivers, any DLL loaded at boot time, and any DLL that is loaded into a critical Windows process.
    public var checksum: UInt32
    
    /// The subsystem that is required to run this image. For more information, see Windows Subsystem.
    public var subsystem: WindowsSubsystem
    
    /// The characteristics of the Dynamic Linked Library.
    public var dynamicLinkedLibraryCharacteristics: DynamicLinkLibraryCharacteristics
    
    /// The size of the stack to reserve. Only `stackCommitSize` is committed; the rest is made available one page at a time until the reserve size is reached.
    public var stackReserveSize: UInt64
    
    /// The size of the stack to commit.
    public var stackCommitSize: UInt64
    
    /// The size of the local heap space to reserve. Only `sizeOfHeapCommit` is committed; the rest is made available one page at a time until the reserve size is reached.
    public var heapReserveSize: UInt64
    
    /// The size of the local heap space to commit.
    public var heapCommitSize: UInt64
    
    /// The number of data-directory entries in the remainder of the optional header. Each describes a location and size.
    public var numberOfDataDirectoryEntries: UInt32
    
    /// The data directories entries.
    public var dataDirectories: [DataDirectory]
    
    // MARK: - Initialization
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer() as! UnkeyedBinaryDecodingContainer
        
        self.executableFormat = try container.decode(PortableExecutableFormat.self)
        self.majorLinkerVersion = try container.decode(UInt8.self)
        self.minorLinkerVersion = try container.decode(UInt8.self)
        self.codeSize = try container.decode(UInt32.self)
        self.initializedDataSize = try container.decode(UInt32.self)
        self.uninitializedDataSize = try container.decode(UInt32.self)
        self.entryPointAddress = try container.decode(UInt32.self)
        self.baseCodeAddress = try container.decode(UInt32.self)
        
        if (executableFormat == .pe32) {
            self.baseDataAddress = try container.decode(UInt32.self)
        }
        
        self.baseImageAddress = try executableFormat == .pe32 ? UInt64(container.decode(UInt32.self)) : try container.decode(UInt64.self)
        self.sectionAlignment = try container.decode(UInt32.self)
        self.fileAlignment = try container.decode(UInt32.self)
        self.majorOperatingSystemVersion = try container.decode(UInt16.self)
        self.minorOperatingSystemVersion = try container.decode(UInt16.self)
        self.majorImageVersion = try container.decode(UInt16.self)
        self.minorImageVersion = try container.decode(UInt16.self)
        self.majorSubsystemVersion = try container.decode(UInt16.self)
        self.minorSubsystemVersion = try container.decode(UInt16.self)
        
        self.windows32Version = try container.decode(UInt32.self)
        guard windows32Version == 0 else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "The windows 32 version must be 0.", underlyingError: nil))
        }
        
        self.imageSize = try container.decode(UInt32.self)
        guard imageSize.isMultiple(of: sectionAlignment) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "The image size must be a multiple of the section alignment.", underlyingError: nil))
        }
        
        self.headerSize = try container.decode(UInt32.self)
        guard headerSize.isMultiple(of: fileAlignment) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "The header size must be a multiple of the file alignment.", underlyingError: nil))
        }
        
        self.checksum = try container.decode(UInt32.self)
        self.subsystem = try container.decode(WindowsSubsystem.self)
        self.dynamicLinkedLibraryCharacteristics = try container.decode(DynamicLinkLibraryCharacteristics.self)
        self.stackReserveSize = try executableFormat == .pe32 ? UInt64(container.decode(UInt32.self)) : try container.decode(UInt64.self)
        self.stackCommitSize = try executableFormat == .pe32 ? UInt64(container.decode(UInt32.self)) : try container.decode(UInt64.self)
        self.heapReserveSize = try executableFormat == .pe32 ? UInt64(container.decode(UInt32.self)) : try container.decode(UInt64.self)
        self.heapCommitSize = try executableFormat == .pe32 ? UInt64(container.decode(UInt32.self)) : try container.decode(UInt64.self)
        
        try container.incrementIndex(by: 4)
        
        self.numberOfDataDirectoryEntries = try container.decode(UInt32.self)
        
        var directories: [DataDirectory] = []
        
        for _ in 0..<numberOfDataDirectoryEntries {
            let directory = try container.decode(DataDirectory.self)
            directories.append(directory)
        }
        self.dataDirectories = directories
    }
    
}
