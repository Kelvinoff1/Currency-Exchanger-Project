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
    
    func calculate(_ firstSum: Double, _ rateSell: Double?, _ rateCross: Double?, _ fromCurrency: Int, _ toCurrency: Int, _ currencyCode: Int, _ courses: [CurrencyCourse]) -> Double? {
        
        var result: Double? = 0
        var rateInUAH: Double? = 0
        var toCurrencyRate: Double? = 0
        
        if let toCurrencyCourse = courses.first(where: { $0.currencyCodeA == toCurrency }) {
            toCurrencyRate = toCurrencyCourse.rateSell ?? toCurrencyCourse.rateCross
        }
        
        if fromCurrency == toCurrency {
            result = firstSum
        }
        
        if fromCurrency == 980 { // не працює
    
                result = firstSum / (toCurrencyRate ?? 1)
            
        } else if fromCurrency != 980 {
            if toCurrency != 980 {
                
                if rateSell != nil {
                    rateInUAH = rateSell
                } else {
                    rateInUAH = rateCross
                }
                
                result = firstSum * (rateInUAH ?? 1) / (toCurrencyRate ?? 1)
            } else {
                
                if rateSell != nil {
                    rateInUAH = rateSell
                } else {
                    rateInUAH = rateCross
                }
                
                result = firstSum * (rateInUAH ?? 1)
            }
        }
        
        return result
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
       var result: Double {
           var value: Double = 0.0
           if let course = viewModel.courses.first(where: { $0.currencyCodeA == fromCurrency }) {
               value = course.calculate(firstSum, course.rateSell, course.rateCross, fromCurrency, toCurrency, course.currencyCodeA, viewModel.courses) ?? 0.0
               
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

                            TextField("Введіть суму", value: $firstSum, format: .currency(code: ""))
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
                
                Button {
                    reverse()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }.font(.largeTitle).offset(x: -150, y: -380).foregroundStyle(purpleColor)
                
//                Text(upperFlag).offset(x: -150, y: -440)
//                    .font(.title)
//                Text(lowerFlag).offset(x: -150, y: -360)
//                    .font(.title)
            }
            .padding()
            .onAppear { viewModel.fetch() }
        }
    }
    
    func reverse() {
        let forCurrency: Int = fromCurrency
        let forFlag: String = upperFlag
        
        upperFlag = lowerFlag
        lowerFlag = forFlag
        
        fromCurrency = toCurrency
        toCurrency = forCurrency
    }
    func fromUAH() {
        upperFlag = "🇺🇦"
        fromCurrency = 980
    }
    func fromPLN() {
        upperFlag = "🇵🇱"
        fromCurrency = 985
    }
    func fromRON() {
        upperFlag = "🇷🇴"
        fromCurrency = 946
    }
    func fromEUR() {
        upperFlag = "🇪🇺"
        fromCurrency = 978
    }
    func fromUSD() {
        upperFlag = "🇺🇸"
        fromCurrency = 840
    }
    func fromBYH() {
        upperFlag = "🇧🇾"
        fromCurrency = 933
    }
    func fromAUD() {
        upperFlag = "🇦🇺"
        fromCurrency = 036
    }
    func fromGBP() {
        upperFlag = "🇬🇧"
        fromCurrency = 826
    }
    func fromCHF() {
        upperFlag = "🇨🇭"
        fromCurrency = 756
    }
    func fromCAD() {
        upperFlag = "🇨🇦"
        fromCurrency = 124
    }
    func fromCNY() {
        upperFlag = "🇨🇳"
        fromCurrency = 156
    }
    func fromJPY() {
        upperFlag = "🇯🇵"
        fromCurrency = 392
    }
    
    func toUAH() {
        lowerFlag = "🇺🇦"
        toCurrency = 980
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
    func toCHF() {
        lowerFlag = "🇨🇭"
        toCurrency = 756
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
