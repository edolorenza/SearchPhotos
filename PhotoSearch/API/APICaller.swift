//
//  APICaller.swift
//  PhotoSearch
//
//  Created by Edo Lorenza on 18/05/21.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseUrl =  "https://api.unsplash.com/search/photos?page=1&per_page=50"
        static let client_id = "5x0qTjZ4lBpLkSSs6zu_AWIf3ZEPWFDty5Iy9UquPTk"
        static let endPoint = "office"
    
    }
    enum APIError: Error {
        case invalidUrl
    }

    public func fetchPhotos(completion: @escaping ([Result]) -> Void) {
        
        guard let url = URL(string: Constants.baseUrl  + "&query=" + Constants.endPoint + "&client_id=" + Constants.client_id) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
           
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                let photoResultsData = response.results
                completion(photoResultsData)
            }catch {
               print(error)
            }
        }
        task.resume()
    }
}
