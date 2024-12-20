// Copyright © 2023 Proxy, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// Modified by AUTHADA GmbH
// Copyright (c) 2024 AUTHADA GmbH
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

/// A protocol that defines a type that can be converted to and from a little-endian byte buffer.
public protocol DataRepresentable {
    /// Initializes an instance of the conforming type from a little-endian byte buffer.
    ///
    /// - Parameter dataRepresentation: A little-endian byte buffer.
    /// - Throws: A `CocoaError` with a `coderInvalidValue` code if the byte buffer has an invalid size.
    init(dataRepresentation: ContiguousBytes) throws

    /// Returns a little-endian byte buffer representation of the conforming type.
    ///
    /// - Returns: A little-endian byte buffer representation of the conforming type.
    var dataRepresentation: Data { get }
}

public extension DataRepresentable {
    /// Initializes an instance of the conforming type from a little-endian byte buffer.
    ///
    /// - Parameter dataRepresentation: A little-endian byte buffer.
    /// - Throws: A `CocoaError` with a `coderInvalidValue` code if the byte buffer has an invalid size.
    init(dataRepresentation: ContiguousBytes) throws {
        self = try dataRepresentation.withUnsafeBytes {
            guard
                $0.count == MemoryLayout<Self>.size,
                let baseAddress = $0.baseAddress
            else {
                throw CocoaError(.coderInvalidValue)
            }
            return baseAddress.bindMemory(to: Self.self, capacity: 1).pointee
        }
    }

    /// Returns a little-endian byte buffer representation of the conforming type.
    ///
    /// - Returns: A little-endian byte buffer representation of the conforming type.
    var dataRepresentation: Data {
        var value = self
        return withUnsafeBytes(of: &value) {
            Data($0)
        }
    }
}

extension UInt32: DataRepresentable {}
extension UInt64: DataRepresentable {}
