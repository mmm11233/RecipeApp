//
//  NetworkReachabilityService.swift
//  FinalRecipeApp
//
//  Created by Rezo Joglidze on 12.02.24.
//

import UIKit
import Network

// MARK: - Network Reachability Service
final class NetworkReachabilityService {
    // MARK: Properties
    static let shared = NetworkReachabilityService()
    private let monitor = NWPathMonitor()
    
    // MARK: Initalizer
    private init() { }
    
    // MARK: Setup
    func startObserving() {
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                NotificationCenter.default.postNoInternetConnection()
            }
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        monitor.start(queue: queue)
    }
    
    func stopObserving() {
        monitor.cancel()
    }
}
