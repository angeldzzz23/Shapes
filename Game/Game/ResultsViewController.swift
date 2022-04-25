//
//  ResultsViewController.swift
//  Game
//
//  Created by angel zambrano on 8/24/21.
//

import UIKit

class ResultsViewController: UIViewController {

    var exitButton = UIButton()
    var resultstitleLbl  = UILabel() // states the t
    var gameDesc = UILabel() // states the game description
    
    var game = Memorize(rounds: 0)
    
    
    
    init(memorizeGame: Memorize) {
        super.init(nibName: nil, bundle: nil)
        game = memorizeGame
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 31/255, green: 5/255, blue: 187/255, alpha: 1)
        // Do any additional setup after loading the view.
        title = "Results"
        setUpViews()
        setUpConstraints()
     
       
        
    }

    // MARK: BUtton actions
    
    // exits the result view controller
    @objc func exitButtonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Setting up views
    
    func setUpViews() {
        // creating the exit Button
        exitButton.setImage(UIImage(named: "Cancel"), for: .normal)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.addTarget(self, action: #selector(exitButtonWasPressed), for: .touchUpInside)
        view.addSubview(exitButton)
        
        // updates the result title label
        resultstitleLbl.update(text: "Results", textAlignment: .center, font: UIFont.boldSystemFont(ofSize: 14), color: .white)
        view.addSubview(resultstitleLbl)
        
        gameDesc.update(text: game.gameDescription, textAlignment: .center, font: UIFont.systemFont(ofSize: 12), color: .white)
        view.addSubview(gameDesc)
        
    }

    func setUpConstraints() {
        
        // adds constraints for the exit button
        NSLayoutConstraint.activate([
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 26)
        ])
        
        // adds constraints for the resultsTitleLbl
        NSLayoutConstraint.activate([
            resultstitleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            resultstitleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
        // adding constraints for the gameDesc
        NSLayoutConstraint.activate([
            gameDesc.topAnchor.constraint(equalTo: resultstitleLbl.topAnchor, constant: 58),
            gameDesc.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
       
    }

}
