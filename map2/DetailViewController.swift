//
//  DetailViewController.swift
//  map2
//
//  Created by Katharine Bonilla on 12/18/21.
//

import UIKit
import MapKit
import Firebase
import FirebaseStorage

class DetailViewController: UIViewController {
    var annotation: MKPointAnnotation?
    //let database = Firestore.firestore()
    let storage = Storage.storage()
    var passedPantry: Pantry?

    @IBOutlet weak var resourceName: UILabel!
    @IBOutlet weak var resourceAddress: UILabel!
    @IBOutlet weak var resourceDescription: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadData()
        if let annotation = annotation {
            print(annotation.title)
        }
        if let pantry = passedPantry {
            resourceName.text = pantry.title
            resourceAddress.text = pantry.subtitle
            resourceDescription.text = pantry.description
            
            if let imageName = pantry.imagePath {
                  print(imageName)
                  loadImage(imageName: imageName)
                       
            }
            else {
                imageView.image = UIImage(named: "new-orange")
            }
        }
        else {
            resourceName.text = passedPantry?.title
            imageView.image = UIImage(named: "new-orange")
        }
        // Do any additional setup after loading the view.
    }
    
    func loadImage(imageName: String){
        let pathReference = self.storage.reference(withPath: "new-orange.png")
        
        pathReference.getData(maxSize: 5*1024*1024) { data, error in
            guard let data = data else{
                return
            }
            if let error = error{
                print(error)
            } else {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
