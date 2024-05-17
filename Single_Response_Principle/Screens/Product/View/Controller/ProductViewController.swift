//
//  ProductViewController.swift
//  MultipleApiFetch
//
//  Created by Admin on 10/03/23.
//
import UIKit
import SkeletonView
import Lottie

class ProductViewController: UIViewController {
// MARK: - IBOutlets
    @IBOutlet weak var noInternetConnectionView: UIView!
    @IBOutlet weak var noInternetLottie: LottieAnimationView!
    @IBOutlet weak var productTableView: UITableView!
    
    //dependent on
    let viewModel = ProductViewModel(
        apiManager: APIManager(networkHandler: NetworkHandler(),
        responseHandler: ResponseHandler())
    )
    let refreshPull = UIRefreshControl()
    
// MARK: - ViewLife Cycle
    override func viewDidLoad(){
        super.viewDidLoad()
        configuration()
        apiConfiguration()
    }
    
// MARK: - IBActions
    @IBAction func retryBtnClick(_ sender: Any) {
        self.fetchData()
    }
}

// MARK: - UIConfiguration
extension ProductViewController{
    func configuration(){
        //TableView Configurations
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.rowHeight = 150
        productTableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.id)
        
        //Refresh Pull Configuration
        refreshPull.tintColor = .red
        refreshPull.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.productTableView.refreshControl = refreshPull
        
        //Lottie Configuration
        noInternetLottie.contentMode = .scaleAspectFit
        noInternetLottie.loopMode = .loop
        noInternetLottie.animationSpeed = 0.5
    }
    @objc func refresh(sender:UIRefreshControl){
        self.fetchData()
    }
}

// MARK: - Network Configuration
extension ProductViewController{
    func apiConfiguration(){
        fetchData()
        observeEvent()
    }
    func fetchData(){
        if Reachability.isConnected(){ // user is online
            viewModel.fetchProduct()
            noInternetConnectionView.isHidden = true
            productTableView.isHidden = false
            noInternetLottie.stop()
        }
        else{  // user is offline
            refreshPull.endRefreshing()
            noInternetConnectionView.isHidden = false
            productTableView.isHidden = true
            noInternetLottie.play()
        }
    }
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch event{
                case .startLoading:
                    self.productTableView.showAnimatedGradientSkeleton()
                    break
                case .stopLoading:
                    self.refreshPull.endRefreshing()
                    self.productTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                    break
                case .reloadData:
                    self.productTableView.reloadData()
                    break
                case .error(let err):
                    print(err)
                    break
                }
            }
        }
    }
    
}

// MARK: - UITableView DataSoruce
extension ProductViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.id, for: indexPath) as? ProductTableViewCell else { fatalError("xib doesn't exist") }
        cell.product = viewModel.products[indexPath.row]
        return cell
    }
}

// MARK: - UITableView Delegate
extension ProductViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let productDetailVC = MainModule.getProductDetailVC()
        productDetailVC.obj = viewModel.products[indexPath.row]
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

// MARK: - UITableView Skeleton DataSource
extension ProductViewController: SkeletonTableViewDataSource{
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ProductTableViewCell.id
    }
}

