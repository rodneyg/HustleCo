//
//  ViewController.swift
//  HustleCo
//
//  Created by Rodney Gainous Jr on 12/20/16.
//  Copyright © 2016 Rodney Gainous Jr. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var headline: UILabel!
    @IBOutlet var writer: UIButton!
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var readButton: UIButton!
    @IBOutlet var writerImage: UIImageView!
    
    var currentArticle: Article!
    var articles: ArticleQueue<Article>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapGesture()
        loadArticles()
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    func doubleTapped() {
        next()
    }
    
    //goes to next article in the queue, if empty loads more articles
    func next() {
        guard let next = articles.peek() else {
            loadArticles()
            return
        }
        
        currentArticle = next
        animate()
        
        //change text
        headline.text = currentArticle.headline
        writer.setTitle(currentArticle.writer, for: .normal)
    }
    
    //animates the background and writer image
    func animate() {
        guard let bgImg = UIImage(named: currentArticle.imageName), let writerImg = UIImage(named: currentArticle.writerImage) else {
            print("Could not load images")
            return
        }
        
        //fade animation on images
        UIView.transition(with: bgImage, duration: 0.85, options: .curveEaseInOut, animations: {
            self.bgImage.image = bgImg
            }, completion: nil)
        
        UIView.transition(with: writerImage, duration: 0.85, options: .curveEaseInOut, animations: {
            self.writerImage.image = writerImg
            }, completion: nil)
    }
    
    @IBAction func messageTouched(_ sender: AnyObject) {
        performSegue(withIdentifier: "", sender: self)
    }
    
    @IBAction func readTouched(_ sender: AnyObject) {
        performSegue(withIdentifier: "", sender: self)
    }
    
    //loads articles and parses them
    func loadArticles() {
        guard let json = loadJson("Articles.json") else { return }
        
        parseArticles(json: json)
    }
    
    //parse articles from json dictionary and add to queue
    func parseArticles(json: NSDictionary) {
        guard let articlesJson : NSArray = json["articles"] as? NSArray else {
            print("Error! Unable to parse articles")
            return
        }
        
        articles = ArticleQueue<Article>()
        for articleJson in articlesJson {
            let article = Article(json: articleJson as! NSDictionary)
            articles.enqueue(article)
        }
    }
    
    //load json from file
    func loadJson(_ fileName: String) -> NSDictionary? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
        let data = NSData(contentsOf: url) else {
            print("Error! Unable to load \(fileName).json")
            return nil
        }
        
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
            
            return dictionary
        } catch {
            print("Error! Unable to parse \(fileName).json")
            return nil
        }
    }
}

