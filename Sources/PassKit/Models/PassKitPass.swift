/// Copyright 2020 Gargoyle Software, LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Vapor
import Fluent

/// Represents the `Model` that stores PassKit passes..  Uses a UUID so people can't easily guess your pass IDs
public protocol PassKitPass: Model, Authenticatable where IDValue == UUID {
    /// The pass type
    var passTypeIdentifier: String { get set }

    /// The last time the pass was updated.
    var updated: Date? { get set }

    /// The authentication token assigned to a pass
    var authenticationToken: String { get set }
}

internal extension PassKitPass {
    var _$id: ID<UUID> {
        guard let mirror = Mirror(reflecting: self).descendant("_id"),
            let id = mirror as? ID<UUID> else {
                fatalError("id property must be declared using @ID")
        }
        
        return id
    }
    
    var _$passTypeIdentifier: Field<String> {
        guard let mirror = Mirror(reflecting: self).descendant("_passTypeIdentifier"),
            let type = mirror as? Field<String> else {
                fatalError("passTypeIdentifier property must be declared using @Field")
        }
        
        return type
    }
    
    var _$updated: Timestamp<DefaultTimestampFormat> {
        guard let mirror = Mirror(reflecting: self).descendant("_updated"),
            let updated = mirror as? Timestamp<DefaultTimestampFormat> else {
                fatalError("updated property must be declared using @Timestamp(on: .updated)")
        }
        
        return updated
    }

    var _$authenticationToken: Field<String> {
        guard let mirror = Mirror(reflecting: self).descendant("_authenticationToken"),
              let authenticationToken = mirror as? Field<String> else {
            fatalError("authenticationToken property must be declared using @Field")
        }

        return authenticationToken
    }

}
