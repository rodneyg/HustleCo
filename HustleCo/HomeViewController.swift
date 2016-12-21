//
//  ViewController.swift
//  HustleCo
//
//  Created by Rodney Gainous Jr on 12/20/16.
//  Copyright © 2016 Rodney Gainous Jr. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var headline: UILabel!
    @IBOutlet var writer: UIButton!
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var readButton: UIButton!
    
    var currentArticle: Article!
    var articles: ArticleQueue<Article>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArticles()
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    func doubleTapped() {
        
    }
    
    func next() {
        guard let next = articles.peek() else {
            loadArticles()
            return
        }
        
        
    }
    
    func animate() {
        
    }
    
    @IBAction func messageTouched(_ sender: AnyObject) {
        performSegue(withIdentifier: "", sender: self)
    }
    
    @IBAction func readTouched(_ sender: AnyObject) {
        performSegue(withIdentifier: "", sender: self)
    }
    
    func loadArticles() {
        guard let json = loadJson("Articles.json") else { return }
        
        parseArticles(json: json)
    }
    
    func parseArticles(json: NSDictionary) {
        guard let articlesJson : NSArray = json["articles"] as? NSArray else {
            print("Error!! Unable to parse articles")
            return
        }
        
        articles = ArticleQueue<Article>()
        for articleJson in articlesJson {
            let article = Article(json: articleJson as! NSDictionary)
            articles.enqueue(article)
        }
    }
    
    func loadJson(_ fileName: String) -> NSDictionary? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        
        guard let data = NSData(contentsOf: url) else {
            print("Error!! Unable to load  \(fileName).json")
            return nil
        }
        
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? NSDictionary
            
            return dictionary
        } catch {
            print("Error!! Unable to parse  \(fileName).json")
        }
        
        return nil
    }
}

