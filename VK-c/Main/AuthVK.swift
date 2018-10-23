//
//  AuthVK.swift
//  VK-c
//
//  Created by Timur on 26.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import WebKit

class AuthVK: UIViewController {
    
    let _ud = UserData.self
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.load(ApiWrapper.loginURL)
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMainTabBar",
            let tabsVC = segue.destination as? MainTabBarCntr {
            tabsVC.token = token
        }
    }*/
}

extension AuthVK: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard
            let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else {
                decisionHandler(.allow)
                return
        }
        let params = parse(parameters: fragment)
        
        guard let token = params["access_token"] else {
            print("token not found")
            return
        }
        
        _ud.saveData(token: token, userId: Int(params["user_id"]!)!)
        decisionHandler(.cancel)
        performSegue(withIdentifier: "ToMainTabBar", sender: nil)    }

}
