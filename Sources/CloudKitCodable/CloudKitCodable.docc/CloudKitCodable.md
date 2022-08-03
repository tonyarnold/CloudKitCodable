# ``CloudKitCodable``

An encoder and decoder for CKRecord.

## Overview

This project implements a ``CloudKitRecordEncoder`` and a ``CloudKitRecordDecoder`` so you can easily convert your custom data structure to a `CKRecord` and convert your `CKRecord` back to your custom data structure.

> Be aware this is an initial implementation that's not being used in production (yet) and it doesn't support nesting. Nested values would have to be encoded as `CKReference` and I haven't implemented that yet (feel free to [open a PR](https://github.com/insidegui/CloudKitCodable/pulls) 🤓).

### Usage

The types you want to convert to/from `CKRecord` must implement the ``CustomCloudKitCodable`` protocol. This is necessary because unlike most implementations of encoders/decoders, we are not converting to/from Data, but to/from `CKRecord`, which has some special requirements.

There are also two other protocols: ``CustomCloudKitEncodable`` and ``CustomCloudKitDecodable``. You can use those if you only need either encoding or decoding respectively.

The protocol requires two properties on the type you want to convert to/from `CKRecord`:

- ``CloudKitRecordRepresentable/cloudKitSystemFields``: This will be used to store the system fields for the `CKRecord` when decoding. The system fields contain metadata for the record such as its unique identifier and they're very important when syncing.
- ``CloudKitRecordRepresentable/cloudKitIdentifier-uk1q``: This property should return the record type for your custom type. It's implemented automatically to return the name of the type, you only need to implement this if you need to customize the record type.

### URLs
There's special handling for URLs because of the way CloudKit works with files. If you have a property that's a remote `URL` (i.e. a website), it's encoded as a `String` (CloudKit doesn't support URLs natively) and decoded back as a `URL`. 

If your property is a `URL` and it contains a `URL` to a local file, it is encoded as a `CKAsset`, the file will be automatically uploaded to CloudKit when you save the containing record and downloaded when you get the record from the cloud. The decoded `URL` will contain the `URL` for the location on disk where CloudKit has downloaded the file.

### Example

Let's say you have a `Person` model you want to sync to CloudKit. This is what the model would look like:

@Snippet(path: CloudKitCodable/Snippets/Example, slice: "model")

Notice I didn't implement ``CloudKitRecordRepresentable/cloudKitRecordType-3av6u``, in that case, the `CKRecord` type for this model will be `Person` (the name of the type itself).

Now, before saving the record to CloudKit, we encode it:

@Snippet(path: CloudKitCodable/Snippets/Example, slice: "encode")

Since `avatar` points to a local file, the corresponding file will be uploaded as a `CKAsset` when the record is saved to CloudKit and downloaded back when the record is retrieved.

To decode the record:

@Snippet(path: CloudKitCodable/Snippets/Example, slice: "decode")


## Topics

### Encoding and Decoding Values

- ``CloudKitRecordDecoder``
- ``CloudKitRecordEncoder``

### Codable Conformances

- ``CustomCloudKitCodable``
- ``CustomCloudKitDecodable``
- ``CustomCloudKitEncodable``
- ``CloudKitRecordRepresentable``

### Errors

- ``CloudKitRecordEncodingError``
