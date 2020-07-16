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
    let baseRequestFeedString = "https://rss.itunes.apple.com/api/v1/us/ios-apps" //top-free/all/10/explicit.json
    
    // Won't cast completion() into main thread
    func fetchITunesApps(term: String, completion: @escaping (JsonAppResults?, Error?) -> ()) {
        let urlString = "\(baseRequestString)term=\(term)&entity=software"
        fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchFeed(category: String, allGenre: Bool, limit: Int, explicit: Bool, completion: @escaping (JsonAppsFeed?, Error?)->() ) {
        let urlString = "\(baseRequestFeedString)/\(category)/\(allGenre ? "all":"games")/\(limit)/\(explicit ? "explict": "non-explict").json"
        fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialFeed(completion: @escaping ([JsonSocialFeed]?, Error?)->()) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?)->()){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url){ data, resp, err in
            if let err = err {
                completion( nil, err )
                return
            }
            
            guard let data = data else { return }
            
            let jsonDecoder = JSONDecoder()
            do {
                let decodedData = try jsonDecoder.decode( T.self, from: data)
                completion( decodedData, nil )
            } catch {
                completion( nil, err )
            }
            
        }.resume()
        
    }
}
