//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/29/21.
//

import Foundation
import BinaryCodable

public struct ResourceDirectoryEntry: Decodable {
    
    // MARK: - Constants
    
    public enum EntryIdentifier {
        case identifier(UInt16)
        case name(String)
    }
    
    public enum DataInformation {
        case directory(ResourceDirectory)
        case data(ResourceDataEntry)
    }
    
    // MARK: - Properties
    
    /// The string name of numerical identifier of the resource.
    public var name: EntryIdentifier
    
    public var data: DataInformation
    
    // MARK: Initialization
    
    public init(from decoder: Decoder) throws {
        throw DecodingError.valueNotFound(ResourceDirectoryEntry.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                             debugDescription: "The initial index of the resource directory entry is required, otherwise all data can not be decoded. Use init(from decoder: Decoder, initialIndex: Int) instead.",
                                                                                             underlyingError: nil))
    }
    
    internal init(from decoder: Decoder, initialIndex: Int) throws {
        var container = try decoder.unkeyedContainer() as! UnkeyedBinaryDecodingContainer
        
        let rawIdentifier = try container.decode(UInt32.self)
        let rawData = try container.decode(UInt32.self)
        
        if (rawIdentifier & 0b10000000000000000000000000000000) == 2147483648 {
            let nameOffset = rawIdentifier & 0b01111111111111111111111111111111
            let originalCurrentIndex = container.currentIndex
            try container.incrementIndex(by: -initialIndex - 8 + Int(nameOffset))
            
            let length = try container.decode(UInt16.self)
            let data = try container.decode(Data.self, length: Int(length) * 2).swapUInt16Data()
            let name = String(data: data, encoding: .utf16)!
            self.name = .name(name)
            
            try container.incrementIndex(by: originalCurrentIndex - container.currentIndex)
        } else {
            self.name = .identifier(UInt16(rawIdentifier & 0xffff))
        }
        
        if (rawData & 0b10000000000000000000000000000000) == 2147483648 {
            let directoryOffset = rawData & 0b01111111111111111111111111111111
            let originalCurrentIndex = container.currentIndex
            try container.incrementIndex(by: -initialIndex - 8 + Int(directoryOffset))
            
            let newDecoder = try container.superDecoder()
            let entry = try ResourceDirectory(from: newDecoder, initialIndex: initialIndex + container.currentIndex)
            self.data = .directory(entry)
            
            try container.incrementIndex(by: originalCurrentIndex - container.currentIndex)
        } else {
            let entryOffset = rawData
            let originalCurrentIndex = container.currentIndex
            try container.incrementIndex(by: -initialIndex - 8 + Int(entryOffset))
            
            let newDecoder = try container.superDecoder()
            let entry = try ResourceDataEntry(from: newDecoder, initialIndex: initialIndex + container.currentIndex)
            self.data = .data(entry)
            
            try container.incrementIndex(by: originalCurrentIndex - container.currentIndex)
        }
    }
    
}
