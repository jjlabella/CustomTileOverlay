//
//  CustomTileOverlay.swift
//  mbtile
//
//  Created by Juan Jose Labella on 25/11/15.
//  Copyright (c) 2015 mbtile. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CustomTileOverlay : MKTileOverlay {
    let cache = NSCache()
    let operationQueue = NSOperationQueue()
    
    override func URLForTilePath(path: MKTileOverlayPath) -> NSURL {
        return NSURL(string: String(format: "http://tile.openstreetmap.org/%i/%i/%i.png", path.z, path.x, path.y))!
        
    }
    
    override func loadTileAtPath(path: MKTileOverlayPath, result: ((NSData!, NSError!) -> Void)!){
        
        //KEY
        let url :String = String(path.x) + "-" + String(path.y) + "-" + String(path.z)

        //MAP
        let tilesURL : NSURL = NSBundle.mainBundle().URLForResource("10", withExtension: "mbtiles")!
        let tilesDB : MBTilesDB = MBTilesDB(DBURL: tilesURL)
        let zz : NSInteger = path.z
        let xx : NSInteger = path.x
        let yy : NSInteger = path.y
        println("\(xx) - \(yy) - \(zz)")
        let tileData = tilesDB.tileForZoomLevel(zz, tileColumn:xx, tileRow: yy)
        
        if (tileData != nil){
            result(tileData, nil)
        }
    }
    
}