//
//  ViewController.swift
//  quoteApp
//
//  Created by Magdalena Toczek on 28/03/2021.
//

import UIKit

class QuoteVC: UIViewController {
  
    

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tagTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var quoteTextLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var listBtn: UIButton!
    let quotesManager = QuotesManager()
    var genre: String?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.tagTextLabel.alpha = 0.0
        self.authorTextLabel.alpha = 0.0
        self.quoteTextLabel.alpha = 0.0
        
        setUpView(genre: genre)
        
        listBtn.layer.cornerRadius = CGFloat(20.0)
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(_:)))
        panRecognizer.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(panRecognizer)
        
}
    
    
    func hideViewElements(){
      
        UIView.animate(withDuration: 1){
            self.tagTextLabel.alpha = 0.0
            self.authorTextLabel.alpha = 0.0
            self.quoteTextLabel.alpha = 0.0
            self.backgroundImageView.alpha = 0.4
        }
    }
    
    
    func setUpView(genre: String?) {
       
      hideViewElements()
      downloadQuoteAndImage(genre: genre)
    }
    
    
    func downloadQuoteAndImage(genre: String?){
        quotesManager.combineQuoteAndImage(genre: genre) { (quote, image) in
            DispatchQueue.main.async  {
                    self.tagTextLabel.text = "#" + quote.quoteGenre
                    self.authorTextLabel.text = quote.quoteAuthor
                    self.quoteTextLabel.text = quote.quoteText
                    self.backgroundImageView.image = image.withAlignmentRectInsets(UIEdgeInsets(top:60, left: 0, bottom: 0, right: 0))
              
                UIView.animate(withDuration: 2) {
                        self.tagTextLabel.alpha = 1.0
                        self.authorTextLabel.alpha = 1.0
                        self.quoteTextLabel.alpha = 1.0
                        self.backgroundImageView.alpha = 1.0
                    }
            }
        }
    }
    

  
    @objc func handlePanGestureRecognizer(_ recognizer: UIPanGestureRecognizer){
        var changeQuote = false
        let velocity = recognizer.velocity(in: self.view)
        
        if velocity.x > 500 || velocity.x < -500 {
            changeQuote = true
        }

        if recognizer.state == .ended && changeQuote == true{
            setUpView(genre: genre)
        }
    }
    
    


    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @IBAction func listBtnClicked(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(identifier: "GenreVC") as! GenreVC
        vc.delegate = self
        vc.quotesManager = quotesManager
        vc.preferredContentSize = CGSize(width: 200, height: 400)
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = self
        present(vc, animated: true, completion: nil)
        vc.popoverPresentationController?.sourceView = sender
        vc.popoverPresentationController?.sourceRect = sender.bounds

    }
}





//MARK:- EXTENSIONS
extension QuoteVC:  UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}



extension QuoteVC: CategoryDelegate {
    
    func selectedCategory(category: String) {
      genre = category
      setUpView(genre: genre)
        
    }
    
}







