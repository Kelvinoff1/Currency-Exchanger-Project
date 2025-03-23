//
//  ViewModel.swift
//  Currency-Exchanger-Project
//
//  Created by Artem Ponomarenko on 23.03.2025.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var courses: [CurrencyCourse] = []
    
    func fetch() {
        
        guard let url = URL(string: "https://api.monobank.ua/bank/currency") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else { return }
            print(String(data: data, encoding: .utf8) ?? "Помилка отримання JSON")
            // Convert to JSON
            do {
                let decodedResponse = try JSONDecoder().decode([CurrencyCourse].self, from: data)
                DispatchQueue.main.async {
                    self.courses = decodedResponse
                }
            } catch {
                print("ПОМИЛКА: \(error)")
            }
        }
       
        task.resume()
    }
}
