//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/26/21.
//

import BinaryCodable
import Foundation

public struct CommonObjectFileFormatHeader: Decodable {
    
    // MARK: - Properties
    
    /// The header signature. Must be "PE" to be a proper executable.
    public var signature: String
    
    /// The machine this file targets.
    public var machine: MachineType
    
    /// The size of the section table, which immediately follows the headers.
    public var sectionCount: UInt16
    
    /// The low 32 bits of the number of seconds since 00:00 January 1, 1970, which indicates when the file was created.
    public var timestamp: Date
    
    /// The file offset of the COFF symbol table, or zero if no COFF symbol table is present. This value should be zero for an image because COFF debugging information is deprecated.
    public var symbolTableAddress: UInt32
    
    /// The number of entries in the symbol table. This data can be used to locate the string table, which immediately follows the symbol table. This value should be zero for an image because COFF debugging information is deprecated.
    public var symbolTableLength: UInt32
    
    /// The size of the optional header, which is required for executable files but not for object files. This value should be zero for an object file.
    public var optionalHeaderLength: UInt16
    
    /// The flags that indicate the attributes of the file.
    public var characteristics: Characteristics
    
    // MARK: - Initialization
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer() as! UnkeyedBinaryDecodingContainer
        
        self.signature = try container.decode(String.self, length: 4)
        self.machine = try container.decode(MachineType.self)
        self.sectionCount = try container.decode(UInt16.self)
        
        let rawTimestamp = try container.decode(UInt32.self)
        self.timestamp = Date(timeIntervalSince1970: TimeInterval(rawTimestamp))
        
        self.symbolTableAddress = try container.decode(UInt32.self)
        self.symbolTableLength = try container.decode(UInt32.self)
        self.optionalHeaderLength = try container.decode(UInt16.self)
        self.characteristics = try container.decode(Characteristics.self)
    }
    
}
