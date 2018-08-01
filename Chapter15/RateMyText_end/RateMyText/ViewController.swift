//
//  ViewController.swift
//  RateMyText
//
//  Created by Donny Wals on 11/09/2017.
//  Copyright © 2017 DonnyWals. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.cornerRadius = 6
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
    }

    @IBAction func analyze() {
        guard let text = textView.text
            else { return }
        
        let wordCount = getWordCounts(fromString: text)
        let model = SentimentPolarity()
        guard let prediction = try? model.prediction(input: wordCount)
            else { return }
        
        let alert = UIAlertController(title: nil, message: "Your text is rated: \(prediction.classLabel)", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    
    func getWordCounts(fromString string: String) -> [String: Double] {
        var wordCount = [String: Double]()
        let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
        tagger.string = string
        
        typealias TagEnumerating = (NSLinguisticTag?, NSRange, NSRange, UnsafeMutablePointer<ObjCBool>) -> Void
        let enumerateTag: TagEnumerating = { tag, token, sentence, stop in
            let word = (string as NSString).substring(with: token)
            wordCount[word] = (wordCount[word] ?? 0) + 1
        }
        tagger.enumerateTags(in: NSRange(location: 0, length: string.count), scheme: .tokenType,
                             options: [.omitPunctuation, .omitWhitespace, .omitOther], using: enumerateTag)
        
        return wordCount
    }
}

