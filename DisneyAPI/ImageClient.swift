//
//  ImageClient.swift
//  DisneyAPI
//
//  Created by Jamario Davis on 10/21/21.
//

import UIKit

struct ImageClient {
    
    static func fetchImage(for urlString: String, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let url = URL(string: urlString) else {
            print("bad url \(urlString)")
             return
        }
        // create a data task using the URLSession() class
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                // check if an error exist
            if let error = error {
                print("error: \(error)")
                    // TODO: add enum error
                return
            }
            if let data = data {
                    // use data to create an image
                    // UIImage takes data object and returns an image
                let image = UIImage(data: data)
                    // capture result of image
                completion(.success(image))
            }
        }
        dataTask.resume() // executes network request
    }
}
