//
//  HomeViewController.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 09/06/2023.
//

import UIKit

protocol HomeDelegate {
    func onStartLogout()
    func onLogoutFailure(error: String?)
    func onLogoutSuccess()
    func onStartGetPosts()
    func onGetPostSuccess(postDataArr: [PostData])
    func onGetPostError(error: String?)
}

class HomeViewController: UIViewController {
    var homePresenter: HomePresenter!
    var rootNavigator: UINavigationController?
    var postDataArr: [PostData] = [PostData]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authRepository = AuthRepositoryImpl(authApiService: AuthApiServiceImpl())
        let postRepository = PostRepositoryImpl(postApiService: PostApiServiceImpl())
        homePresenter = HomePresenterImpl(homeDelegate: self, authRepository: authRepository, postRepository: postRepository)
        
        initTableView()
        getPosts()
    }
    
    private func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: PostCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PostCell.id)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func getPosts() {
        homePresenter.getPost(page: 1, pageSize: 20)
    }
    
    @IBAction func onLogoutClicked(_ sender: Any) {
        homePresenter.logout(accessToken: AuthHelper.shared.accessToken)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.id, for: indexPath) as! PostCell
        cell.setPostData(postData: postDataArr[indexPath.row])
        return cell
    }
}

extension HomeViewController: HomeDelegate {
    func onStartGetPosts() {
        print("Start get posts")
    }
    
    func onGetPostSuccess(postDataArr: [PostData]) {
        self.postDataArr.append(contentsOf: postDataArr)
        tableView.reloadData()
        print("Get posts success: \(self.postDataArr.count)")
    }
    
    func onGetPostError(error: String?) {
        print("Get post error: \(error ?? "")")
    }
    
    func onStartLogout() {
        print("Start logout")
        AuthHelper.shared.clear(key: AuthHelper.Keys.accessToken.rawValue)
    }
    
    func onLogoutFailure(error: String?) {
        print("Logout error: \(error ?? "")")
    }
    
    func onLogoutSuccess() {
        print("Logout success")
        if let navigationController = rootNavigator {
            let loginVC = navigationController.viewControllers.first { viewContoller in
                return viewContoller is LoginViewController
            }
            
            if loginVC != nil {
                navigationController.popToViewController(loginVC!, animated: true)
            } else {
                navigationController.pushViewController(LoginViewController(), animated: true)
            }
        } else {
            print("Root navigator nil")
        }
    }
    
    
}
