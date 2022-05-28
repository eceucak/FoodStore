//
//  networkConnection.swift
//  FoodStoreApp
//
//  Created by Ece Ucak on 28.05.2022.
//

import Foundation
import Network

final class NetworkConnectionCheck {
    static let shared = NetworkConnectionCheck()
    private let queue = DispatchQueue.global()
    private let connection: NWPathMonitor
    
    public private(set)var isConnected:Bool = false
    
    public private(set)var connectionType: ConnectionType = .unknown
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        connection = NWPathMonitor()
    }
    public func startConnecting() {
        connection.start(queue: queue)
        connection.pathUpdateHandler = {[weak self] path in
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)

        }
    }
    
    public func stopConnecting(){
        connection.cancel()
        
    }
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        }
        else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }
        else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        }
        else {
            connectionType = .unknown
        }
    }
}
