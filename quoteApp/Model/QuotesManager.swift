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
    let url_quotes_random_with_genre = "https://quote-garden.herokuapp.com/api/v3/quotes/random?genre="
    let url_genres = "https://quote-garden.herokuapp.com/api/v3/genres"
    
    let url_pic = "https://picsum.photos/450/950"


    
    func prepareQuote(genre: String?, completion: @escaping(QuoteModel)->Void){
        
        var url: String
        if let genre = genre {
            url = url_quotes_random_with_genre + genre
        } else {
            url = url_quotes_random
        }
        
        DataService.INSTANCE.downloadData(fromUrl: url) { (data) in
            let quote = self.decodeJsonDataForQuotes(data: data)
            completion(quote)
        }
    }
    
    
    func decodeJsonDataForQuotes(data: Data) -> QuoteModel {
        
        var quotes = [QuoteModel]()
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(MainData.self, from: data)
            for quote in decoderData.data {
                let quoteModel = QuoteModel(quoteText: quote.quoteText, quoteAuthor: quote.quoteAuthor, quoteGenre: quote.quoteGenre)
                quotes.append(quoteModel)
            }
        } catch{
            print("there was a problem with decoding data")
            print(error)
        }
        return quotes[0]
    }
    
    
    
    
    func prepareGenres (completion: @escaping([String])->Void){
        
        let url = url_genres
        DataService.INSTANCE.downloadData(fromUrl: url) { (data) in
            let listOfGenres = self.decodeJsonDataForGenres(data: data)
            completion(listOfGenres)
        }
    }
    
    
    
    func decodeJsonDataForGenres(data: Data) -> [String] {
        var genres = [String]()
        let decoder = JSONDecoder()
        
        do{
            let decoderData = try decoder.decode(Genre.self, from: data)
            for genre in decoderData.data {
                genres.append(genre)
            }
        } catch{
            print("there was a problem with decoding data - genres")
            print(error)
        }
        return genres
    }
    
    

    
    func downloadImage(completion: @escaping(UIImage)->Void){
        let  url = url_pic
        DataService.INSTANCE.downloadData(fromUrl: url) { (imageData) in
            let imge = UIImage(data: imageData)
            completion(imge!)
        }
    }
    
    
    
    
    func combineQuoteAndImage(genre: String?, completion: @escaping (_ quote: QuoteModel, _ image: UIImage )-> Void){
        prepareQuote(genre: genre) { (quote) in
            self.downloadImage { (image) in
                completion(quote,image)
            }
        }
    }
    
    

    
 
    
}
