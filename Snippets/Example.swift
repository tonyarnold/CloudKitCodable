import CloudKit
import CloudKitCodable
import Foundation

// snippet.model
struct Person: CustomCloudKitCodable {
    var cloudKitSystemFields: Data?
    let name: String
    let age: Int
    let website: URL
    let avatar: URL
    let isDeveloper: Bool
}
// snippet.end


func thingDoer() {
    // snippet.encode
    let rambo = Person(
        cloudKitSystemFields: nil,
        name: "Guilherme Rambo",
        age: 26,
        website: URL(string:"https://guilhermerambo.me")!,
        avatar: URL(fileURLWithPath: "/Users/inside/Pictures/avatar.png"),
        isDeveloper: true
    )

    do {
        let record = try CloudKitRecordEncoder().encode(rambo)
        // record is now a CKRecord you can upload to CloudKit
    } catch {
        // something went wrong
    }
    // snippet.end

    // snippet.decode
    let record = CKRecord(recordType: "Person") // Record obtained from CloudKit
    do {
        let person = try CloudKitRecordDecoder().decode(Person.self, from: record)
    } catch {
        // something went wrong
    }
    // snippet.end
}
