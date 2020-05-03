//
//  WebSocketProvider.swift
//  StreamChatClient
//
//  Created by Alexey Bukhtin on 30/04/2020.
//  Copyright © 2020 Stream.io Inc. All rights reserved.
//

import Foundation

protocol WebSocketProvider {
    var request: URLRequest { get }
    var isConnected: Bool { get }
    var callbackQueue: DispatchQueue { get }
    var delegate: WebSocketProviderDelegate? { get set }
    
    init(request: URLRequest, callbackQueue: DispatchQueue?)
    func connect()
    func disconnect()
    func sendPing()
}

extension WebSocketProvider {
    init(request: URLRequest, callbackQueue: DispatchQueue? = nil) {
        self.init(request: request, callbackQueue: callbackQueue)
    }
}

protocol WebSocketProviderDelegate: class {
    func websocketDidConnect(_ provider: WebSocketProvider)
    func websocketDidDisconnect(_ provider: WebSocketProvider, error: WebSocketProviderError?)
    func websocketDidReceiveMessage(_ provider: WebSocketProvider, message: String)
}

struct WebSocketProviderError: Error {
    static let stopErrorCode = 1000
    
    let reason: String
    let code: Int
    let providerType: WebSocketProvider.Type
    let providerError: Error?
    
    var localizedDescription: String { reason }
}
