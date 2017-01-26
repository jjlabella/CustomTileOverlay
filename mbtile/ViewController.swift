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
        let location = CLLocationCoordinate2D(
            latitude: 37.855027,
            longitude: -5.277504
        )
        
        //SET UP ZOOM
        let viewRegion : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, 2000, 2000);
        let adjustedRegion : MKCoordinateRegion = self.mapView.regionThatFits(viewRegion);
        self.mapView.setRegion(adjustedRegion ,animated:true);
        self.mapView.showsUserLocation = true;
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "POINT"
        annotation.subtitle = "Center Here"
        mapView.addAnnotation(annotation)
        
        
        //ADDING MY CUSTOM OVERLAY CLASS
        let overlay = CustomTileOverlay(urlTemplate: template)
        overlay.canReplaceMapContent = true
        mapView.add(overlay, level: .aboveLabels)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    //---------------------------------------------------------------------
    // DELEGATE METHOD FOR EVERLAYS
    //---------------------------------------------------------------------
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let tileOverlay = overlay as? MKTileOverlay
        
        if (tileOverlay == nil){
            return MKOverlayRenderer()
        }
        
        return MKTileOverlayRenderer(tileOverlay: tileOverlay!)
    }

    
}

