//
//  ReachabilityManager.swift
//  5Day Weather
//
//  Created by Adel on 1/27/24.
//

import Foundation
import Reachability

class ReachabilityManager {
    static let shared = ReachabilityManager()
    
    private let reachability = try? Reachability()
    
    @Published var isReachable: Bool = true
    
    private init() {
        setupReachability()
    }
    
    private func setupReachability() {
        reachability?.whenReachable = { [weak self] _ in
            self?.isReachable = true
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.isReachable = false
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Error starting reachability notifier")
        }
    }
}
