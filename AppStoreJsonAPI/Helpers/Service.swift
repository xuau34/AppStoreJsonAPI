//
//  Service.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/13.
//  Copyright © 2020 Mia. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()
    
    let baseRequestString = "https://itunes.apple.com/search?" //term=yelp&entity=software
    
    // Won't cast completion() into main thread
    func fetchITunesApps(term: String, completion: @escaping (JsonAppResults) -> ()) {
        let urlString = "\(baseRequestString)term=\(term)&entity=software"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ data, resp, err in
            if let err = err {
                print("Filed on fetching data from ITunes:", err)
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let appResults = try jsonDecoder.decode( JsonAppResults.self, from: data)
                
                completion( appResults )
            } catch {
                print("Failed on decoding data:", error)
            }
        }.resume()
    }
}
