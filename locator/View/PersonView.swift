import Foundation
import SwiftUI

struct PersonView: View {
    let person: Person
    let distance: String
    
    var body: some View {
        HStack {
            Image(systemName: person.avatar)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(5)
                .background(Circle().fill(Color.blue.opacity(0.5)))
            
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(distance)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
}
