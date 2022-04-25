//
//  RoundsViewController.swift
//  Game
//
//  Created by angel zambrano on 8/24/21.
//

import UIKit

// this is the viewcontroller that is charge of presenting each round
class RoundsViewController: UIViewController {

    // MARK: propertiees
    var stackViewHorizontal = UIStackView()
    var secondHorizontalStackview = UIStackView()
    var nextButton = UIButton()
    var symbolOne = UIButton()
    var symbolTwo = UIButton()
    var symbolThree = UIButton()
    var symboldFour = UIButton()
    
    
    lazy var buttons = [symbolOne,symbolTwo,symbolThree, symboldFour]
    // allows us to convert to the button to a specific shape
    lazy var buttonToShape = [symbolOne: shape.square,symbolTwo: shape.circle,symbolThree: shape.triangle,symboldFour: shape.star]
    // allows us to  reference a shape to a specific button
    lazy var ShapeToButton = [shape.square : symbolOne,shape.circle : symbolTwo,shape.triangle : symbolThree,shape.star : symboldFour]

    // delegate game data back
    weak var delegate: GameData?

    var game  = Memorize()
    var shapesToShowToTheUser = [shape]()
    
    // Initializers
    init(memorizeGame: Memorize) {
        super.init(nibName: nil, bundle: nil)
        self.game = memorizeGame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 31/255, green: 5/255, blue: 187/255, alpha: 1)
        // Do any additional setup after loading the view.
        setUpViews()
        setUpConstraints()
        shapesToShowToTheUser = game.getRandomShapes()
        
        
        
