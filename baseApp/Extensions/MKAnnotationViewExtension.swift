//
//  MKAnnotationViewExtension.swift
//  baseApp
//
//  Created by David on 9/5/19.
//  Copyright © 2019 Yopter. All rights reserved.
//

import Foundation
import MapKit

extension MKAnnotationView
{
    func setImageWithURL(urlString: String)
    {
        let url = URL.init(string: urlString)
        self.getDataFromUrl(url: url!) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}
