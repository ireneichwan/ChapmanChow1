import SwiftUI

struct MenuView: View {
    let menu = Bundle.main.decode([MenuSection].self, from: "menu.json")

    var body: some View {
        List {
            ForEach(menu, id: \.id) { section in
                Section(header: Text(section.name).font(.headline)) {
                    ForEach(section.items, id: \.id) { item in
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Menu")  // Make sure this exists

    }
}
