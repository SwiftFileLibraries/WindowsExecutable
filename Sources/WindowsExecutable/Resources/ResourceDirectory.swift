//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/29/21.
//

import Foundation
import BinaryCodable

public struct ResourceDirectory: Decodable {
    
    // MARK: - Constants
    
    public static let virtualAddressKey = CodingUserInfoKey(rawValue: "virtualAddress")!
    
    // MARK: - Properties
    
    /// Not used.
    public var characteristics: UInt32
    
    /// The time the resource directory was created.
    public var timestamp: Date
    
    /// The major version of the resource.
    public var majorVersion: UInt16
    
    /// The minor version of the resource.
    public var minorVersion: UInt16
    
    /// The number of named entries in the directory.
    public var numberOfNamedEntries: UInt16
    
    /// The number of resources referenced by an identifier in the directory.
    public var numberOfIdEntries: UInt16
    
    /// The entries contained by the directory.
    public var entries: [ResourceDirectoryEntry]
    
    // MARK: - Initialization
    
    public init(decodeFrom section: SectionTable) throws {
        let decoder = BinaryDecoder()
        decoder.userInfo = [
            ResourceDirectory.virtualAddressKey: Int(section.header.virtualAddress),
        ]
        self = try decoder.decode(ResourceDirectory.self, from: section.data)
    }
    
    public init(from decoder: Decoder) throws {
        try self.init(from: decoder, initialIndex: 0)
    }
    
    internal init(from decoder: Decoder, initialIndex: Int) throws {
        var container = try decoder.unkeyedContainer() as! UnkeyedBinaryDecodingContainer
        
        self.characteristics = try container.decode(UInt32.self)
        
        let rawTimestamp = try container.decode(UInt32.self)
        self.timestamp = Date(timeIntervalSince1970: TimeInterval(rawTimestamp))
        
        self.majorVersion = try container.decode(UInt16.self)
        self.minorVersion = try container.decode(UInt16.self)
        self.numberOfNamedEntries = try container.decode(UInt16.self)
        self.numberOfIdEntries = try container.decode(UInt16.self)
        
        var entries: [ResourceDirectoryEntry] = []
        for _ in 0..<(numberOfNamedEntries + numberOfIdEntries) {
            let newDecoder = try container.superDecoder()
            let entry = try ResourceDirectoryEntry(from: newDecoder, initialIndex: initialIndex + container.currentIndex)
            entries.append(entry)
        }
        self.entries = entries
    }
    
}
