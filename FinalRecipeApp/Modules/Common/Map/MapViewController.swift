//
//  MapViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 06.02.24.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    var viewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
    }
    
    private func setupMap() {
        let mapView = GMSMapView()
        
        mapView.isMyLocationEnabled = true
        self.view = mapView
        
        var bounds = GMSCoordinateBounds()
        
        for restaurant in viewModel.restaurants {
            let marker = GMSMarker()
            let location = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            marker.position = location
            marker.title = restaurant.name
            marker.snippet = String(restaurant.rating)
            marker.map = mapView
            
            bounds = bounds.includingCoordinate(location)
        }
        
        let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        mapView.animate(with: update)
    }
}
