//
//  NetworkService.swift
//  ShapesDemo
//
//  Created by Morshed Alam on 4/5/25.
//
import Foundation

protocol ShapesServiceProtocol {
    func fetchAllShapes() async throws -> Data
}

struct ShapesService : ShapesServiceProtocol {
    
    func fetchAllShapes() async throws -> Data  {
        
        guard let url = URL(string: "http://staticcontent.cricut.com/static/test/shapes_001.json") else {
           throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatus(httpResponse.statusCode)
        }
        
        return data
            
    }
   
}

enum NetworkError : Error {
    case invalidUrl
    case invalidResponse
    case invalidStatus(Int)
}
