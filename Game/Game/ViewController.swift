//
//  ViewController.swift
//  Game
//
//  Created by angel zambrano on 8/23/21.
//

import UIKit

// used to pass data between view controllers
protocol GameData: AnyObject  {
    func gameData(memorize: Memorize)
}


class ViewController: UIViewController {
    
    // rounds label
    
   private var RoundsView = UIView()
   private var numberOfroundsLbl = UILabel() // states how many rounds the user will play
   private var roundsTitleLbl = UILabel() // the title
   private var stepper = UIStepper()
   private var memorizeButton = UIButton()
   private var resultsButton = UIButton()
    
    
    private lazy var memorizeGame = Memorize(rounds: Int(stepper.value))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 31/255, green: 5/255, blue: 187/255, alpha: 1)
        // Do any additional setup after loading the view.
        title = "Memory Game"
        setUpViews()
        setUpConstraints()
      
    }
    
    @objc func resultsButtonWasPressed() {
        // initialize the new VC
        let presentViewController =  ResultsViewController(memorizeGame: memorizeGame)
        // delegate the game model
        // presentViewController.delegate = self // we are passing self as delegate
        // present the new viewcontroller
        self.present(presentViewController, animated: true, completion: nil)
    }

    // MARK: button actions
    @objc func memorizeButtonWasPressed() {
        
        if memorizeGame.totalRounds > 0 {
            // reset game
            memorizeGame.reset()
            // start the game
            memorizeGame.startGame()
            //  initialize the new VC
            let pushViewController = RoundsViewController(memorizeGame: memorizeGame)
            //  delegate the game
            pushViewController.delegate = self
            // push to the navigation controller
            navigationController?.pushViewController(pushViewController, animated: true)
        } else {
            // create an alert when the user has not entered a value greater than zero
            let alert = UIAlertController(title: "enter a rounds greater than zero", message: nil, preferredStyle: .alert)
            // create alert action
            alert.addAction(UIAlertAction(title: "Opps", style: .default, handler: nil))
            // presenting the alert
            self.present(alert, animated: true)
            
            
        }
    }
    
    
    
    // MARK: set up the views
    
    func setUpViews() {
        RoundsView.backgroundColor = UIColor(red: 45/255, green: 41/255, blue: 251/255, alpha: 1)
        RoundsView.layer.cornerRadius = 25
        RoundsView.addShadow(offset: CGSize(width: 2, height: 2), color: UIColor.black, radius: 2, opacity: 0.35)
        RoundsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(RoundsView)
        
        
        // adding subview
        numberOfroundsLbl.update(text: "1", textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 120), color: .white)
        view.addSubview(numberOfroundsLbl)
        
        // creating the results title lbael
        roundsTitleLbl.update(text: "ROUNDS", textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 30), color: .white)
        view.addSubview(roundsTitleLbl)
     
        // creating memorize button
        memorizeButton.setTitle("Memorize >", for: .normal)
        memorizeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // sets the size of the font
        memorizeButton.layer.cornerRadius = 24
        memorizeButton.backgroundColor = UIColor(red: 45/255, green: 41/255, blue: 251/255, alpha: 1)
        memorizeButton.addShadow(offset: CGSize(width: 2, height: 2), color: UIColor.black, radius: 2, opacity: 0.35)
        
        memorizeButton.addTarget(self, action: #selector(memorizeButtonWasPressed), for: .touchUpInside)
        memorizeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(memorizeButton)
        
        // creaters the result button 
        resultsButton.setTitle("Results", for: .normal)
        resultsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // sets the size of the font
        resultsButton.setTitleColor(UIColor(red: 132/255, green: 130/255, blue: 255/255, alpha: 1), for: .normal)
        resultsButton.addTarget(self, action: #selector(resultsButtonWasPressed), for: .touchUpInside)
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultsButton)
        
        // creates a stepper
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(stepperWasPressed), for: .touchUpInside)
        stepper.backgroundColor = .white
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.layer.cornerRadius = 10
        view.addSubview(stepper)
        
        memorizeGame.totalRounds = Int(stepper.value)
        numberOfroundsLbl.text = String(Int(stepper.value))
    }
    
    // modifies the game rounds and our rounds label
    @objc func stepperWasPressed() {
        memorizeGame.totalRounds = Int(stepper.value)
        numberOfroundsLbl.text = String(memorizeGame.totalRounds)
    }
    
    
    private func setUpConstraints(){
        
        // first view
        NSLayoutConstraint.activate([
            RoundsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 107),
            RoundsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            RoundsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            RoundsView.heightAnchor.constraint(equalToConstant: 360)
        ])
        
        // constraints for the number of rounds label
        NSLayoutConstraint.activate([
            numberOfroundsLbl.topAnchor.constraint(equalTo: RoundsView.topAnchor, constant: 59),
            numberOfroundsLbl.centerXAnchor.constraint(equalTo: RoundsView.centerXAnchor)
        ])
        
        // constraints for rounds title Lbls
        NSLayoutConstraint.activate([
            roundsTitleLbl.topAnchor.constraint(equalTo: numberOfroundsLbl.bottomAnchor, constant: 9),
            roundsTitleLbl.centerXAnchor.constraint(equalTo: RoundsView.centerXAnchor)
        ])
        
        // constraints for segmented control
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: roundsTitleLbl.bottomAnchor, constant: 25),
            stepper.centerXAnchor.constraint(equalTo: RoundsView.centerXAnchor),
            stepper.widthAnchor.constraint(equalToConstant: 100)
        
        ])
        
        // the constraints for the memorize button
        NSLayoutConstraint.activate([
            memorizeButton.topAnchor.constraint(equalTo: RoundsView.bottomAnchor, constant: 121),
            memorizeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            memorizeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38),
            memorizeButton.heightAnchor.constraint(equalToConstant: 100)
        
        ])
        
        // the constraints for the results button
        NSLayoutConstraint.activate([
            resultsButton.topAnchor.constraint(equalTo: memorizeButton.bottomAnchor, constant: 24),
            resultsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}

extension UILabel {
    func update(text: String, textAlignment: NSTextAlignment, font: UIFont, color: UIColor ) {
        self.text = text
        self.textAlignment = textAlignment
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = color
        
    }
    
}


extension UIView {
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.cornerRadius = 24
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity =  opacity
        layer.shadowRadius = radius
    }
}


// implementation of GameData
extension ViewController: GameData {
    func gameData(memorize: Memorize) {
        self.memorizeGame = memorize
    }
}
