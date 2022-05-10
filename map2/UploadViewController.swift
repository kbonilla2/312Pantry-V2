//
//  UploadViewController.swift
//  map2
//
//  Created by user on 12/7/21.
//

import UIKit
import FirebaseStorage
import Firebase
import CoreLocation

class UploadViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let database = Firestore.firestore()
    var uploadArray = [UserUpload]()
    
    let geoCoder = CLGeocoder()
    var resourceType = ""
    
    var imageUpload : UIImage?
    var coordinates = [Double?]()
    
    var imageUrl : URL?
    
    @IBOutlet weak var fridgeBtn: UIButton!
    @IBOutlet weak var pantryBtn: UIButton!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addDetailsLabel: UILabel!
    @IBOutlet weak var instrucLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addDetailsTextField: UITextField!
    
    @IBOutlet weak var submitBtnRef: UIButton!
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        instrucLabel.sizeToFit()
        
        nameTextField.delegate = self
        locationTextField.delegate = self
        addDetailsTextField.delegate = self
        
        updateSubmitBtn()
        imagePicker.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        addDetailsTextField.resignFirstResponder()
        
        return true
    }
    
//    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
//        let geocoder = CLGeocoder()
//        geocoder.geocodeAddressString(address) { (placemarks, error) in
//            guard let placemarks = placemarks,
//                  let location = placemarks.first?.location?.coordinate else {
//                      completion(nil)
//                      return
//                  }
//            print(address)
//            completion(location)
//        }
//    }
    
    @IBAction func locationAction(_ sender: UITextField){
        updateSubmitBtn()
    }
    
    func updateSubmitBtn() {
        let location = locationTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let addDetails = addDetailsTextField.text ?? ""
        
        
        submitBtnRef.isEnabled = !location.isEmpty && !name.isEmpty && !addDetails.isEmpty && (pantryBtn.isSelected || fridgeBtn.isSelected)
    }
    
    @IBAction func pantryBtnAction(_ sender: UIButton) {
        pantryBtn.isSelected = true
        fridgeBtn.isSelected = false
    }
    
    @IBAction func fridgeBtnAction(_ sender: UIButton) {
        pantryBtn.isSelected = false
        fridgeBtn.isSelected = true
    }
    
    // photo library
    @IBAction func cameraUploadBtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            //uploadToCloud(fileUrl: url)
            imageUrl = url
        }
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageUpload = image //copy of image
        }
        

        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    // camera upload
    @IBAction func photoUploadBtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                self.imagePicker.sourceType = .photoLibrary
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoLibraryAction)
        }
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
    }
    
    //SAVING USERS INPUT TO FIREBASE to create new annotation pin
    
    @IBAction func submitBtn(_ sender: UIButton) {
    
        if pantryBtn.isSelected{
            resourceType = "Pantry"
        }
        else if fridgeBtn.isSelected{
            resourceType = "Fridge"
        }
        
//        getLocation(from: locationTextField.text ?? "No location"){
//            location in
//            print(location.debugDescription)
//        }
        
        //var coordinates: [CLLocationDegrees]
        if let address = locationTextField.text, let addDetails = addDetailsTextField.text, let name = nameTextField.text {
            
            //geopoint
//            let geocoder = CLGeocoder()
//            geocoder.geocodeAddressString(address) { placemarks, error in
//                let placemark = placemarks?.first
//                let lat = placemark?.location?.coordinate.latitude
//                let lon = placemark?.location?.coordinate.longitude
//                self.coordinates = [lat, lon]
//                print(self.coordinates)
//                //let location = placemarks?.first?.location?.coordinate
////                self.database.collection("pantries").addDocument(data: ["resourceType": self.resourceType, "name": name, "address": address, "coordinates": [lat, lon], "addDetails": addDetails]) { error in
////                    if let error = error {
////                        print("The was an error: \(error.localizedDescription)")
////                    } else {
////                        print("Writing data has been successful!")
////                    }
////                    
////                }
//                
//            }
            
        }
        performSegue(withIdentifier: "submit", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "submit"{
            let confirmationViewController = segue.destination as! ConfirmationViewController
            //tableViewController.groceryList = groceryArray
            confirmationViewController.addDetailsResource = addDetailsTextField.text ?? ""
            confirmationViewController.typeResource = resourceType
            confirmationViewController.addressResource = locationTextField.text ?? ""
            confirmationViewController.nameResource = nameTextField.text ?? ""
            confirmationViewController.image = imageUpload // UIImage
            confirmationViewController.imageUrl0 = imageUrl
        }
    }
}


extension UploadViewController{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        locationTextField.resignFirstResponder()
        addDetailsTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        return true
    }
}

