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
    let cache = NSCache<AnyObject, AnyObject>()
    let operationQueue = OperationQueue()
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        return URL(string: String(format: "http://tile.openstreetmap.org/%i/%i/%i.png", path.z, path.x, path.y))!
        
    }
    
    

    override func loadTile(at path: MKTileOverlayPath,
                           result: ((Data?, Error?) -> Void)!) {
        
        
        
        //KEY
        let url :String = String(path.x) + "-" + String(path.y) + "-" + String(path.z)

        //MAP
        let tilesURL : URL = Bundle.main.url(forResource: "10", withExtension: "mbtiles")!
        let tilesDB : MBTilesDB = MBTilesDB(dburl: tilesURL)
        let zz : NSInteger = path.z
        let xx : NSInteger = path.x
        let yy : NSInteger = path.y
        print("\(xx) - \(yy) - \(zz)")
        let tileData = tilesDB.tile(forZoomLevel: zz, tileColumn:xx, tileRow: yy)
        
        if (tileData != nil){
            result(tileData as Data?, nil)
        }
    }
    
}
