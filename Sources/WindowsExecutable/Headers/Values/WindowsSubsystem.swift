//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/27/21.
//

import Foundation

/// The Windows subsystems that images may require.
public enum WindowsSubsystem: UInt16, RawRepresentable, Decodable {
    
    /// An unknown subsystem.
    case unknown = 0
    
    /// Device drivers and native Windows processes.
    case native = 1
    
    /// The Windows graphical user interface (GUI) subsystem.
    case windowsGui = 2
    
    /// The Windows character subsystem.
    case windowsCui = 3
    
    /// The OS/2 character subsystem.
    case os2Cui = 5
    
    /// The Posix character subsystem.
    case posixCui = 7
    
    /// Native Win9x driver.
    case nativeWindows = 8
    
    /// Windows CE.
    case windowsCeGui = 9
    
    /// An Extensible Firmware Interface (EFI) application.
    case efiApplication = 10
    
    /// An EFI driver with boot services.
    case efiBootServiceDriver = 11
    
    /// An EFI driver with run-time services.
    case efiRuntimeDriver = 12
    
    /// An EFI ROM image.
    case efiRomImage = 13
    
    /// XBOX.
    case xbox = 14
    
    /// Windows boot application.
    case windowsBootApplication = 16
    
}