        // gets the first shape to display to the user
        ShapeToButton[shapesToShowToTheUser.removeFirst()]?.backgroundColor = UIColor(red: 45/255, green: 41/255, blue: 251/255, alpha: 0.5)
        
    }
    
    // MARK: setting up action button
    
    @objc func symbolButtonWasPressed(with button: UIButton) {
        // you clear all of the other buttons
        buttons.forEach({$0.backgroundColor = .clear})
        buttons.forEach({$0.isSelected = false})
        // you highlight the button that you currently have right now
        button.isSelected = true
        button.backgroundColor = UIColor(red: 45/255, green: 41/255, blue: 251/255, alpha: 0.5)
    }
    
    // this is called when presenting the shjapes the user has to remember
    @objc func nextButtonWasPresssed(with button: UIButton) {
        // make sure that we still have enough shapes
        if shapesToShowToTheUser.count > 0 {
          // choose a new shape
            buttons.forEach({$0.backgroundColor = .clear})
            ShapeToButton[shapesToShowToTheUser.removeFirst()]?.backgroundColor = UIColor(red: 45/255, green: 41/255, blue: 251/255, alpha: 0.5)
           
        }
        else if shapesToShowToTheUser.count == 0 {
            // ask user to start the actual entering of shapes
            buttons.forEach({$0.backgroundColor = .clear})
            buttons.forEach({$0.isEnabled = false})
            nextButton.setTitle("Start", for: .normal)
            // change the targets
            nextButton.removeTarget(self, action: #selector(nextButtonWasPresssed), for: .touchUpInside)
            nextButton.addTarget(self, action: #selector(startButtonWasPressed), for: .touchUpInside)
            
        }
        
    }
    
    // this is called whenever the user decides to start entering shapes
    @objc func startButtonWasPressed() {
        
        buttons.forEach({$0.isEnabled = true})
        nextButton.setTitle("Next", for: .normal)
        // changing targets
        nextButton.removeTarget(self, action: #selector(startButtonWasPressed), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(newNextButtonWasPressed), for: .touchUpInside)
        title = "Round \(String(game.currentRound))"
    }
    

    // this is called when the user is entering shapaes
    @objc func newNextButtonWasPressed() {
        
        
        if let selectedButton = buttons.first(where: {$0.isSelected}) {
            game.enter(shape: buttonToShape[selectedButton]!)
            buttons.forEach({$0.isSelected = false; $0.backgroundColor = .clear})
            
        } else {
            // throw an alert: Select a sometih
            // create an alert when the user has not entered a value greater than zero
            let alert = UIAlertController(title: "Error", message: "You didnt choose a shape", preferredStyle: .alert)
            // create alert action
            alert.addAction(UIAlertAction(title: "Oops", style: .default, handler: nil))
            // presenting the alert
            self.present(alert, animated: true)
        }
        
        
        
        if game.totalRounds == game.userChosenShapes.count {
            // reset everything
            buttons.forEach({$0.isSelected = false; $0.backgroundColor = .clear; $0.isEnabled = false})
            nextButton.removeTarget(self, action: #selector(newNextButtonWasPressed), for: .touchUpInside)
            nextButton.addTarget(self, action: #selector(finishGameButtonIsPressed), for: .touchUpInside)
            nextButton.setTitle("Finish", for: .normal)
            // delegate my data back
            delegate?.gameData(memorize: game) // pass the game data on to the new viewcontroller
            
        } else {
            title = "Round \(String(game.currentRound))"
        }
        
       
    }
    
    // this is called when my finish game is pressed
    @objc func finishGameButtonIsPressed(){
        // get the results 
        game.endGame()
        // pop view controller
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: setting up views
    func setUpViews() {
        // adds a square image
        symbolOne.update(title: "Square", cornerRadius: 25, backgroundColor: .clear)
        symbolOne.addTarget(self, action: #selector(symbolButtonWasPressed), for: .touchUpInside)
        symbolOne.isEnabled = false
        symbolOne.adjustsImageWhenDisabled = false
        view.addSubview(symbolOne)
        
        // adds a circle image
        symbolTwo.update(title: "Circle", cornerRadius: 25, backgroundColor: .clear)
        symbolTwo.addTarget(self, action: #selector(symbolButtonWasPressed), for: .touchUpInside)
        symbolTwo.adjustsImageWhenDisabled = false
        symbolTwo.isEnabled = false
        
        view.addSubview(symbolTwo)
        // adds a Triangle image
        symbolThree.update(title: "Triangle", cornerRadius: 25, backgroundColor: .clear)
        symbolThree.addTarget(self, action: #selector(symbolButtonWasPressed), for: .touchUpInside)
        symbolThree.adjustsImageWhenDisabled = false
        symbolThree.isEnabled = false
       
        view.addSubview(symbolThree)
        // adds a Star image
        symboldFour.update(title: "Star", cornerRadius: 25, backgroundColor: .clear)
        symboldFour.addTarget(self, action: #selector(symbolButtonWasPressed), for: .touchUpInside)
        symboldFour.adjustsImageWhenDisabled = false
        symboldFour.isEnabled = false
        view.addSubview(symboldFour)
        
        stackViewHorizontal = UIStackView(arrangedSubviews: [symbolOne, symbolTwo])
        stackViewHorizontal.update(axis: .horizontal, distribution: .equalSpacing, alignment: .center, color: .clear)
        
        self.view.addSubview(stackViewHorizontal)
        
        secondHorizontalStackview = UIStackView(arrangedSubviews: [symbolThree, symboldFour])
        secondHorizontalStackview.update(axis: .horizontal, distribution: .equalSpacing, alignment: .center, color: .clear)
        self.view.addSubview(secondHorizontalStackview)
        
        nextButton.setTitle("Next >", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20) // sets the size of the font
        nextButton.layer.cornerRadius = 24
        nextButton.addTarget(self, action: #selector(nextButtonWasPresssed), for: .touchUpInside)
        nextButton.backgroundColor = UIColor(red: 45/255, green: 41/255, blue: 251/255, alpha: 1)
        nextButton.addShadow(offset: CGSize(width: 2, height: 2), color: UIColor.black, radius: 2, opacity: 0.35)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton) // adds the subview
        
    }
    

    func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            symbolOne.widthAnchor.constraint(equalToConstant: 150),
            symbolOne.heightAnchor.constraint(equalToConstant: 150),
            
            symbolTwo.widthAnchor.constraint(equalToConstant: 150),
            symbolTwo.heightAnchor.constraint(equalToConstant: 150),
            
            symbolThree.widthAnchor.constraint(equalToConstant: 150),
            symbolThree.heightAnchor.constraint(equalToConstant: 150),
            
            symboldFour.widthAnchor.constraint(equalToConstant: 150),
            symboldFour.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        // constraints for stackview
        NSLayoutConstraint.activate([
            stackViewHorizontal.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
            stackViewHorizontal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewHorizontal.heightAnchor.constraint(equalToConstant: 150),
            stackViewHorizontal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            stackViewHorizontal.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
        
        
        NSLayoutConstraint.activate([
            secondHorizontalStackview.topAnchor.constraint(equalTo: stackViewHorizontal.bottomAnchor, constant: 110),
            secondHorizontalStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondHorizontalStackview.heightAnchor.constraint(equalToConstant: 150),
            secondHorizontalStackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            secondHorizontalStackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38),
            nextButton.heightAnchor.constraint(equalToConstant: 68)
        ])
   
    }
    

}
 
extension UIButton {
    
    func update(title: String, cornerRadius: CGFloat, backgroundColor: UIColor  ) {
        let image = UIImage(named: title) // image
        let alwaysOrgininal = image?.withRenderingMode(.alwaysOriginal) // disabled the color change
        self.setImage(alwaysOrgininal, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsImageWhenHighlighted = false
    }

}

extension UIStackView {
    
    func update( axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment:UIStackView.Alignment, color: UIColor  ) {
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.backgroundColor = color
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
