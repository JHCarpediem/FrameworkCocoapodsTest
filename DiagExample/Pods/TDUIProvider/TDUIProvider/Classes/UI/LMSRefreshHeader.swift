//
//  LMSRefreshHeader.swift
//  LMSUI
//
//  Created by Fench on 2024/9/4.
//

import TDBasis
import MJRefresh
import TDTheme

@objc
public class LMSRefreshHeader: MJRefreshGifHeader {
    
    public override func prepare() {
        
        let normalImages = image(from: 20, to: 21)
        let refreshImages = image(from: 0, to: 21)
        
        setImages(refreshImages, for: .idle)
        setImages(normalImages, duration: 2, for: .pulling)
        setImages(refreshImages, duration: 2, for: .refreshing)
        
        stateLabel?.textColor = UIProvider.statusBarStyle == .lightContent ? .white : .td.subTitle
        stateLabel?.font = .systemFont(ofSize: 12).adaptHD
        
        super.prepare()
        
        setTitle(UILocalized.lms_pull_to_refresh, for: .idle)
        setTitle(UILocalized.lms_free_to_refresh, for: .pulling)
        setTitle(UILocalized.lms_refreshing, for: .refreshing)
        
    }
    
    
    func image(from fromIndex: Int, to toIndex: Int) -> [UIImage] {
        var imgs = [UIImage]()
        for i in fromIndex...toIndex {
            let indexStr = String(format: "%02d", i)
            if let image = UIConfig.image(named: "refresh_\(indexStr)", middlewareKey: nil)?.image {
                imgs.append(image)
                continue
            }
            let imgStr = "TDUIProvider.bundle/Refresh/refresh_" + indexStr
            if let image = UIConfig.image(named: imgStr, bundle: .current)?.image {
                imgs.append(image)
            }
        }
        return imgs
    }
    
    public override func placeSubviews() {
        guard let stateLabel = stateLabel, let gifView = gifView else {
            super.placeSubviews()
            return
        }
        super.placeSubviews()
        
        gifView.contentMode = .scaleAspectFill
        lastUpdatedTimeLabel?.isHidden = true
        gifView.snp.makeConstraints {
            $0.right.equalTo(stateLabel.snp.left).offset(-5)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        stateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(5)
        }
        
    }
}

@objc
public class LMSRefreshFooter: MJRefreshAutoNormalFooter {
    public override func prepare() {
        super.prepare()
        
        stateLabel?.font = .systemFont(ofSize: 11).adaptHD
        stateLabel?.theme.textColor = .theme.subTitle
        
        setTitle(UILocalized.tip_loading_more, for: .refreshing)
        setTitle(UILocalized.tip_drag_refresh, for: .pulling)
        setTitle(UILocalized.tip_no_more_content, for: .noMoreData)
        setTitle("", for: .idle)
    }
}

extension UIScrollView {
    public func endHeaderRefresh(dataCount: Int? = nil, pageSize: Int? = nil) {
        self.mj_footer?.resetNoMoreData()
        self.mj_header?.endRefreshing()
        guard let dataCount = dataCount, let pageSize = pageSize else { return }
        if dataCount < pageSize {
            self.mj_footer?.state = .noMoreData
            self.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
    
    public func endFooterRefresh(dataCount: Int? = nil, pageSize: Int? = nil) {
        guard let dataCount = dataCount, let pageSize = pageSize else {
            self.mj_footer?.endRefreshing()
            return
        }
        if dataCount < pageSize {
            self.mj_footer?.state = .noMoreData
            self.mj_footer?.endRefreshingWithNoMoreData()
        } else {
            self.mj_footer?.endRefreshing()
        }
    }
}
