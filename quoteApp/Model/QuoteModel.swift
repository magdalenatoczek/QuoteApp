//
//  QuoteModel.swift
//  quoteApp
//
//  Created by Magdalena Toczek on 28/03/2021.
//

import Foundation

struct QuoteModel: Decodable {    
    let quoteText: String
    let quoteAuthor: String
    let quoteGenre: String
}
