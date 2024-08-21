//
//  PublicRoomsView.swift
//  MatrixClient
//
//  Created by Sergiy Kostrykin on 21/08/2024.
//

import SwiftUI

struct PublicRoomsView: View {
    
    @EnvironmentObject var clientEnvironment: RestClientEnvironment
    
    @ObservedObject private var viewModel: PublicRoomsViewModel
    
    init(viewModel: PublicRoomsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.publicRooms, id: \.roomId) { room in
                NavigationLink(destination: RoomDetailsView(viewModel: .init(room: room))) {
                    VStack(alignment: .leading) {
                        Text(room.name ?? "Unnamed Room")
                            .font(.headline)
                        Text(room.topic ?? "No topic")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Public Rooms")
            .task {
                await viewModel.fetchPublicRooms(with: clientEnvironment.mxRestClient)
            }
        }
    }
}
