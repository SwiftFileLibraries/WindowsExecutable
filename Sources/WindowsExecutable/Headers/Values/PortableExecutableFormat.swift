//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/27/21.
//

/// Determines whether an image is a PE32 or PE32+ executable.
public enum PortableExecutableFormat: UInt16, RawRepresentable, Decodable {
    
    // MARK: - Cases
    
    /// The executable is a PE32 executable
    case pe32 = 0x10b
    
    /// The executable is a PE32+ executable
    case pe32Plus = 0x20b
    
}


