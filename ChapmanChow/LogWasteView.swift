//
//  LogWasteView.swift
//  ChapmanChow
//
//  Created by Irene Ichwan on 4/1/25.
//

import SwiftUI

struct WasteLog: Identifiable, Codable {
    let id: UUID
    let itemsWasted: String
    let quantity: String
    let notes: String
    let date: Date
}

struct LogWasteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var itemsWasted = ""
    @State private var quantity = ""
    @State private var notes = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ZStack {
            // Chapman red background
            Color(red: 157/255, green: 34/255, blue: 53/255)
                .ignoresSafeArea()
            
            VStack {
                Form {
                    Section(header: Text("Waste Details").foregroundColor(.white)) {
                        //.font(.headline)
                        //.foregroundColor(.white)) {
                        TextField("Items Wasted (comma separated)", text: $itemsWasted)
                        TextField("Estimated Quantity", text: $quantity)
                    }
                    
                    Section(header: Text("Additional Notes").foregroundColor(.white)) {
                        // .font(.headline)
                        //.foregroundColor(.white)) {
                        TextEditor(text: $notes)
                            .frame(minHeight: 150)
                            .overlay(
                                notes.isEmpty ?
                                Text("Enter any observations about why this was wasted...")
                                    .foregroundColor(.gray.opacity(0.5))
                                    .padding(.leading, 4)
                                    .allowsHitTesting(false)
                                : nil,
                                alignment: .topLeading)
                    }
                }
                .scrollContentBackground(.hidden)
                .foregroundColor(.white)
                .frame(maxWidth: 700)
                .padding(.horizontal, 16)
                .padding(.vertical, 120)
                
                Button(action: submitWasteLog) {
                    Text("Submit Waste Log")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .foregroundColor(Color(red: 157/255, green: 34/255, blue: 53/255))
                        .cornerRadius(10)
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
            }
            
            .navigationTitle("Log Food Waste")
            .alert("Log Submitted", isPresented: $showingConfirmation) {
                Button("OK") { dismiss() }
            } message: {
                Text("Thank you for helping reduce food waste!")
            }
        }
    }
    
    private func submitWasteLog() {
        let newLog = WasteLog(
            id: UUID(),
            itemsWasted: itemsWasted,
            quantity: quantity,
            notes: notes,
            date: Date()
        )
        
        var currentLogs = WasteLog.loadFromFile()
        currentLogs.append(newLog)
        WasteLog.saveToFile(currentLogs)
        
        showingConfirmation = true
    }
}

extension WasteLog {
    static let fileName = "wasteLogs.json"
    
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func loadFromFile() -> [WasteLog] {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: url) else { return [] }
        let decoded = try? JSONDecoder().decode([WasteLog].self, from: data)
        return decoded ?? []
    }
    
    static func saveToFile(_ logs: [WasteLog]) {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        if let encoded = try? JSONEncoder().encode(logs) {
            try? encoded.write(to: url, options: [.atomicWrite, .completeFileProtection])
        }
    }
}

struct LogWasteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LogWasteView()
        }
    }
}

