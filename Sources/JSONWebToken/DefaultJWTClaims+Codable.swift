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

extension DefaultJWTClaimsImpl {
    enum CodingKeys: String, CodingKey {
        case iss = "iss"
        case sub = "sub"
        case aud = "aud"
        case exp = "exp"
        case nbf = "nbf"
        case iat = "iat"
        case jti = "jti"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(iss, forKey: .iss)
        try container.encodeIfPresent(sub, forKey: .sub)
        try container.encodeIfPresent(aud, forKey: .aud)
        try container.encodeIfPresent(exp, forKey: .exp)
        try container.encodeIfPresent(nbf, forKey: .nbf)
        try container.encodeIfPresent(iat, forKey: .iat)
        try container.encodeIfPresent(jti, forKey: .jti)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iss = try container.decodeIfPresent(String.self, forKey: .iss)
        sub = try container.decodeIfPresent(String.self, forKey: .sub)
        aud = try container.decodeIfPresent([String].self, forKey: .aud)
        exp = try container.decodeIfPresent(Date.self, forKey: .exp)
        nbf = try container.decodeIfPresent(Date.self, forKey: .nbf)
        iat = try container.decodeIfPresent(Date.self, forKey: .iat)
        jti = try container.decodeIfPresent(String.self, forKey: .jti)
    }
}
