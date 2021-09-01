//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/26/21.
//

import BinaryCodable

public struct DosHeader: Decodable {
    
    // MARK: - Properties
    
    /// The magic number that identifies the file as an executable (`e_magic`)
    public var magicNumber: String
    
    /// The number of bytes on the last page of file. (`e_cblp`)
    public var lastPageByteCount: UInt16
    
    /// The number of pages in the file. (`e_cp`)
    public var numberOfPages: UInt16
    
    /// The number of relocations. (`e_crlc`)
    public var numberOfRelocations: UInt16
    
    /// The size of the header in paragraphs. (`e_cparhdr`)
    public var headerParagraphCount: UInt16
    
    /// The minimum extra paragraphs needed. (`e_minalloc`)
    public var minimumExtraParagraphsCount: UInt16
    
    /// The maximum extra paragraphs needed. (`e_maxalloc`)
    public var maximumExtraParagraphsCount: UInt16
    
    /// The initial (relative) SS value. (`e_ss`)
    public var initialSSValue: UInt16
    
    /// The initial SP value. (`e_sp`)
    public var initialSPValue: UInt16
    
    /// The checksum of the file. (`e_csum`)
    public var checksum: UInt16
    
    /// The initial IP value. (`e_ip`)
    public var initialIPValue: UInt16
    
    /// The initial (relative) CS value. (`e_cs`)
    public var initialCSValue: UInt16
    
    /// The file address of the relocation table. (`e_lfarlc`)
    public var relocationTableFileAddress: UInt16
    
    /// The overlay number. (`e_ovno`)
    public var overlayNumber: UInt16
    
    /// The reserved words. (`e_res`)
    public var reservedWords: (UInt16, UInt16, UInt16, UInt16)
    
    /// The OEM identifier for the OEM information. (`e_oemid`)
    public var oemIdentifier: UInt16
    
    /// The OEM information. This is specific to the OEM identifier provided. (`e_oeminfo`)
    public var oemInformation: UInt16
    
    /// Additional reserved words. (`e_res2`)
    public var reservedWords2: (UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16)
    
    /// The file address of the new EXE header. (`e_lfanew`)
    public var newHeaderAddress: UInt32
    
    // MARK: - Initialization
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer() as! UnkeyedBinaryDecodingContainer
        
        self.magicNumber = try container.decode(String.self, length: 2)
        self.lastPageByteCount = try container.decode(UInt16.self)
        self.numberOfPages = try container.decode(UInt16.self)
        self.numberOfRelocations = try container.decode(UInt16.self)
        self.headerParagraphCount = try container.decode(UInt16.self)
        self.minimumExtraParagraphsCount = try container.decode(UInt16.self)
        self.maximumExtraParagraphsCount = try container.decode(UInt16.self)
        self.initialSSValue = try container.decode(UInt16.self)
        self.initialSPValue = try container.decode(UInt16.self)
        self.checksum = try container.decode(UInt16.self)
        self.initialIPValue = try container.decode(UInt16.self)
        self.initialCSValue = try container.decode(UInt16.self)
        self.relocationTableFileAddress = try container.decode(UInt16.self)
        self.overlayNumber = try container.decode(UInt16.self)
        
        let rw1 = try container.decode(UInt16.self)
        let rw2 = try container.decode(UInt16.self)
        let rw3 = try container.decode(UInt16.self)
        let rw4 = try container.decode(UInt16.self)
        self.reservedWords = (rw1, rw2, rw3, rw4)
        
        self.oemIdentifier = try container.decode(UInt16.self)
        self.oemInformation = try container.decode(UInt16.self)
        
        let rw21 = try container.decode(UInt16.self)
        let rw22 = try container.decode(UInt16.self)
        let rw23 = try container.decode(UInt16.self)
        let rw24 = try container.decode(UInt16.self)
        let rw25 = try container.decode(UInt16.self)
        let rw26 = try container.decode(UInt16.self)
        let rw27 = try container.decode(UInt16.self)
        let rw28 = try container.decode(UInt16.self)
        let rw29 = try container.decode(UInt16.self)
        let rw210 = try container.decode(UInt16.self)
        self.reservedWords2 = (rw21, rw22, rw23, rw24, rw25, rw26, rw27, rw28, rw29, rw210)
        
        self.newHeaderAddress = try container.decode(UInt32.self)
    }
    
}
