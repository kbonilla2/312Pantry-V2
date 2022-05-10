//
//  ViewController.swift
//  map2
//
//  Created by Katharine Bonilla on 11/28/21.
//

import CoreLocation
import MapKit
import UIKit
import FloatingPanel
import FirebaseStorage
import Firebase

class ViewController: UIViewController, SearchViewControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, FloatingPanelControllerDelegate {
    
    //segue to upload form page
    @IBOutlet weak var uploadFormBtn: UIBarButtonItem!
    
    let mapView = MKMapView()
    var panel: FloatingPanelController!
    
    
    var currentLocation = CLLocation()//
    let locationManager = CLLocationManager()//
    let database = Firestore.firestore()
    var pantries = [Pantry]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.frame = view.frame
        view.addSubview(mapView)
        title = "Locate"
        
        let searchVC = SearchViewController()
        searchVC.delegate = self
        mapView.delegate = self
        panel = FloatingPanelController()
        panel.set(contentViewController: searchVC)
        panel.addPanel(toParent: self)
        
        locationManager.delegate = self//
        locationManager.requestWhenInUseAuthorization()//
        locationManager.startUpdatingHeading()//
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()//updated stream of locations
        mapView.showsUserLocation = true
        panel = FloatingPanelController(delegate: self)
        panel.layout = MyFloatingPanelLayout()
        panel.invalidateLayout()
        loadData()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    func loadData() {
        database.collection("pantries").getDocuments { snapshot, error in
           
            self.pantries = []
            if let error = error{
                print(error)
            } else {
                
                if let snapshotDocuments = snapshot?.documents{
                    
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        var color0 = UIColor()
                        if let coordinates = data["coordinates"] as? [Double], let title = data["name"] as? String, let subtitle = data["address"] as? String, let resourceType = data["resourceType"] as? String, let imageURLString = data["imageURL"] as? String
                        
                        
                        //if let latitude = data["latitude"] as? Double, let longitude = data["longitude"] as? Double
                        {
                            //let newLocation = Location(coordinates: CLLocationCoordinate2D(latitude: cordinates[0], longitude: cordinates[1]))
                            if  resourceType == "Pantry" {
                                color0 = UIColor().pantryPurple
                                
                            }
                            else{
                                color0 = UIColor().brownFridge
                            }
                            let newPantry = Pantry(title: title, subtitle: subtitle, coordinate: CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1]), color: color0, imagePath: imageURLString)
                            
                            self.pantries.append(newPantry)
                            
                            //                            DispatchQueue.main.async {
                            //                                self.mapView.reloadInputViews()
                            //                            }
                                    
                            self.addAnnotations()
                           
                        }
                    }
                }
            }
        }

    }
    
    //var pantries = [Pantry]()
    private func addAnnotations() {
        //        let annotation = MKPointAnnotation()
        //        annotation.title = "Honey Love"
        //        annotation.coordinate = CLLocationCoordinate2D(latitude: 41.942855516317785, longitude: -87.70281977319313)
        //        mapView.addAnnotation(annotation)
        let pantry0 = Pantry(title: "Comida Para el Pueblo at La Michoacana", subtitle: "1855 S Blue Island Ave, Chicago, IL 60608", coordinate: CLLocationCoordinate2D(latitude: 41.85692365406121, longitude: -87.66167324443228), color: UIColor().pantryPurple)
        pantries.append(pantry0)
        
        let pantry1 = Pantry(title: "Patchwork Farms", subtitle: "2825 W Chicago Ave, Chicago, IL 60622", coordinate: CLLocationCoordinate2D(latitude: 41.89555159556033, longitude: -87.69775763761557), color: UIColor().pantryPurple)
        pantries.append(pantry1)
        
        let pantry2 = Pantry(title: "Dirt Farms", subtitle: "3419 IL-64, Chicago, IL 60647", coordinate: CLLocationCoordinate2D(latitude: 41.91005886453729, longitude: -87.71266335984092), color: UIColor().pantryPurple)
        pantries.append(pantry2)
        
        let pantry3 = Pantry(title: "Honey Love", subtitle: "3361 N Elston Ave, Chicago, IL 60618", coordinate: CLLocationCoordinate2D(latitude: 41.942894247090685, longitude: -87.70288107497322), color: UIColor().pantryPurple)
        pantries.append(pantry3)
        
        let pantry4 = Pantry(title: "blnk [food] bank", subtitle: "3206 W Armitage Ave, Chicago, IL 60647", coordinate: CLLocationCoordinate2D(latitude: 41.91769149730674, longitude: -87.70744287311999), color: UIColor().pantryPurple)
        pantries.append(pantry4)
        
        let pantry5 = Pantry(title: "Dion's Dream Fridge", subtitle: "5658 S Racine Ave, Chicago, IL 60636", coordinate: CLLocationCoordinate2D(latitude: 41.79079896418719, longitude: -87.65520037497795), color: UIColor().brownFridge)
        pantries.append(pantry5)
        
        let pantry6 = Pantry(title: "The Fridge on Marz", subtitle: "3630 S Iron St, Chicago, IL 60609", coordinate: CLLocationCoordinate2D(latitude: 41.8279452257551, longitude: -87.65952253938553), color: UIColor().brownFridge)
        pantries.append(pantry6)
        
        let pantry7 = Pantry(title: "Sacred Keepers Sustainability Lab", subtitle: "4445 S King Dr, Chicago, IL 60653", coordinate: CLLocationCoordinate2D(latitude: 41.81366496296494, longitude: -87.6161883682223), color: UIColor().grayBank)
        pantries.append(pantry7)
        
        for pantry in pantries {
            let annotation = MKPointAnnotation()
            annotation.coordinate = pantry.coordinate
            annotation.title = pantry.title
            annotation.subtitle = pantry.subtitle
            mapView.addAnnotation(annotation)
            allAnnotations.append(annotation)
        }
    }
    //adds annotation pin images
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        var annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "")
        
        var pantry1: Pantry?
        for pantry in pantries {
            if pantry.coordinate.latitude == annotation.coordinate.latitude && pantry.coordinate.longitude == annotation.coordinate.longitude {
                pantry1 = pantry
            }
        }
        if let pantry = pantry1 {
            annotationView.markerTintColor = pantry.color
        }
        else {
            annotationView.markerTintColor = UIColor().grayBank
        }
        annotationView.canShowCallout = true
        
        return annotationView
    }
    
    func addPins() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Food Pantry"
        request.resultTypes = .pointOfInterest
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, error in
           
            if let response = response {
                //                for mapItem in response.mapItems {//looping through array of map items
                //                    self.addToMap(mapItem: mapItem)
                //                }
                self.addToMap(mapItems: response.mapItems)
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let myLocation = locations.last!
        locationManager.stopUpdatingLocation()
        MKMapView.animate(withDuration: 1.0, animations: {
            self.mapView.setRegion(MKCoordinateRegion(center: myLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)), animated: true)
        }
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("no location")
    }
    
    var allAnnotations = [MKPointAnnotation]()
    func addToMap(mapItems: [MKMapItem]) {
        var annotations = [MKPointAnnotation]()
        for mapItem in mapItems {
            let annotation = MKPointAnnotation()
            let coordinate = mapItem.placemark.coordinate
            annotation.coordinate = coordinate
            annotation.title = mapItem.name
            if let name = mapItem.name {
                print(name)
            }
            annotations.append(annotation)
            allAnnotations.append(annotation)
        }
        //mapView.addAnnotation(annotation)
        mapView.showAnnotations(annotations, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
        if Core.shared.isNewUser(){
            let vc = storyboard?.instantiateViewController(withIdentifier: "welcome") as! welcomeVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
        
    }
    var selectedPantry: Pantry?
    var selectedAnnotation: MKPointAnnotation?
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        selectedAnnotation = nil
        selectedPantry = nil
        for pantry in pantries {
            if pantry.title == view.annotation?.title {
                selectedPantry = pantry
            }
        }
        for item in allAnnotations {
            if item.coordinate.latitude == view.annotation?.coordinate.latitude && item.coordinate.longitude == view.annotation?.coordinate.longitude {
                selectedAnnotation = item
                performSegue(withIdentifier: "detailSegue", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let dvc = segue.destination as! DetailViewController
            if let selectedAnnotation = selectedAnnotation {
                dvc.annotation = selectedAnnotation
            }
            if let passedPantry = selectedPantry {
                dvc.passedPantry = passedPantry
            }
        }
    }
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        
    }
    
    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates:
                              CLLocationCoordinate2D?) {
        guard let coordinates = coordinates else {
            return
        }
        
        panel.move(to: .tip, animated: true)
        
        //mapView.removeAnnotations(mapView.annotations) //removes all annotations
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        
        //        mapView.setRegion(MKCoordinateRegion(//zooms in pin
        //            center: coordinates,
        //            span: MKCoordinateSpan(
        //                latitudeDelta: 0.06,
        //                longitudeDelta: 0.06
        //            )
        //        ),
        //        animated: true)
        MKMapView.animate(withDuration: 1.0, animations: {
            self.mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)), animated: true)
        }, completion: { Bool in
            self.addPins()
        })
    }
    
}

class Core {
    static let shared = Core()
    
    func isNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
extension UIColor {
    var pantryPurple: UIColor {
        return UIColor(red: 0.46, green: 0.54, blue: 0.71, alpha: 1.0)
    }
    var brownFridge: UIColor {
        return UIColor(red: 0.75, green: 0.62, blue: 0.5, alpha: 1.0)
    }
    var grayBank: UIColor {
        return UIColor(red: 0.68, green: 0.7, blue: 0.69, alpha: 1.0)
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 500.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

