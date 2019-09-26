//
//  TweetsMapView.swift
//  Twitter
//
//  Created by Muhammad Hassan on 2019-09-23.
//  Copyright © 2019 Muhammad Hassan. All rights reserved.
//

import UIKit
import MapKit
import TwitterKit
import CoreLocation

class TweetsMapVC: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tweetsMap: MKMapView!
    @IBOutlet private weak var lblEmptyStatus: UILabel!
    
    // MARK: - Properties
    let presenter = TweetsMapPresenter()
    private var arrTweets = [Tweet]()
    private var loadingSpinner: UIAlertController!
    var modalTransitioningDelegate: ModalSheetTransitioningDelegate?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        navigationItem.title = Strings.navigationTitle.localized
        
        self.delegate = self
        presenter.attachView(self)
        
        loadingSpinner = getLoadingAlert()
        LocationManager.sharedInstance.delegate = self
        LocationManager.sharedInstance.startUpdatingLocation()
        
//        Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { timer in
//            LocationManager.sharedInstance.startUpdatingLocation()
//        }
    }
}

// MARK: - BaseViewController Delegate Methods
extension TweetsMapVC: BaseViewControllerDelegate {
    
    func actionSettings(_ sender: UIButton) {
        
        let settingsVC = SettingsVC.instantiate(fromStoryboard: .main)
        settingsVC.presenter.delegate = self
        
        modalTransitioningDelegate = ModalSheetTransitioningDelegate(viewController: self, presentingViewController: settingsVC)
        settingsVC.modalPresentationStyle = .custom
        settingsVC.transitioningDelegate = modalTransitioningDelegate
        present(settingsVC, animated: true, completion: nil)
    }
    
    func actionToggele(_ sender: UIButton) {
        AppDelegate.app().window?.rootViewController = UINavigationController(rootViewController: TweetsVC.instantiate(fromStoryboard: .main))
    }
    
    func actionReload(_ sender: UIButton) {
        arrTweets = [Tweet]()
        LocationManager.sharedInstance.startUpdatingLocation()
    }
    
    func searchBarSearchButtonPressed(_ searchText: String) {
        
        let radius = Defaults.shared.getInt(SettingsConstants.radius) == 0 ? 5 : Defaults.shared.getInt(SettingsConstants.radius)
        presenter.fetchMostRecentTweets(searchText, radius: radius)
    }
}

// MARK: - LocationManager Delegate Methods
extension TweetsMapVC: LocationManagerDelegate {
    
    func tracingLocation(currentLocation: CLLocation) {
        LocationManager.sharedInstance.stopUpdatingLocation()
        presenter.fetchMostRecentTweets(searchBar.text, radius: getRadius())
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        showAlert(Strings.errorTitle.localized, message: error.localizedDescription)
    }
}

// MARK: - Settings Delegate Methods
extension TweetsMapVC: SettingsDelegate {
    
    func onRadiusChanged(radius: Int) {
        presenter.fetchMostRecentTweets(searchBar.text, radius: radius)
    }
}

// MARK: - MKMapView Delegate Methods
extension TweetsMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let annotation = view.annotation as? TweetAnnotation {
            presenter.fetchTweetDetails(annotation.tweetId)
        }
    }
}

// MARK: - Helper Methods
extension TweetsMapVC {
    
    func showLoading() {
        show(loadingSpinner)
    }
    
    func hideLoading() {
        loadingSpinner.hide()
    }
    
    func setEmptyStatus() {
        
        tweetsMap.isHidden = arrTweets.count == 0
        lblEmptyStatus.isHidden = arrTweets.count > 0
    }
    
    func reloadTweetsOnMap(data: [Tweet]) {
        
        arrTweets = data
        setEmptyStatus()
        createAnnomationsAndLoadOnMap()
    }
    
    func showTweetDetailView(_ tweet: TWTRTweet) {
        
        let tweetDetailVC = TweetDetailVC.instantiate(fromStoryboard: .main)
        tweetDetailVC.tweet = tweet
        
        modalTransitioningDelegate = ModalSheetTransitioningDelegate(viewController: self, presentingViewController: tweetDetailVC)
        tweetDetailVC.modalPresentationStyle = .custom
        tweetDetailVC.transitioningDelegate = modalTransitioningDelegate
        present(tweetDetailVC, animated: true, completion: nil)
    }
    
    private func createAnnomationsAndLoadOnMap() {
        
        tweetsMap.removeAnnotations(tweetsMap.annotations)
        
        var arrAnnotations = [MKPointAnnotation]()
        for tweet in arrTweets {
            
            let annotation = TweetAnnotation()
            annotation.title = tweet.name
            annotation.tweetId = tweet.id
            
            if let arrCoordinates = tweet.place?.boundingBox?.coordinates?.first?.first {
                annotation.coordinate = CLLocationCoordinate2D(latitude: arrCoordinates[0], longitude: arrCoordinates[0])
            } else {
                annotation.coordinate = CLLocationCoordinate2D(latitude: 43.648065, longitude: -79.420417)
            }
            
            annotation.subtitle = (tweet.place?.fullName ?? "Toronto") + ", " + (tweet.place?.country ?? "Canada")
            arrAnnotations.append(annotation)
        }
        
        tweetsMap.showAnnotations(arrAnnotations, animated: true)
        tweetsMap.addAnnotations(arrAnnotations)
    }
}

class TweetAnnotation: MKPointAnnotation {
    var tweetId: Int = 0
}
