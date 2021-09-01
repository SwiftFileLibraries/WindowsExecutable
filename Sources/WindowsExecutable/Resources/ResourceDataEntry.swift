//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/31/21.
//

import Foundation
import BinaryCodable

public struct ResourceDataEntry: Decodable {
    
    // MARK: - Properties
    
    /// The data of the entry.
    var data: Data
    
    var unicodeCodePage: UInt32
    
    // MARK: - Initialization
    
    public init(from decoder: Decoder) throws {
        throw DecodingError.valueNotFound(ResourceDirectoryEntry.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                             debugDescription: "The initial index of the resource directory entry is required, otherwise all data can not be decoded. Use init(from decoder: Decoder, initialIndex: Int) instead.",
                                                                                             underlyingError: nil))
    }
    
    internal init(from decoder: Decoder, initialIndex: Int) throws {
        var container = try decoder.unkeyedContainer() as! UnkeyedBinaryDecodingContainer
        
        guard let virtualAddress = decoder.userInfo[ResourceDirectory.virtualAddressKey] as? Int else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: container.codingPath,
                                                                              debugDescription: "The user info dictionary did not contain one of the necessary values: initialIndex or virtualAddress",
                                                                              underlyingError: nil))
        }
        
        let dataAddress = try container.decode(UInt32.self)
        let dataSize = try container.decode(UInt32.self)
        self.unicodeCodePage = try container.decode(UInt32.self)
        try container.incrementIndex(by: 4)
        
        let originalCurrentIndex = container.currentIndex
        try container.incrementIndex(by: Int(dataAddress) - virtualAddress - initialIndex - 16)
        
        self.data = try container.decode(Data.self, length: Int(dataSize))
        try container.incrementIndex(by: originalCurrentIndex - container.currentIndex)
    }
    
}
