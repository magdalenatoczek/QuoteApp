//
//  DataService.swift
//  quoteApp
//
//  Created by Magdalena Toczek on 28/03/2021.
//

import Foundation


class DataService {
    
    static let INSTANCE = DataService()
    private init(){}
    
    func downloadData(fromUrl url : String, completion: @escaping(Data)->Void){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let jsonData = data {
                    completion(jsonData)
                }
            }
            task.resume()
        }
    }
}
