//
//  File.swift
//  File
//
//  Created by Brandon McQuilkin on 8/26/21.
//

/// Specifies the CPU type of a machine.
public enum MachineType: UInt16, RawRepresentable, Decodable {
    
    // MARK: - Cases
    
    /// The content of this field is assumed to be applicable to any machine type
    case unknown = 0x0
    
    /// Matsushita AM33
    case am33 = 0x1d3
    
    /// x64
    case amd64 = 0x8664
    
    /// ARM little endian
    case arm64 = 0x1c0
    
    /// ARM Thumb-2 little endian
    case armNT = 0x1c4
    
    /// EFI byte code
    case ebc = 0xebc
    
    /// Intel 386 or later processors and compatible processors
    case i386 = 0x14c
    
    /// Intel Itanium processor family
    case ia64 = 0x200
    
    /// Mitsubishi M32R little endian
    case m32R = 0x9041
    
    /// MIPS16
    case mips16 = 0x266
    
    /// MIPS with FPU
    case mipsFpu = 0x366
    
    /// MIPS16 with FPU
    case mipsFpu16 = 0x466
    
    /// Power PC little endian
    case powerPc = 0x1f0
    
    /// Power PC with floating point support
    case powerPcFp = 0x1f1
    
    /// MIPS little endian
    case r4000 = 0x166
    
    /// RISC-V 32-bit address space
    case riscV32 = 0x5032
    
    /// RISC-V 64-bit address space
    case riscV64 = 0x5064
    
    /// RISC-V 128-bit address space
    case riscV128 = 0x5128
    
    /// Hitachi SH3
    case sh3 = 0x1a2
    
    /// Hitachi SH3 DSP
    case sh3Dsp = 0x1a3
    
    /// Hitachi SH4
    case sh4 = 0x1a6
    
    /// Hitachi SH5
    case sh5 = 0x1a8
    
    /// Thumb
    case thumb = 0x1c2
    
    /// MIPS little-endian WCE v2
    case wceMipsV2 = 0x169
    
}


