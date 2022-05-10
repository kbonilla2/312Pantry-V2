////
////  ViewController.swift
////  mapLocation
////
////  Created by student on 7/27/21.
////
//
//import UIKit
//import MapKit
//import FloatingPanel
//import CoreLocation
//
//class LocationViewController: UIViewController, SearchViewControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
//
//    let mapView = MKMapView()
//    let panel = FloatingPanelController()
//    let manager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        view.addSubview(mapView)
//        let formatter = DateFormatter()
//             formatter.dateStyle = .medium
//             let dateString = formatter.string(from: Date())
//
//        title = "\(dateString)"
//
//        let searchVC = SearchViewController()
//        searchVC.delegate = self
//        panel.set(contentViewController: searchVC)
//        panel.addPanel(toParent: self)
//
//
//        mapView.delegate = self
//        self.placePins()
//
//    }
//
//    //your location
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            manager.stopUpdatingLocation()
//
//            render(location)
//        }
//    }
//
//    func render(_  location: CLLocation) {
//
//        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
//                                                longitude: location.coordinate.longitude)
//
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//
//        mapView.setRegion(region, animated: true)
//
//        let pin = MKPointAnnotation()
//        pin.coordinate = coordinate
//        pin.title = "Your Current Location"
//        pin.subtitle = "\(coordinate.latitude), \n \(coordinate.longitude)"
//        mapView.addAnnotation(pin)
//    }
//
//
////    let annotationLocations = [
////        ["title": "Comida Para el Pueblo at La Michoacana", "subtitle": "1855 S Blue Island Ave, Chicago, IL 60608", "latitude": 41.85692365406121, "longitude": -87.66167324443228],
////        ["title": "Patchwork Farms", "subtitle": "2825 W Chicago Ave, Chicago, IL 60622", "latitude": 41.89555159556033, "longitude": -87.69775763761557],
////        ["title": "Dirt Farms", "subtitle": "3419 IL-64, Chicago, IL 60647", "latitude": 41.91005886453729, "longitude": -87.71266335984092]
////    ]
////
////    func createAnnotations(locations: [[String: Any]]) {
////        for location in locations {
////            let annotations = MKPointAnnotation()
////            annotations.title = location["title"] as? String
////            annotations.subtitle = location["subtitle"] as? String
////            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees,
////                                                            longitude: location["longitude"] as! CLLocationDegrees)
////            mapView.addAnnotation(annotations)
////        }
////    }
//
//    func placePins() {
//        //41.79079896418719, -87.65520037497795
//        let coords = [CLLocationCoordinate2D(latitude: 41.85692365406121, longitude: -87.66167324443228),
//                      CLLocationCoordinate2D(latitude: 41.89555159556033, longitude: -87.69775763761557),
//                      CLLocationCoordinate2D(latitude: 41.91005886453729, longitude: -87.71266335984092),
//                      CLLocationCoordinate2D(latitude: 41.942894247090685, longitude: -87.70288107497322),
//                      CLLocationCoordinate2D(latitude: 41.91769149730674, longitude: -87.70744287311999),
//                      CLLocationCoordinate2D(latitude: 41.79079896418719, longitude: -87.65520037497795),
//                      CLLocationCoordinate2D(latitude: 41.8279452257551, longitude: -87.65952253938553),
//                      CLLocationCoordinate2D(latitude: 41.81366496296494, longitude: -87.6161883682223)]
//        let titles = ["Comida Para el Pueblo at La Michoacana",
//                      "Patchwork Farms",
//                      "Dirt Farms",
//                      "Honey Love",
//                      "blnk [food] bank",
//                      "Dion's Dream Fridge",
//                      "The Fridge on Marz",
//                      "Sacred Keepers Sustainability Lab"]
//        let subtitles = ["1855 S Blue Island Ave, Chicago, IL 60608",
//                         "2825 W Chicago Ave, Chicago, IL 60622",
//                         "3419 IL-64, Chicago, IL 60647",
//                         "3361 N Elston Ave, Chicago, IL 60618",
//                         "3206 W Armitage Ave, Chicago, IL 60647",
//                         "5658 S Racine Ave, Chicago, IL 60636",
//                         "3630 S Iron St, Chicago, IL 60609",
//                         "4445 S King Dr, Chicago, IL 60653"]
//
//        //
//        let nonprofit = [CLLocationCoordinate2D(latitude: 41.95019451052629, longitude: -87.67872959054516),
//                         CLLocationCoordinate2D(latitude: 41.8182796872385, longitude: -87.7268500174781),
//                         CLLocationCoordinate2D(latitude: 41.9099828507456, longitude: -87.71582291747495)]
//        let npTitles = ["Common Pantry",
//                        "Greater Chicago Food Depository",
//                        "Lakeview Pantry: La Casa Norte’s Fresh Market"]
//        let npSubtitles = ["3744 N Damen Ave, Chicago, IL 60618",
//                           "4100 W. Ann Lurie Place, Chicago, IL 60632",
//                           "3533 W. North Ave. First Floor Chicago, IL 60647"]
//
//        for i in coords.indices {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = coords[i]
//            annotation.title = titles[i]
//            annotation.subtitle = subtitles[i]
//            mapView.addAnnotation(annotation)
//        }
//
//        for i in nonprofit.indices {
//            let annotation2 = MKPointAnnotation()
//            annotation2.coordinate = nonprofit[i]
//            annotation2.title = npTitles[i]
//            annotation2.subtitle = npSubtitles[i]
//            mapView.addAnnotation(annotation2)
//        }
//    }
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MyMarker")
//
//        //different annotation colors
//        switch annotation.title! {
//            // 24/7 access
//            case "Comida Para el Pueblo at La Michoacana", "Patchwork Farms", "Dirt Farms", "Honey Love", "blnk [food] bank", "The Fridge on Marz":
//                annotationView.markerTintColor = UIColor(red: (52.0/255), green: (114.0/255), blue: (1.0/255), alpha: 1.0)
//            //limited access
//            case "Dion's Dream Fridge", "Sacred Keepers Sustainability Lab":
//                annotationView.markerTintColor = UIColor(red: (85.0/255), green: (226.0/255), blue: (14.0/255), alpha: 1.0)
//            //nonprofits
//            case "Common Pantry", "Greater Chicago Food Depository", "Lakeview Pantry: La Casa Norte’s Fresh Market":
//                annotationView.markerTintColor = UIColor(red: (246.0/255), green: (233.0/255), blue: (212.0/255), alpha: 1.0)
//            default:
//                annotationView.markerTintColor = UIColor.black
//        }
//
//
//        return annotationView
//    }
//
//
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        mapView.frame = view.bounds
//
//    }
//
//    func searchViewController(_ vc: SearchViewController, didSelectLocationWith coordinates:
//                                CLLocationCoordinate2D?) {
//        guard let coordinates = coordinates else {
//            return
//        }
//
//        panel.move(to: .tip, animated: true)
//
//        //mapView.removeAnnotations(mapView.annotations) //removes all annotations
//
//        let pin = MKPointAnnotation()
//        pin.coordinate = coordinates
//        mapView.addAnnotation(pin)
//
//        mapView.setRegion(MKCoordinateRegion(//zooms in pin
//            center: coordinates,
//            span: MKCoordinateSpan(
//                latitudeDelta: 0.01,
//                longitudeDelta: 0.01
//            )
//        ),
//        animated: true)
//    }
//
//}
//
//class Core {
//        static let shared = Core()
//
//    func isNewUser() -> Bool {
//
//        return !UserDefaults.standard.bool(forKey: "isNewUser")
//
//
//    }
//    func setIsNotNewUser() {
//        UserDefaults.standard.set(true, forKey: "isNewUser")
//
//
//    }
//}
//
