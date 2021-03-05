//
//  NetworkManager.swift
//  SwiftBook_2_HomeWork10.1
//
//  Created by Damir Lutfullin on 16.10.2020.
//

import Foundation

struct NetworkManager {
    
    static var shared = NetworkManager()
    let sessionWithCache: URLSession!
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 150 * 1024 * 1024, diskCapacity: 400 * 1024 * 1024, diskPath: "images")
        sessionWithCache = URLSession(configuration: configuration)
    }
    
    func downloadHeroes(completion: @escaping (Result<[Hero]?, Error>) -> ()) {
        guard let url = URL(string: "https://akabab.github.io/superhero-api/api/all.json") else {return}
        sessionWithCache.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data  else { return }
            do {
                let heroes = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(heroes))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func downloadImage(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        sessionWithCache.dataTask(with: url) { data, response, error in
            if let data = data  {
                DispatchQueue.main.async {
                    completion(.success(data))}
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func downloadImageForCell(urlString: String, completion: @escaping (Result<Data, Error>) -> ()) -> URLSessionTask? {
        guard let url = URL(string: urlString) else { return nil }
        let task = sessionWithCache.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {completion(.failure(error!)) }
                return
            }
            DispatchQueue.main.async {completion(.success(data)) }
        }
        task.resume()
        return task
    }
}
