//
//  CustomCloudKitEncodable.swift
//  CloudKitCodable
//
//  Created by Guilherme Rambo on 11/05/18.
//  Copyright © 2018 Guilherme Rambo. All rights reserved.
//

import Foundation
import CloudKit

internal let _CKSystemFieldsKeyName = "cloudKitSystemFields"
internal let _CKIdentifierKeyName = "cloudKitIdentifier"

/// A type that can be represented via CloudKit as a `CKRecord`.
public protocol CloudKitRecordRepresentable {
    /// Used to store the system fields for the `CKRecord` when decoding.
    ///
    /// The system fields contain metadata for the record such as its unique identifier and are very important when syncing.
    var cloudKitSystemFields: Data? { get }

    /// The record type for your custom type.
    ///
    /// This is implemented automatically to return the name of the type, you only need to implement this if you need to customize the record type.
    var cloudKitRecordType: String { get }

    /// The unique ID of your custom type's record.
    ///
    /// The default implementation of this method generates and returns a UUID string.
    var cloudKitIdentifier: String { get }
}

extension CloudKitRecordRepresentable {
    public var cloudKitRecordType: String {
        return String(describing: type(of: self))
    }

    public var cloudKitIdentifier: String {
        return UUID().uuidString
    }
}

/// A type that can be represented as, and encoded to `CKRecord`.
public protocol CustomCloudKitEncodable: CloudKitRecordRepresentable & Encodable {

}

/// A type that can be represented as, and decoded from `CKRecord`.
public protocol CustomCloudKitDecodable: CloudKitRecordRepresentable & Decodable {

}

/// A type that can be represented as, decoded from and encoded to `CKRecord`.
public protocol CustomCloudKitCodable: CustomCloudKitEncodable & CustomCloudKitDecodable { }
