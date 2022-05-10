//
//  ConfirmationViewController.swift
//  map2
//
//  Created by user on 12/14/21.
//

import UIKit
import FirebaseStorage
import Firebase
import CoreLocation

class ConfirmationViewController: UIViewController {

    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var typeTF: UILabel!
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var addressTF: UILabel!
    @IBOutlet weak var addDetailsTF: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var typeResource = String()
    var nameResource = String()
    var addressResource = String()
    var addDetailsResource = String()
    var image: UIImage?
    var coor = [Double?]()
    var imageUrl0 : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeTF.text = typeResource
        nameTF.text = nameResource
        addressTF.text = addressResource
        addDetailsTF.text = addDetailsResource
        userImage.image = image
        print("Confirmation:  \(addressResource) ")
        
    }
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location?.coordinate else {
                      completion(nil)
                      return
                  }
            print(address)
            completion(location)
        }
    }
    
    @IBAction func confirmActionBtn(_ sender: UIButton) {
        getLocation(from: addressResource){
            location in
            print(location.debugDescription)
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressResource) { placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            
            if let unwrappedURL = self.imageUrl0{
                self.uploadToCloud(fileUrl: unwrappedURL)
                self.db.collection("pantries").addDocument(data: ["resourceType": self.typeResource, "name": self.nameResource, "address": self.addressResource, "coordinates": [lat, lon], "addDetails": self.addDetailsResource, "imageURL": self.imagePathName]) { error in
                    if let error = error {
                        print("The was an error: \(error.localizedDescription)")
                    } else {
                        print("Writing data has been successful!")
                    }
            }
            
        }
    }
    }
    var imagePathName = String()
    func uploadToCloud(fileUrl: URL){
        let storageRef = storage.reference()
        let localFile = fileUrl
        let imageName = NSUUID().uuidString
        imagePathName = imageName
        let photoRef = storageRef.child(imageName)
        photoRef.putFile(from: localFile, metadata: nil){ metadata, error in
            guard error == nil else{
                return
            }
        }
    }
    
}
