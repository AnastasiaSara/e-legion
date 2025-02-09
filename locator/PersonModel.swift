import Foundation

struct Person: Identifiable, Codable {
    let id: String
    let name: String
    let avatar: String
    var location: Location
}

struct Location: Codable {
    var latitude: Double
    var longitude: Double
}
