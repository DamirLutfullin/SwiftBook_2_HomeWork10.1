//
//  UIImageView + Extension.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 19.10.2020.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, completion: (() -> ())? = nil) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                if completion != nil {
                    completion!()
                }
            }
        }.resume()
    }
    
    func downloaded(from link: String, completion: (() -> ())? = nil) {
            guard let url = URL(string: link) else { return }
            downloaded(from: url, completion: completion)
        }
}

