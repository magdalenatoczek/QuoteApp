//
//  ViewController.swift
//  quoteApp
//
//  Created by Magdalena Toczek on 28/03/2021.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tagTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    let quotesManager = QuotesManager()
    var myQuotes = [QuoteModel]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hideViewElements()
        loadImage()
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        panRecognizer.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(panRecognizer)
}
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadRandomQuote()
    }
    
    
    func loadRandomQuote(){
        quotesManager.prepareDataForQuotes { (quotes) in
            DispatchQueue.main.async  {
                self.tagTextLabel.isHidden = false
                self.authorTextLabel.isHidden = false
                self.quoteTextLabel.isHidden = false
                self.tagTextLabel.text = "#" + quotes[0].quoteGenre
                self.authorTextLabel.text = quotes[0].quoteAuthor
                self.quoteTextLabel.text = quotes[0].quoteText
                print(quotes[0].quoteAuthor)
                UIView.animate(withDuration: 1.0) {
                    self.containerView.alpha = 1.0
               
                }
            }
        }
    }
    
    
    func loadImage(){
        quotesManager.downloadImage { (image) in
            DispatchQueue.main.async  {
                self.backgroundImageView.image = image.withAlignmentRectInsets(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
            self.backgroundImageView.clipsToBounds = true
                
                UIView.animate(withDuration: 1.0) {
                    self.backgroundImageView.alpha = 1.0
                }
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
  
    @objc func handlePanGestureRecognizer(_ recognizer: UIPanGestureRecognizer){
        var changeQuote = false
        let velocity = recognizer.velocity(in: self.view)
        
        if velocity.x > 500 || velocity.x < -500 {
            changeQuote = true
        }

        if recognizer.state == .ended && changeQuote == true{
            self.hideViewElements()
            loadImage()
            loadRandomQuote()
        }

    }
    
    
    func hideViewElements(){
        UIView.animate(withDuration: 1) {
            self.tagTextLabel.isHidden = true
            self.authorTextLabel.isHidden = true
            self.quoteTextLabel.isHidden = true
            self.containerView.alpha = 0.0
            self.backgroundImageView.alpha = 0.0
        }
        

    }
    
    
    
    
}
