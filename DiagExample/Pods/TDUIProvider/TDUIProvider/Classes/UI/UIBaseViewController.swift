//
//  UIBaseViewController.swift
//  TDUIProvider
//
//  Created by Fench on 2025/1/9.
//

import UIKit
import SnapKit
import TDBasis
import TDTheme


@objc(TDUIBaseViewController)
open class UIBaseViewController: UIViewController {
  
    public override var title: String? {
        didSet {
            self.navBar.titleStr = title
        }
    }
    
    var isTransfor: Bool = false
    
    lazy var navBar: UIBaseNavigationBar = UIBaseNavigationBar()
    private var textFieldView: UIView?
    private var keyboardFrame: CGRect = .zero
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.theme.backgroundColor = UIProvider.mainBackground(size: UI.SCREEN_BOUNDS.size)
        
        setupNavBar()
        
        setupUI()

    }
    
    open func setupUI(){ }
    
    open func setupNavBar(){
        navBar.titleStr = title

        navBar.bottomLine.isHidden = true
        view.addSubview(navBar)
        navBar.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(UI.STATUS_NAV_BAR_HEIGHT)
        }
        
        navBar.callback.backCallback = { [weak self] in
            guard let self = self else { return }
            self.backClick()
        }
        navBar.callback.rightCallback = { [weak self] in
            guard let self = self else { return }
            self.rightBtnClick()
            
        }
        view.bringSubviewToFront(navBar)
    }
    
    open func backClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    open func rightBtnClick() {
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.bringSubviewToFront(navBar)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        TDLogCustom("控制器被释放了 -- \(self)", customLevel: "【UIProvider】")
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIProvider.statusBarStyle
    }
    
}

extension UIBaseViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let count = navigationController?.viewControllers.count else { return false }
        return count > 1
    }
}



