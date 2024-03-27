//
//  MapViewController.swift
//  FinalRecipeApp
//
//  Created by Mariam Joglidze on 06.02.24.
//

import UIKit
import GoogleMaps

// MARK: - Map View Controller
final class MapViewController: UIViewController {
    // MARK: Properties
    private let viewModel: MapViewModel
    
    // MARK: Initalizer
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    
    // MARK: Setup
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
