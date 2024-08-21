//
//  PublicRoomsViewModel.swift
//  MatrixClient
//
//  Created by Sergiy Kostrykin on 21/08/2024.
//

import SwiftUI
import MatrixSDK

class PublicRoomsViewModel: ObservableObject {
    
    @Published var publicRooms: [MXPublicRoom] = []
    
    func fetchPublicRooms(with client: MXRestClient) async {
        do {
            let rooms = try await withCheckedThrowingContinuation { continuation in
                client.publicRooms(onServer: nil, limit: nil) { response in
                    switch response {
                    case .success(let rooms):
                        continuation.resume(returning: rooms)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            DispatchQueue.main.async {
                self.publicRooms = rooms.chunk
            }
        } catch {
            print("Failed to fetch public rooms: \(error)")
        }
    }    
}
