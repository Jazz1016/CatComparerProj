//
//  CatBreedController.swift
//  CatAPIProject
//
//  Created by James Lea on 5/5/21.
//

import UIKit

class CatBreedController {
    
//    static let baseUrL = URL(string: "https://api.thecatapi.com/v1/breeds")
    
    // MARK: - Functions
    static func fetchCatBreeds(completion: @escaping (Result<[CatBreed], CatError>) -> Void) {
        
        let baseUrL = URL(string: "https://api.thecatapi.com/v1/breeds")
        
        guard let url = baseUrL else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("CAT STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode([CatBreed].self, from: data)
                
                
                
                
                let catBreedArray = topLevelObject
                
                
                
                
                
                completion(.success(catBreedArray))
            } catch {
                
                
                
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchCatBreed(name: String, completion: @escaping (Result<[Cat], CatError>) -> Void) {
        
        for i in name {
            
            if i == " "{
//                i = "%20"
            }
        }
        
        let baseURL = URL(string: "https://api.thecatapi.com/v1/breeds/search?q=\(name)")
        
        
        
        guard let baseURL = baseURL else {return}
        
//        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
//        components?.queryItems = [URLQueryItem(name: "search", value: "\(name)")]
//        let finalURL = baseURL?.appendingPathComponent("\(name)")

        
//        print(components?.string)
        print(baseURL)
        
        let url = baseURL
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("CAT STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let catBreed = try JSONDecoder().decode([Cat].self, from: data)
//                print(catBreed)
                completion(.success(catBreed))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchCatImageURL(cat: Cat, completion: @escaping (Result<CatImage, CatError>) -> Void){
        let id = cat.reference_image_id
        
        
        
        guard let imageURL = URL(string: "https://api.thecatapi.com/v1/images/\(id)") else {return completion(.failure(.invalidURL))}
        
//        var components = URLComponents(url: countryURL, resolvingAgainstBaseURL: true)
//        let apiQuery = URLQueryItem(name: "key", value: apiKey)
//        components?.queryItems = [apiQuery]


        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                
                let imageTop = try JSONDecoder().decode(CatImage.self, from: data)
                completion(.success(imageTop))
                
            } catch {
             
                completion(.failure(.thrownError(error)))
                
            }
        }.resume()
    }
    
    static func fetchCatImage(url: URL?, completion: @escaping (Result<UIImage, CatError>) -> Void){
        
        guard let urlToUse = url else {return completion(.failure(.invalidURL))}
        
        print(urlToUse)
        
        URLSession.shared.dataTask(with: urlToUse) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("CATIMAGE STATUS CODE \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            
            completion(.success(image))
            
        }.resume()
    }
}//End of class
