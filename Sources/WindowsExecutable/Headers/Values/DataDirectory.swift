//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/28/21.
//

import Foundation

/// Gives the address and size of a table or string that Windows uses.
public struct DataDirectory: Decodable {
    
    // MARK: - Properties
    
    /// The relative virtual address of the table. The relative virtual address is the address of the table relative to the base address of the image when the table is loaded.
    public var virtualAddress: UInt32
    
    /// The size of the directory in bytes.
    public var size: UInt32
    
    // MARK: - Initialization
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.virtualAddress = try container.decode(UInt32.self)
        self.size = try container.decode(UInt32.self)
    }
    
}
