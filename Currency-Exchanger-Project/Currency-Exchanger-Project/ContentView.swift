//
//  ContentView.swift
//  Currency-Exchanger-Project
//
//  Created by Artem Ponomarenko on 15.03.2025.
//

import SwiftUI

struct CurrencyCourse: Hashable, Codable {
    let currencyCodeA: Int
    let currencyCodeB: Int
    let date: Int
    let rateBuy: Double?
    let rateSell: Double?
    let rateCross: Double?
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
