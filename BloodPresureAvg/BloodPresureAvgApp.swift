//
//  BloodPresureAvgApp.swift
//  BloodPresureAvg
//
//  Created by Kuan on 2022/6/21.
//

import SwiftUI

@main
struct BloodPresureAvgApp: App {
    
    @StateObject var server = ServerClient()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(server)
        }
    }
}
