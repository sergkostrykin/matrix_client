//
//  ClientEnvironment.swift
//  MatrixClient
//
//  Created by Sergiy Kostrykin on 21/08/2024.
//

import Foundation
import MatrixSDK

final class RestClientEnvironment: ObservableObject {
    
    @Published private (set) var mxRestClient = MXRestClient(homeServer: URL(string: "https://matrix.org")!, unrecognizedCertificateHandler: nil)
    
    var token: String = ""
}
