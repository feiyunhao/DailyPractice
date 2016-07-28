//
//  ViewController.swift
//  Quiz
//
//  Created by feiyun on 16/7/26.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentQuestionIndex = 0;
    let answers = ["Grapes",
                   "14",
                   "Montpelier"]
    
    let questions = ["From what is cognac made?",
                     "What is 7+7?",
                     "What is the capital of Vermont?"]
    
    
    
    
    @IBOutlet weak var questuonLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBAction func showQuestion(sender: AnyObject) {
        currentQuestionIndex += 1
        if currentQuestionIndex == self.questions.count {
            currentQuestionIndex = 0
        }
        self.questuonLabel.text = questions[currentQuestionIndex];
        self.answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(sender: AnyObject) {
        self.answerLabel.text = answers[currentQuestionIndex]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

