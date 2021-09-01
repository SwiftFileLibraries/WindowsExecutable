import BinaryCodable
import Foundation

/// Represents the raw data contained in a Windows portable executable.
public struct WindowsPortableExecutable: Decodable {
    
    // MARK: - Properties
    
    /// The MS-DOS / Real-Mode header.
    public var dosHeader: DosHeader
    
    /// The common obect file format header.
    public var commonObjectFileFormatHeader: CommonObjectFileFormatHeader
    
    /// The optional header of the image.
    public var optionalHeader: OptionalHeader?
    
    /// The sections containing the image data.
    public var sections: [SectionTable]

    // MARK: - Initialization
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer() as! UnkeyedBinaryDecodingContainer
        self.dosHeader = try container.decode(DosHeader.self)
        
        try container.incrementIndex(by: Int(dosHeader.newHeaderAddress) - container.currentIndex)
        self.commonObjectFileFormatHeader = try container.decode(CommonObjectFileFormatHeader.self)
        
        if (commonObjectFileFormatHeader.optionalHeaderLength != 0) {
            let optionalHeaderIndex = container.currentIndex
            self.optionalHeader = try container.decode(OptionalHeader.self)
            let sectionTableStartIndex = optionalHeaderIndex + Int(commonObjectFileFormatHeader.optionalHeaderLength)
            try container.incrementIndex(by: sectionTableStartIndex - container.currentIndex)
        }
        
        var sectionHeaders: [SectionTableHeader] = []
        for _ in 0..<commonObjectFileFormatHeader.sectionCount {
            let header = try container.decode(SectionTableHeader.self)
            sectionHeaders.append(header)
        }
    
        sectionHeaders = sectionHeaders.sorted(by: { $0.rawDataAddress < $1.rawDataAddress })
        var sections: [SectionTable] = []
        for header in sectionHeaders {
            try container.incrementIndex(by: Int(header.rawDataAddress) - container.currentIndex)
            let data: Data = try container.decode(Data.self, length: Int(header.rawDataSize))
            try sections.append(SectionTable(header: header, data: data))
        }
        
        self.sections = sections
    }
    
}


