//
////
////  ContentView.swift
////  Currency-Exchanger-Project
////
////  Created by Artem Ponomarenko on 15.03.2025.
////
//

//last upd
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
    @State private var stringResult: String = ""
    @State private var firstSum: Double = 0.0
    @State private var calculatedSum: Double = 0.0
    @State private var upperFlag: String = ""
    @State private var lowerFlag: String = ""
    @State private var fromCurrency: Int = 0
    @State private var toCurrency: Int = 1
   
    private let purpleColor = Color(red: 130/255, green: 87/255, blue: 236/255)
    private let darkBackgroundColor = Color(red: 0x2B / 255.0, green: 0x28 / 255.0, blue: 0x35 / 255.0)
    private let textFieldColor: Color = Color(red: 0x70 / 255.0, green: 0x51 / 255.0, blue: 0xEF / 255.0)

    var body: some View {
        ZStack {
            Color(red: 0x2B / 255.0, green: 0x28 / 255.0, blue: 0x35 / 255.0).ignoresSafeArea()

            VStack {
               

                Menu {
                    Button("UAH | Українська гривня 🇺🇦", action: fromUAH)
                    Button("PLN | Польський злотий 🇵🇱", action: fromPLN)
                    Button("RON | Румунський лей 🇷🇴", action: fromRON)
                    Button("EUR | Євро 🇪🇺", action: fromEUR)
                    Button("USD | Американський долар 🇺🇸", action: fromUSD)
                    Button("BYH | Білоруський ruble 🇧🇾", action: fromBYH)
                    Button("JPY | Японська єна 🇯🇵", action: fromJPY)
                    Button("GBP | Британський фунт стерлінгів 🇬🇧", action: fromGBP)
                    Button("CHF | Швейцарський франк 🇨🇭", action: fromCHF)
                    Button("CAD | Канадський долар 🇨🇦", action: fromCAD)
                    Button("AUD | Австралійський долар 🇦🇺", action: fromAUD)
                    Button("CNY | Китайський юань 🇨🇳", action: fromCNY)
                } label: {
                    Image(systemName: "chevron.down").font(.largeTitle)
                }.offset(x: 150, y: 69).foregroundColor(purpleColor)

                Menu {
                    Button("UAH | Українська гривня 🇺🇦", action: toUAH)
                    Button("PLN | Польський злотий 🇵🇱", action: toPLN)
                    Button("RON | Румунський лей 🇷🇴", action: toRON)
                    Button("EUR | Євро 🇪🇺", action: toEUR)
                    Button("USD | Американський долар 🇺🇸", action: toUSD)
                    Button("BYH | Беларуський ruble 🇧🇾", action: toBYH)
                    Button("JPY | Японська єна 🇯🇵", action: toJPY)
                    Button("GBP | Британський фунт стерлінгів 🇬🇧", action: toGBP)
                    Button("CHF | Швейцарський франк 🇨🇭", action: toCHF)
                    Button("CAD | Канадський долар 🇨🇦", action: toCAD)
                    Button("AUD | Австралійський долар 🇦🇺", action: toAUD)
                    Button("CNY | Китайський юань 🇨🇳", action: toCNY)
                } label: {
                    Image(systemName: "chevron.down").font(.largeTitle)
                }.offset(x: 150, y: 149).foregroundColor(purpleColor)

                Form {
                    Section {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(purpleColor)
                                .frame(height: 50)

                            TextField("Введіть суму", value: $firstSum, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .disableAutocorrection(true)
                                .keyboardType(.numberPad)
                                .padding(.leading, 10)
                                .foregroundColor(.white)
                                .background(Color.clear)                        }
                    }.listRowBackground(Color.clear)

                    Section {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(purpleColor)
                                .frame(height: 50)

                            Text(String(format: "%.2f", result))
                                .offset(x: 10)
                                .foregroundStyle(.white)
                                .background(Color.clear)
                        }
                    }.listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .offset(y: -50).frame(width: 300, height: 250)
                
                RoundedRectangle(cornerRadius: 50).fill(purpleColor).frame(width: 280, height: 65).offset(x: 0, y:248)
                Button {
                    print("Some text")
                } label: {
                    Image(systemName: "map")
                }.font(.largeTitle).offset(y: 190).foregroundColor(.white)

                Button {
                    print("Some text")
                } label: {
                    Image(systemName: "house").font(.largeTitle).offset(x: -80, y: 150).foregroundColor(.white)
                }

                Button {
                    print("Some text")
                } label: {
                    Image(systemName: "chart.dots.scatter")
                }.font(.largeTitle).offset(x: 80, y: 115).foregroundColor(.white)
                
                
                RoundedRectangle(cornerRadius: 50).fill(purpleColor).frame(width: 150, height: 60).offset(x: 0, y:-195)
                Button("Обміняти") {
                    calculatedSum = firstSum * 0.024
                }.font(.title2).offset(y: -250).foregroundColor(.white)
            }
            .padding()
            .onAppear { viewModel.fetch() }
        }
    }

    func fromUAH() {
        lowerFlag = "🇺🇦"
        fromCurrency = 0
    }
    func fromPLN() {
        lowerFlag = "🇵🇱"
        fromCurrency = 2
    }
    func fromRON() {
        lowerFlag = "🇷🇴"
        fromCurrency = 3
    }
    func fromEUR() {
        lowerFlag = "🇪🇺"
        fromCurrency = 4
    }
    func fromUSD() {
        lowerFlag = "🇺🇸"
        fromCurrency = 1
    }
    func fromBYH() {
        lowerFlag = "🇧🇾"
        fromCurrency = 5
    }
    func fromAUD() {
        lowerFlag = "🇦🇺"
        fromCurrency = 6
    }
    func fromGBP() {
        lowerFlag = "🇬🇧"
        fromCurrency = 7
    }
    func fromCAD() {
        lowerFlag = "🇨🇦"
        fromCurrency = 8
    }
    func fromCNY() {
        lowerFlag = "🇨🇳"
        fromCurrency = 9
    }
    func fromJPY() {
        lowerFlag = "🇯🇵"
        fromCurrency = 10
    }
    func fromCHF() {
        upperFlag = "🇨🇭"
        fromCurrency = 756
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
    func toCHF() {
        lowerFlag = "🇨🇭"
        toCurrency = 756
    }
}

#Preview {
    ContentView()
}
