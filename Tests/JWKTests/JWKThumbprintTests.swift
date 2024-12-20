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

@testable import JSONWebKey
import XCTest
import Tools

final class JWKThumbprintTests: XCTestCase {
    // See https://www.rfc-editor.org/rfc/rfc8037#appendix-A.3
    func test_RFC8037_Appendix_A_3() throws {
        let jwk = try JWK(
            keyType: .octetKeyPair,
            curve: .ed25519,
            x: Base64URL.decode("11qYAYKxCrfVS_7TyWQHOg7hcvPapiMlrwIaaPcHURo")
        )
        XCTAssertEqual(try jwk.thumbprint(), "kPrK_qmxVWaYVA9wwBF6Iuo3vVzz7TxHCTwXBygrS4k")
    }
}
