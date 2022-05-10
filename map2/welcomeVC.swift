//  welcomeVC.swift
//  map2
//
//  Created by Leona  Meharenna on 12/7/21.
//

import Foundation
import UIKit
import MapKit
class welcomeVC: UIViewController {
    @IBOutlet var holderView: UIView!
    
    
    let scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            configure()
    }
    
    private func configure() {
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        let titles = ["Types of pantries", "Find where to donate food", "Upload pantry locations", "Visualize your own pantry"]
        let textDesc = ["Learn more about the different types of pantries by clicking on any of the boxes above.", "Find pantries, fridges, and food banks near you. Use the map to find food dropoff centers near your home.", "Found a pantry, fridge, or food bank that's not already accounter for on the app? Upload the location yourself by using the app upload feature. Have a picture of the food center handy so that we can verify it.", "Feeling inspired to build your own pantry? Use the app's built in AR feature to see what a potential pantry could look like on your own yard."]
        for x in 0..<4 {
            
            
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height - 60, width: pageView.frame.size.width - 20, height: 50))
            let description = UILabel(frame: CGRect(x: 10, y: pageView.frame.size.height - pageView.frame.size.height * 2/5, width: pageView.frame.size.width - 40, height: 200))
            description.textAlignment = .center
            description.numberOfLines = 0
            description.textColor = UIColor(red: 105/255.0, green: 152/255.0, blue: 232/255.0, alpha: 1.0)
            description.font = UIFont(name: "Josefin Sans", size: 24)
            pageView.addSubview(description)
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = x+1
            pageView.addSubview(button)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont(name: "Josefin Sans", size: 20)

            button.backgroundColor = UIColor(red: 226/255.0, green: 161/255.0, blue: 91/255.0, alpha: 1.0)
            button.setTitle("Continue", for: .normal)
            if x == 0 {
                let tempLabel = UILabel(frame: CGRect(x: 0, y: pageView.frame.size.height/4, width: pageView.frame.size.width - 20, height: 120))
                let miniPantriesBtn = UIButton(frame: CGRect(x: 0, y: pageView.frame.size.height/2.5, width: pageView.frame.size.width/3, height: pageView.frame.size.width/3))
                let commFridgesBtn = UIButton(frame: CGRect(x: (pageView.frame.size.width/3), y: pageView.frame.size.height/2.5, width: pageView.frame.size.width/3, height: pageView.frame.size.width/3))
                let foodBanksBtn = UIButton(frame: CGRect(x: 2*(pageView.frame.size.width/3), y: pageView.frame.size.height/2.5, width: pageView.frame.size.width/3, height: pageView.frame.size.width/3))
                miniPantriesBtn.setTitleColor(.white, for: .normal)
                miniPantriesBtn.backgroundColor = UIColor(red: 226/255.0, green: 161/255.0, blue: 91/255.0, alpha: 1.0)
                commFridgesBtn.setTitleColor(.white, for: .normal)
                commFridgesBtn.backgroundColor = UIColor(red: 170/255.0, green: 121/255.0, blue: 66/255.0, alpha: 1.0)
                foodBanksBtn.setTitleColor(.white, for: .normal)
                foodBanksBtn.backgroundColor = UIColor(red: 105/255.0, green: 152/255.0, blue: 232/255.0, alpha: 1.0)
                miniPantriesBtn.setTitle("pantries", for: .normal)
                miniPantriesBtn.titleLabel?.font = UIFont(name: "Josefin Sans", size: 20)
                foodBanksBtn.titleLabel?.font = UIFont(name: "Josefin Sans", size: 20)
                commFridgesBtn.titleLabel?.font = UIFont(name: "Josefin Sans", size: 20)

                commFridgesBtn.setTitle("fridges", for: .normal)
                
                foodBanksBtn.setTitle("food banks", for: .normal)
                pageView.addSubview(tempLabel)
                tempLabel.font = UIFont(name: "Josefin Sans", size: 32)
                tempLabel.textColor = UIColor(red: 226/255.0, green: 161/255.0, blue: 91/255.0, alpha: 1.0)
                tempLabel.text = titles[x]
                pageView.addSubview(miniPantriesBtn)
                pageView.addSubview(commFridgesBtn)
                pageView.addSubview(foodBanksBtn)
                description.textAlignment = .left
                description.text = textDesc[x]
                
                miniPantriesBtn.addTarget(self, action: #selector(miniPantiesBtn(_:)), for: .touchUpInside)
                commFridgesBtn.addTarget(self, action: #selector(comFridgesBtn(_:)), for: .touchUpInside)
                foodBanksBtn.addTarget(self, action: #selector(foodBaksBtn(_:)), for: .touchUpInside)
                
            }
            else {
                let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width - 20, height: 120))
                let imageView = UIImageView(frame: CGRect(x: pageView.frame.size.width/2 - pageView.frame.size.width/3, y: 10+120+10, width: pageView.frame.size.width/1.5, height: pageView.frame.size.width/1.5))
                imageView.layer.cornerRadius = 25

                let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height - 60, width: pageView.frame.size.width - 20, height: 50))
    //            let miniPantriesBtn = UIButton(frame: CGRect(x: pageView.frame.size.width/2, y: pageView.frame.size.height/2, width: 150, height: 150))

                label.textAlignment = .center
                label.textColor = UIColor(red: 226/255.0, green: 161/255.0, blue: 91/255.0, alpha: 1.0)
                label.font = UIFont(name: "Josefin Sans", size: 32)
                pageView.addSubview(label)
                label.text = titles[x]
                label.numberOfLines = 0

                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(named: "mission_\(x)")
                pageView.addSubview(imageView)
                
                description.textAlignment = .left
                description.numberOfLines = 0
                description.textColor = UIColor(red: 105/255.0, green: 152/255.0, blue: 232/255.0, alpha: 1.0)

                description.font = UIFont(name: "Josefin Sans", size: 24)
                description.text = textDesc[x]

                

                
                if x == 3{
                    button.setTitle("Get started", for: .normal)
                }
                

            }
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton(_ button: UIButton){
        guard button.tag < 4 else {
            
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width*CGFloat(button.tag), y: 0), animated: true)
        
    }
    
    @objc func miniPantiesBtn(_ miniPantriesBtn: UIButton){
        let miniVC = storyboard?.instantiateViewController(withIdentifier: "other") as! miniPanties
        present(miniVC, animated: true)
        
    }
    
    @objc func comFridgesBtn(_ miniPantriesBtn: UIButton){
        let miniVC = storyboard?.instantiateViewController(withIdentifier: "other2") as! commFridges
        present(miniVC, animated: true)
        
    }
    @objc func foodBaksBtn(_ miniPantriesBtn: UIButton){
        let miniVC = storyboard?.instantiateViewController(withIdentifier: "other3") as! foodBanks
        present(miniVC, animated: true)
        
    }

}

class miniPanties: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

class commFridges: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

class foodBanks: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
