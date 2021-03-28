//
//  Quotes.swift
//  quoteApp
//
//  Created by Magdalena Toczek on 28/03/2021.
//

import Foundation
import UIKit

class QuotesManager {
    
    let url_quotes_random = "https://quote-garden.herokuapp.com/api/v3/quotes/random"
    let url_quotes_list = "https://quote-garden.herokuapp.com/api/v3/quotes?limit=200"
    
    
    let url_pic = "https://picsum.photos/450/950"
    

    
    func prepareDataForQuotes(completion: @escaping([QuoteModel])->Void){

        //depending on switch and state
        var  url = url_quotes_random
        DataService.INSTANCE.downloadData(fromUrl: url) { (data) in
          let quotes = self.decodeJsonData(data: data)
          completion(quotes)
        }
    }
    
    
    func decodeJsonData(data: Data) -> [QuoteModel] {
        var quotes = [QuoteModel]()
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(MainData.self, from: data)
            for quote in decoderData.data {
                let quoteModel = QuoteModel(quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor, quoteGenre: quote.quoteGenre)
                quotes.append(quoteModel)
            }
        } catch{
            print("there was a problem in decoding data")
            print(error)
        }
        return quotes
    }
    
    
    func downloadImage(completion: @escaping(UIImage)->Void){
        var  url = url_pic
        DataService.INSTANCE.downloadData(fromUrl: url) { (imageData) in
            let imge = UIImage(data: imageData)
            completion(imge!)
        }
        
        
    }
    
    
    
}
