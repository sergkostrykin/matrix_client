//
//  RoomDetailsView.swift
//  MatrixClient
//
//  Created by Sergiy Kostrykin on 21/08/2024.
//

import SwiftUI

struct RoomDetailsView: View {
    
    @EnvironmentObject var clientEnvironment: RestClientEnvironment
    
    @ObservedObject private var viewModel: RoomDetailsViewModel
    
    init(viewModel: RoomDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.roomName)
                .font(.largeTitle)
                .padding()

            Text("Topic: \(viewModel.topic)")
                .font(.body)
                .padding()

            Text("Members: \(viewModel.membersNumber)")
                .font(.body)
                .padding()

            Spacer()
        }
        .navigationTitle("Room Details")
        .task {
            await viewModel.fetchMessages(with: clientEnvironment.mxRestClient, loginToken: clientEnvironment.token)
        }
    }
}
