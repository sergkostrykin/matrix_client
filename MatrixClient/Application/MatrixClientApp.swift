//
//  MatrixClientApp.swift
//  MatrixClient
//
//  Created by Sergiy Kostrykin on 21/08/2024.
//

import SwiftUI

@main
struct MatrixClientApp: App {
    
    @ObservedObject var clientEnvironment = RestClientEnvironment()
    
    var body: some Scene {
        WindowGroup {
            PublicRoomsView(viewModel: .init())
        }
        .environmentObject(clientEnvironment)
    }
}
