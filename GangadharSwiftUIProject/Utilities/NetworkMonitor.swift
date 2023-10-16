//
//  NetworkMonitor.swift
//  GangadharSwiftUIProject
//
//  Created by Gangadhar C on 10/16/23.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject{
    @Published var isConnected=true
    
    let monitor = NWPathMonitor()
    let networkQueue = DispatchQueue(label: "Monitor")
    init() {
        monitor.pathUpdateHandler={
            path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: networkQueue)
    }
}
