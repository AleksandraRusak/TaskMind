//
//  APIImage.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-06.
//

import SwiftUI

class APIImage {
    
    var image: UIImage? = nil
    let url = URL(string: "https://picsum.photos/200")!
    
    // Call API by completion
    func getImageWithCompletion(completionHandler: @escaping(_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let _ = response else { return }
            completionHandler(image, nil)
        }
        .resume()
    }
}
