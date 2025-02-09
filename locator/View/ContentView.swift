import SwiftUI
import UIKit
import CoreLocation

struct ContentView: View {
    @StateObject private var viewModel = PersonViewModel()
    @StateObject private var personService = PersonService()
    @StateObject var locationManager = LocationManager()
    @State private var showingAlert = false
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    var body: some View {
        ZStack {
            Color(UIColor(red: 242 / 255, green: 243 / 255, blue: 247 / 255, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                if let selectedPerson = viewModel.selectedPerson {
                    PersonView(person: selectedPerson, distance: "Выбран")
                        .transition(.move(edge: .bottom))
                    
                }
                List {
                    ForEach(personService.people) { person in
                        viewModel.personRow(for: person)
                    }
                }
                .listStyle(PlainListStyle())
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.8))
                        .shadow(radius: 5)
                )
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingAlert = true
                    }) {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue.opacity(0.5))
                            .shadow(radius: 5)
                    }
                    .padding()
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Твоя геопозиция"),
                            message: Text("Широта: \(String(format: "%.2f", locationManager.lastLocation?.coordinate.latitude ?? 0)) Долгота: \(String(format: "%.2f", locationManager.lastLocation?.coordinate.longitude ?? 0))"),
                            dismissButton: .default(Text("Закрыть"))
                        )
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.global(qos: .background).async {
                personService.loadPeople()
            }
            personService.startTimer()
        }
    }
}

#Preview {
    ContentView()
}
