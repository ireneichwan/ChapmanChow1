//
//  HomeView.swift
//  ChapmanChow
//
//  Created by Irene Ichwan on 2/12/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to ChapmanChow!")
                    .font(.title)
                    .padding()

                NavigationLink(destination: MenuView()) {
                    Text("View Menu")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
