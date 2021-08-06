//
//  iDineApp.swift
//  iDine
//
//  Created by sayantan samanta on 31/07/21.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order()
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
