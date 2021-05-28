//
//  NetworkMonitor.swift
//  DSGroomer
//
//  Created by Charlie Arcodia on 5/28/21.
//

import Network

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
            
            if path.status == .satisfied {
                print("satisfied!")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("HANDLE_SERVICE_SATISFIED"), object: nil)
                }
                
            } else if path.status == .unsatisfied {
                
                print("unsatisfied!")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("HANDLE_SERVICE_UNSATISIFED"), object: nil)
                }
                
            } else if path.status == .requiresConnection {
                
                DispatchQueue.main.async {
                    print("requiresConnection!")
                    NotificationCenter.default.post(name: NSNotification.Name("HANDLE_SERVICE_UNSATISIFED"), object: nil)
                }
                
            } else {
                print("HIT THE ELSE FOR NETWORK")
            }
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
