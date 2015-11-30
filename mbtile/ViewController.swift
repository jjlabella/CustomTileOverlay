//
//  ViewController.swift
//  mbtile
//
//  Created by Juan Jose Labella on 25/11/15.
//  Copyright (c) 2015 mbtile. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //MAP DELEGATE
        self.mapView.delegate = self
        
        //URL BY DEFAULT
        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"
        
        
        //CENTER MAP TO THIS POI
        var location = CLLocationCoordinate2D(
            latitude: 37.855027,
            longitude: -5.277504
        )
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "POINT"
        annotation.subtitle = "Center Here"
        mapView.addAnnotation(annotation)
        
        
        //ADDING MY CUSTOM OVERLAY CLASS
        let overlay = CustomTileOverlay(URLTemplate: template)
        overlay.canReplaceMapContent = true
        mapView.addOverlay(overlay, level: .AboveLabels)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    //---------------------------------------------------------------------
    // DELEGATE METHOD FOR EVERLAYS
    //---------------------------------------------------------------------
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {

        let tileOverlay = overlay as? MKTileOverlay
        
        if (tileOverlay == nil){
            return MKOverlayRenderer()
        }
        
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }

    
}

