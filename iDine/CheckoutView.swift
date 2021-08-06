//
//  CheckoutView.swift
//  iDine
//
//  Created by sayantan samanta on 31/07/21.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order : Order
    @State private var PaymentType = "Cash"
    @State private var addLoyaltyPoints = false
    @State private var loyaltyNumber = ""
    @State private var TipAmount = 10
    @State private var showingPaymentAlerts = false
    
    
    let PaymentTypes = ["Cash", "Credit Card", "Apple Pay"]
    
    let TipAmounts = [10, 15, 20, 30, 0]
     
    var TotalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue = total / 100 * Double(TipAmount)
        
        
        
        
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
        

        
}
    
    
    var body: some View {
        Form{
            Section{
                Picker("How do you want to pay?",
                       selection: $PaymentType) {
                    ForEach(PaymentTypes, id: \.self){
                        Text($0)
                    }
                }
                
            
                Toggle("Add Apple Pay Loyalty Card", isOn: $addLoyaltyPoints.animation())
                
                if addLoyaltyPoints{
                TextField("Enter your Apple Pay id ", text: $loyaltyNumber)
                    
                }
                
            }
            Section(header: Text("Add a tip!")) {
                Picker("Percentage", selection: $TipAmount) {
                    ForEach(TipAmounts, id: \.self){
                        Text("\($0)%")
                        
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header:
                Text("TOTAL: \(TotalPrice)")
                    .font(.largeTitle)
            ) {
                Button("Confirm Order") {
                   showingPaymentAlerts.toggle()
            }
            }
        }
            
                
                .navigationTitle("Payment")
                .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingPaymentAlerts) {
            Alert(title: Text("Order Confirmed"), message: Text("Your total order was \(TotalPrice)"), dismissButton: .default(Text("Ok")))
            
        }
       
        }



struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}
}
