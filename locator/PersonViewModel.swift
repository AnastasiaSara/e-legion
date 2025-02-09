import Foundation
import SwiftUICore
import CoreLocation

class PersonViewModel: ObservableObject {
    @Published var selectedPerson: Person? = nil
    @ObservedObject var locationManager = LocationManager()
    @StateObject private var personService = PersonService()
    
    
    func personRow(for person: Person) -> some View {
        let referenceLatitude = selectedPerson?.location.latitude ?? locationManager.lastLocation?.coordinate.latitude
        let referenceLongitude = selectedPerson?.location.longitude ?? locationManager.lastLocation?.coordinate.longitude
        let referenceLocation = CLLocationCoordinate2D(latitude: referenceLatitude ?? 0.0, longitude: referenceLongitude ?? 0.0)
        
        let distance = personService.calculateDistance(from: referenceLocation, to: person.location)
        
        return PersonView(person: person, distance: distance)
            .onTapGesture { [self] in
                withAnimation {
                    if self.selectedPerson?.id == person.id {
                        self.selectedPerson = nil
                    } else {
                        selectedPerson = person
                    }
                }
            }
    }
}
