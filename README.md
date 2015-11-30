# CustomTileOverlay
Swift (iOS) -  How to load a .mbtiles files inside a MKMapView.

MBTILES are files with a sqlite logic inside. It means you can request information over this file like you can do over a sqlite file.

In this example we are going to cover just a simple thing, which is "how can read a mbtiles file and plot the tiles in my map?". There are other options inside a MBTILES file, like get metadata and other things, we let this part for every how wants to collab into this repo.

##Preview
![]
(https://github.com/jjlabella/CustomTileOverlay/blob/master/mbtile/Final-1.png)

![]
(https://github.com/jjlabella/CustomTileOverlay/blob/master/mbtile/Final-2.png)

##Installation
Inside "mbtiles" folder you have several things. 

- "**CustomTileOverlay.swift**" this is a custom class to manage tile logic.
- "**MBTilesDB.m**" and "**MBTilesDB.h**" this is class to manage acces to the MBTILE file like you can do with a sqlite file.
- "**FMDB**" folder. Which is the FMDB class to access a sqlite file.


##How to use it

First of all you have to do the following things into your ViewController with your map.

1. Do your view controller MKMapViewDelegate.
2. Setup this controller like delegate: self.mapView.delegate = self
3. Setup you map view like a map with overlay options:

		//ADDING MY CUSTOM OVERLAY CLASS
        let overlay = CustomTileOverlay(URLTemplate: template)
        overlay.canReplaceMapContent = true
        mapView.addOverlay(overlay, level: .AboveLabels)
       
* Note, for the file I attach in this example I have created a point to center the map in a specific location and with a suitable zoom, just to see the tiles from the beginning.

* Note, for this example I used Open Street Map like tile provider, but we will never see a tile from this web, it is just to let you know you can do it.

		//URL BY DEFAULT
        let template = "http://tile.openstreetmap.org/{z}/{x}/{y}.png"

##CustomTileOverlay.swift

This class extends from MKTileOverlay and it has to implement two methods: **URLForTilePath** (we don't need it in this example, you can used it if you want tiles and real time map at the same time) and **loadTileAtPath**(this method is the one we use to call our MBTilesDB and get a NSData with the tile information).

##MBTilesDB.h and MBTilesDB.m

We use this class to request for a tile to our MBTILE file. In this class we are using the FMDB class to support sqlite queries.

You need to import this class into your Bridging_Header_h

##FMDB

We use this class to support queries to our MBTILES like a sqlite file. If you want to load this libray into your project you need to add libsqlite3.0.dylib to your project and also you need to setup you project like this.

![](https://github.com/jjlabella/CustomTileOverlay/blob/master/mbtile/Settings.png)


##Support
Any questions, please fell free to send me your comments: jjlabella@gmail.com
