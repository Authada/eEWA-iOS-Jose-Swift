/*
 * Copyright 2024 Gonçalo Frade
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import CryptoKit
import Foundation
import JSONWebKey

/// `HS384Signer` provides methods to sign data using the HS384 algorithm.
public struct HS384Signer: Signer {
    
    /// The algorithm used for signing.
    public var algorithm: String { SigningAlgorithm.HS384.rawValue }
    
    /// Signs the given data using the provided symmetric key.
    /// - Parameters:
    ///   - data: The data to be signed.
    ///   - key: The `JWK` containing the symmetric key to use for signing.
    /// - Throws: An error if the symmetric key is not valid or if the signing process fails.
    /// - Returns: The signature as a `Data` object.
    public func sign(data: Data, key: JWK) throws -> Data {
        guard let k = key.key else { throw CryptoError.notValidPrivateKey }
        let symmetryKey = SymmetricKey(data: k)
        return Data(HMAC<SHA384>.authenticationCode(for: data, using: symmetryKey))
    }
}