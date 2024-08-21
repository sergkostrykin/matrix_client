//
//  RoomDetailsViewModel.swift
//  MatrixClient
//
//  Created by Sergiy Kostrykin on 21/08/2024.
//

import SwiftUI
import MatrixSDK

class RoomDetailsViewModel: ObservableObject {
    
    @Published var messages: [MXEvent] = []

    var roomName: String {
        room.name ?? "Unnamed Room"
    }

    var topic: String {
        room.topic ?? "No topic"
    }

    var membersNumber: String {
        String(room.numJoinedMembers)
    }
    
    private let room: MXPublicRoom
    
    init(room: MXPublicRoom) {
        self.room = room
    }
    
    func fetchMessages(with client: MXRestClient, loginToken: String) async {
        do {
            let result = try await withCheckedThrowingContinuation { continuation in
                client.messages(forRoom: room.roomId, from: loginToken, direction: .forwards, limit: nil, filter: .init()) { response in
                    switch response {
                    case .success(let result):
                        continuation.resume(returning: result)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
            DispatchQueue.main.async {
                self.messages = result.chunk
            }
        } catch {
            print("Failed to fetch messages: \(error)")
        }
    }
}
