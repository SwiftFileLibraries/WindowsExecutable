# WindowsExecutable

A set of data structures and initialization code that can decode a Windows Portable Executable.

## Features

- Decode the the executable headers and section tables.
- Decode the resource section table into the tree of directories and data.

## Usage

### Decoding an Executable

Just use a `BinaryDecoder` to decode the executable like you would when decoding JSON into a data structure.

```swift
let url = URL(fileURLWithPath: "/myExecutable.exe")
let data = try Data(contentsOf: url)

let decoder = BinaryDecoder()

let portableExecutable = try decoder.decode(WindowsPortableExecutable.self, from: data)
```

### Decoding the Resource Section Table

Once the executable is decoded, locate the resources section table and use it to initalize a `ResourceDirectory`. The directory will automatically set up a `BinaryDecoder` under the hood and decode the resources. 

The decoded resources will be a tree of directories and raw data.

```swift
let resourceSectionTable = portableExecutable.sections.first(where: { $0.header.name.contains("rsrc") })!
let decodedResources = try ResourceDirectory(decodeFrom: resourceSectionTable)
```

## Supported Platforms

- iOS 14+
- macOS 11+
- tvOS 14+,
- watchOS 7+
- Any other platform where `Foundation` is available.



 
