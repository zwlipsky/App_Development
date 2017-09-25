//
//  ViewController.swift
//  Tesseract_Tester
//
//  Created by Cody Fizette on 6/28/17.
//  Copyright © 2017 Cody Fizette. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate{

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Create dictionary from the text file... hope it works!
        //let path:String = Bundle.main.path(forResource: "formattedIngredients", ofType: "txt")!
        //let string = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        //dict = (string?.components(separatedBy: "\n"))!
        //print(string)
        //print(dict)
        
        //var string = ""
       // do{
          //  string = try String(contentsOfFile: "formattedIngredients.txt")
        //}catch let error as NSError{
         //   print("failed to read file")
        //    print(error)
        //}
        
        //dict = string.components(separatedBy: "\n")
        
        loadDict(path : "formattedIngredients 2")
    }
    
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
        
    }
    
    	
    
    func button1Pressed(_ sender: Any) {
        if let tesseract = G8Tesseract(language :"eng"){
            tesseract.delegate = self
            tesseract.image = UIImage(named: "img1")?.g8_blackAndWhite()
            tesseract.recognize()
            imageView.image = tesseract.image
            textView.text = tesseract.recognizedText
            print(replaceStrings(stringArray: textToArray(text: tesseract.recognizedText), dictionary: dict))
        }
    }
    
    func button2Pressed(_ sender: Any) {
        if let tesseract = G8Tesseract(language :"eng"){
            tesseract.delegate = self
            tesseract.image = UIImage(named: "img2")?.g8_blackAndWhite()
            tesseract.recognize()
            imageView.image = tesseract.image
            textView.text = tesseract.recognizedText
            print(replaceStrings(stringArray: textToArray(text: tesseract.recognizedText), dictionary: dict))
        }
    }
    func button3Pressed(_ sender: Any) {
        if let tesseract = G8Tesseract(language :"eng"){
            tesseract.delegate = self
            tesseract.image = UIImage(named: "img3")?.g8_blackAndWhite()
            tesseract.recognize()
            imageView.image = tesseract.image
            textView.text = tesseract.recognizedText
            print(replaceStrings(stringArray: textToArray(text: tesseract.recognizedText), dictionary: dict))
        }
    }
    func button4(_ sender: Any) {
        if let tesseract = G8Tesseract(language :"eng"){
            tesseract.delegate = self
            tesseract.image = UIImage(named: "img4")?.g8_blackAndWhite()
            tesseract.recognize()
            imageView.image = tesseract.image
            textView.text = tesseract.recognizedText
            print(replaceStrings(stringArray: textToArray(text: tesseract.recognizedText), dictionary: dict))
        }
    }
     func button5Pressed(_ sender: Any) {
        if let tesseract = G8Tesseract(language :"eng"){
            tesseract.delegate = self
            tesseract.image = UIImage(named: "img6_2")?.g8_blackAndWhite()
            tesseract.recognize()
            imageView.image = tesseract.image
            textView.text = tesseract.recognizedText
           print(replaceStrings(stringArray: textToArray(text: tesseract.recognizedText), dictionary: dict))
        }
    }
     func button6Pressed(_ sender: Any) {
        if let tesseract = G8Tesseract(language :"eng"){
            tesseract.delegate = self
            tesseract.image = UIImage(named: "img6")?.g8_blackAndWhite()
            tesseract.recognize()
            imageView.image = tesseract.image
            textView.text = tesseract.recognizedText
           print(replaceStrings(stringArray: textToArray(text: tesseract.recognizedText), dictionary: dict))
        }
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

