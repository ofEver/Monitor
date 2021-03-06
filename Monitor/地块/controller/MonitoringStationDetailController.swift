//
//  MonitoringStationDetailController.swift
//  Monitor
//
//  Created by gaof on 2018/5/29.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit
import Reusable
import CenteredCollectionView
import Hero
class MonitoringStationDetailController: UITableViewController,StoryboardSceneBased {
    
    static var sceneStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    

    @IBOutlet weak var collectionView: UICollectionView!
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    let cellPercentWidth: CGFloat = 0.9
    fileprivate lazy var listLayout:CenteredCollectionViewFlowLayout = {
        let layout = CenteredCollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: collectionView.bounds.width * cellPercentWidth,
            height: collectionView.bounds.height
        )
        return layout
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "地块详情"
        tableView.tableFooterView = UIView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: WindStatisticsCell.self)
        collectionView.register(cellType: HealthStatisticsCell.self)
        collectionView.register(cellType: HumidityCell.self)
        collectionView.register(cellType: ComprehensiveCell.self)
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.collectionViewLayout = listLayout
        // Get rid of scrolling indicators
       
        // Configure the optional inter item spacing (OPTIONAL STEP)
//        centeredCollectionViewFlowLayout.minimumLineSpacing = 20

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
}
extension MonitoringStationDetailController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ComprehensiveCell.self)
            return cell
        }
        else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: WindStatisticsCell.self)
            return cell
        }else if indexPath.row == 2{
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HealthStatisticsCell.self)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HumidityCell.self)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BaseStatisticsCell
        if let heroID = cell.chartView.hero.id {
            let nav = UIStoryboard(name: "Statistics", bundle: nil).instantiateViewController(withIdentifier: heroID)
            self.present(nav, animated: true, completion: nil)
        }
    }
}
