import Foundation
import SwiftUICore
import UIKit
import CoreLocation

class PersonService: ObservableObject {
    @Published var people: [Person] = []
    @State private var timer: Timer? = nil
    
    func loadPeople() {
        guard let fileURL = Bundle.main.url(forResource: "mock_persons", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedPeople = try JSONDecoder().decode([Person].self, from: data)
            DispatchQueue.main.async {
                self.people = decodedPeople
            }
        } catch {
            print("Ошибка: \(error)")
        }
    }
    
    func calculateDistance(from: CLLocationCoordinate2D, to: Location) -> String {
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distance = fromLocation.distance(from: toLocation)
        return String(format: "%.f км", distance / 1000)
    }
    
    func updateCoordinates() {
        people = people.map { person in
            var updatedPerson = person
            updatedPerson.location.latitude += Double.random(in: -0.01...0.01)
            updatedPerson.location.longitude += Double.random(in: -0.01...0.01)
            return updatedPerson
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            DispatchQueue.main.async {
                self.updateCoordinates()
            }
        }
    }
}
