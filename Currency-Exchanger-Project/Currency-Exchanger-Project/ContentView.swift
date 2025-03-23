
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
    
    func calculate(_ firstSum: Double, _ rateSell: Double?, _ rateCross: Double?, _ codeCurrency: Int, _ currencyCode: Int) -> Double? {
        var result: Double? = 0
        if codeCurrency == currencyCode {
            if rateSell != nil {
                result = rateSell
            } else {
                result = rateCross
            }
        }
        return firstSum / (result ?? 1)
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var result: Double {
        var value: Double = 0.0
        if let course = viewModel.courses.first(where: { $0.currencyCodeA == toCurrency }) {
            value = course.calculate(firstSum, course.rateSell, course.rateCross, toCurrency, course.currencyCodeA) ?? 0.0
            
        }
        return value
    }
    @State private var firstSum: Double = 0.0
    @State private var calculatedSum: Double = 0.0
    @State private var upperFlag: String = ""
    @State private var lowerFlag: String = ""
    @State private var fromCurrency: Int = 0
    @State private var toCurrency: Int = 1
    
    var body: some View {
        VStack {
            
            Menu {
                Button("USD | Американський доллар 🇺🇸", action: toUSD)
                Button("EUR | Євро 🇪🇺", action: toEUR)
                Button("PLN | Польський злотий 🇵🇱", action: toPLN)
                Button("RON | Румунський лей 🇷🇴", action: toRON)
                Button("BYH | Білоруський рубль 🇧🇾", action: toBYH)
                Button("UAH | Українська гривня 🇺🇦", action: toUAH)
            } label: {
                Image(systemName: "chevron.down").font(.largeTitle)
            }.offset(x: -175, y: 210)
            
            Form {
                Section {
                    TextField("Введіть суму", value: $firstSum, format: .currency(code: "")).disableAutocorrection(true).keyboardType(.numberPad)
                    
                }
                
                
//                                Section {
//                                    TextField("", value: result, format: .currency(code: "") ).disableAutocorrection(true).keyboardType(.numberPad)
//                                }
                
                
                Section(header: Text("Conversion currency")) {
                    
                }
                Text(String(format: "%.2f", result))
                
            }
        }.offset(y: -50).frame(width: 300, height: 400)
            .onAppear {
                viewModel.fetch()
            }
        
        Button {
            print("Some text")
        } label: {
            Image(systemName: "map")
        }.font(.largeTitle).offset(y: 125)
        
        Button {
            print("Some text")
        } label: {
            Image(systemName: "house").font(.largeTitle).offset(x: -80, y: 85)
        }
        
        Button {
            print("Some text")
        } label: {
            Image(systemName: "chart.dots.scatter")
        }.font(.largeTitle).offset(x: 80, y: 50)
        
        
        Text(upperFlag).offset(x: -175, y: -560)
        Text(lowerFlag).offset(x: -175, y: -400)
    }
    
    func toUAH() {
        lowerFlag = "🇺🇦"
        toCurrency = 780
    }
    func toPLN() {
        lowerFlag = "🇵🇱"
        toCurrency = 985
    }
    func toRON() {
        lowerFlag = "🇷🇴"
        toCurrency = 946
    }
    func toEUR() {
        lowerFlag = "🇪🇺"
        toCurrency = 978
    }
    func toUSD() {
        lowerFlag = "🇺🇸"
        toCurrency = 840
    }
    func toBYH() {
        lowerFlag = "🇧🇾"
        toCurrency = 933
    }
    func toAUD() {
        lowerFlag = "🇦🇺"
        toCurrency = 036
    }
    func toGBP() {
        lowerFlag = "🇬🇧"
        toCurrency = 826
    }
    func toCAD() {
        lowerFlag = "🇨🇦"
        toCurrency = 124
    }
    func toCNY() {
        lowerFlag = "🇨🇳"
        toCurrency = 156
    }
    func toJPY() {
        lowerFlag = "🇯🇵"
        toCurrency = 392
    }
}


#Preview {
    ContentView()
}
