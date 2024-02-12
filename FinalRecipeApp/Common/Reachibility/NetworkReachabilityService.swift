//
//  NetworkReachabilityService.swift
//  FinalRecipeApp
//
//  Created by Rezo Joglidze on 12.02.24.
//

import UIKit
import Network

final class NetworkReachabilityService {
    static let shared = NetworkReachabilityService()
    
    private init() { }

    private let monitor = NWPathMonitor()

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
