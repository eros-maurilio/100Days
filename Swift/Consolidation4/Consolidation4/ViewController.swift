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
    var currentWord = "silkworm"
    var usedLetter = [String]()
    var transformWord: [String] = []
    var wordChanges = [String]()
    var wordComplete = true
    var numOfErrors = 0
    var cellsSelected = [IndexPath]()
    var score = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Hangman"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGameTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(scoreAlert))
        
        performSelector(inBackground: #selector(loadWords), with: nil)
    }
    
    @objc func newGameTapped() {
        let ac = UIAlertController(title: "New Game", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in
            self.performSelector(inBackground: #selector(self.loadWords), with: nil)
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
        present(ac, animated: true)
        
    }
    
    @objc func scoreAlert() {
        let ac = UIAlertController(title: "Score", message: "Your Score is: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    @objc func loadWords() {
        if let startWordsURL = Bundle.main.url(forResource: "english", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["Error"]
        }
        
        performSelector(onMainThread: #selector(startGame), with: nil, waitUntilDone: false)
        
    }
    
    @objc func startGame() {
        currentWord = allWords.randomElement()!.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        print(currentWord)
        
        currentWordLabel.text = String(repeating: "_ ", count: currentWord.count).trimmingCharacters(in: .whitespaces)
        
        numOfErrors = 0
        usedLetter = [String]()
        imageView.image = UIImage(named: "hangman\(numOfErrors)")
        collectionView.reloadData()

    }
    
    func letterTapped(_ str: String) -> Bool{
        let letter = str
        var isCorrect: Bool
        
        if currentWord.contains(letter) {
            usedLetter.append(letter)
            
            manageCorrectGuess()
            isCorrect = true
            
        } else {
            manageIncorrectGuess()
            isCorrect = false
        }
        
        return isCorrect
    }
    
    func manageCorrectGuess() {
        var wordText = ""
        wordComplete = true
        
        for letter in currentWord {
            let strLetter = String(letter)
            
            if usedLetter.contains(strLetter) {
                wordText += "\(strLetter) "
                
            } else {
                wordText += "_ "
                wordComplete = false
            }
        }
        
        currentWordLabel.text = wordText.trimmingCharacters(in: .whitespaces)
        
        if wordComplete {
            score += 2
            print(score)
            collectionView.reloadData()
            
            let ac = UIAlertController(title: "Congratulation", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in
                self.performSelector(inBackground: #selector(self.loadWords), with: nil)
            }))
            present(ac, animated: true)
            
            

        }
    }
    
    func manageIncorrectGuess() {
        numOfErrors += 1
        imageView.image = UIImage(named: "hangman\(numOfErrors)")
        
        if numOfErrors == 7 {
            
            score -= 1
            
            let ac = UIAlertController(title: "Sorry", message: "Current word was: \(currentWord)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            
            collectionView.reloadData()
            
            performSelector(inBackground: #selector(loadWords), with: nil)
        }
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
        let cell = collectionView.cellForItem(at: indexPath)
        
        letterTapped(alphabet[indexPath.item])
        
        cell?.layer.opacity = (wordComplete ? 0 : 0.5)
        
    }
}

