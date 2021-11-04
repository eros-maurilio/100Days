//
//  ViewController.swift
//  Consolidation4
//
//  Created by Eros Maurilio on 03/11/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var allWords = [String]()
    let reuseIdentifier = "Cell"
    var alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var transformWord: [String] = []
    var wordChanges = "" {
        didSet {
            currentWordLabel.text = wordChanges
        }
    }
    @IBOutlet weak var currentWordLabel: UILabel!
    
    
    override func viewDidLoad() { 
        super.viewDidLoad()

        if let startWordsURL = Bundle.main.url(forResource: "english", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["Error"]
        }
        
        if let currentWord = allWords.randomElement() {
            currentWordLabel.text = currentWord
            let array = Array(currentWord)
            
            for letter in array {
                transformWord.append(letter)
            }
            
            for _ in 1..<transformWord.count {
                wordChanges += "_ "
            }
            
            print(Array(currentWord))
            print(String(Array(currentWord)))

        }
        title = "Hangman"
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { alphabet.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath  as IndexPath) as! MyCollectionViewCell
        cell.myLabel.text = alphabet[indexPath.row]
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tap at: \(indexPath.item)")
        print("\(alphabet[indexPath.item])")
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.opacity = 0.5
        cell?.isSelected = true
        
    }
}

