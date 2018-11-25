import UIKit
import MapKit
import Alamofire
import PromiseKit

// Mark: - Model

struct ReceiptItem {
    let price: Double
    let name: String
    let count: Double
}

class ShopAnnotation: NSObject, MKAnnotation {
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }

    public let coordinate: CLLocationCoordinate2D
    public let title: String?
    public var subtitle: String? { return nil }
}

class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!

    private var originalPullUpControllerViewSize: CGSize = .zero

    private func makeSearchViewControllerIfNeeded() -> SearchViewController {
        let currentPullUpController = children
            .filter({ $0 is SearchViewController })
            .first as? SearchViewController
        let pullUpController: SearchViewController = currentPullUpController ?? UIStoryboard(name: "PriceList",bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        if originalPullUpControllerViewSize == .zero {
            originalPullUpControllerViewSize = pullUpController.view.bounds.size
        }
        return pullUpController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Map"

        mapView.addAnnotations([
            ShopAnnotation.init(coordinate: CLLocationCoordinate2D.init(latitude: 60.184824, longitude: 24.82356), title: "K-Market Otaniemi"),
            ShopAnnotation.init(coordinate: CLLocationCoordinate2D.init(latitude: 60.176325, longitude: 24.805136), title: "K-supermarket Tapiola"),
            ShopAnnotation.init(coordinate: CLLocationCoordinate2D.init(latitude: 60.183258, longitude: 24.7935795), title: "K-Market Pohjantahti"),
            ])

        zoom(to: CLLocationCoordinate2D(latitude: 60.184894, longitude: 24.832528))

        // TODO: Karp use items
        // Use callback and call this function in callback and set items
        let mockData: [ReceiptItem] = [
            ReceiptItem.init(price: 1.25, name: "Bread", count: 4),
            ReceiptItem.init(price: 2.69, name: "Butter", count: 2),
            ReceiptItem.init(price: 2.25, name: "Eggs 10 pack", count: 1),
            ReceiptItem.init(price: 1.37, name: "Tomato 1kg", count: 1),
            ReceiptItem.init(price: 3.00, name: "Twix Rich", count: 4)
        ]

        addPullUpController(items: mockData)
    }

    private func addPullUpController(items: [ReceiptItem]) {
        let pullUpController = makeSearchViewControllerIfNeeded()
        pullUpController.items = items
        _ = pullUpController.view // call pullUpController.viewDidLoad()
        addPullUpController(pullUpController,
                            initialStickyPointOffset: pullUpController.initialPointOffset,
                            animated: true)
    }

    func zoom(to location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: true)
    }

    @IBAction private func addButtonTapped() {

    }

    @IBAction private func removeButtonTapped() {

    }
}

extension Network {
    func getLocation(currentLocation: CLLocation) -> Promise<Void> {
        return Promise { seal in
            let params: Parameters = [:]
            Alamofire.request("https://kesko.azure-api.net/v1/search/stores", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseSwiftyJSON { response in
                switch response.result {
                case .failure(let error):
                    seal.reject(error)
                case .success(let json):
                    seal.fulfill(())
                }
            }
        }
    }
}
