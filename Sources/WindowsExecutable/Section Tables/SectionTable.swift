//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/28/21.
//

import Foundation

public struct SectionTable {
    
    // MARK: - Properties
    
    /// The header of the section.
    public var header: SectionTableHeader
    
    /// The raw data contained by the section.
    public var data: Data
    
    // MARK: - Initialization
    
    public init(header: SectionTableHeader, data: Data) throws {
        self.header = header
        self.data = data
    }
    
}
