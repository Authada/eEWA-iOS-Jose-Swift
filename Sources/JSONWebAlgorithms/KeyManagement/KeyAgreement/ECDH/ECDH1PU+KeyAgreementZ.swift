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
 *
 * Modified by AUTHADA GmbH
 * Copyright 2024 AUTHADA GmbH
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

import Foundation
import JSONWebKey

/// Extension to make `ECDH1PU` conform to `KeyAgreementZ`.
extension ECDH1PU: KeyAgreementZ {
    
    /// Agrees upon a shared secret `Z` using the given private, public, and ephemeral keys.
    /// - Parameters:
    ///   - privateKey: The private key as a `JWK`.
    ///   - publicKey: The public key as a `JWK`.
    ///   - ephemeralKey: The ephemeral key as a `JWK`. This parameter is required.
    ///   - sender: A boolean indicating if the sender is agreeing upon the shared secret.
    /// - Throws: An error if the key agreement fails or if the ephemeral key is missing.
    /// - Returns: The agreed upon shared secret `Z` as a `Data` object.
    public func agreeUponZ(privateKey: JWK, publicKey: JWK, ephemeralKey: JWK?, sender: Bool) throws -> Data {
        guard let ephemeralKey else {
            throw CryptoError.missingArguments([])
        }
        return try processSharedKey(
            privateKey: privateKey,
            publicKey: publicKey,
            ephemeralKey: ephemeralKey,
            sender: sender
        )
    }
}
