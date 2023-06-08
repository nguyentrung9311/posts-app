//
//  TestLoginPresenter.swift
//  PostsAppTests
//
//  Created by TrungNV (Macbook) on 05/06/2023.
//

import Foundation
import Quick
import Nimble
import Mockingbird

@testable import PostsApp

class TestLoginPresenter: QuickSpec {
    override class func spec() {
        describe("Login") {
            var sut: LoginPresenter!
            
            // Generate LoginDisplayMock command:
            // Pods/MockingbirdFramework/mockingbird configure PostsAppTests -- --targets PostsApp
            var loginDisplayMock: LoginDisplayMock!
            
            beforeEach {
                loginDisplayMock = mock(LoginDisplay.self)
                let authApiService = AuthApiServiceImpl()
                let authRepository = AuthRepositoryImpl(authApiService: authApiService)
                sut = LoginPresenterIml(controller: loginDisplayMock, authRepository: authRepository)
            }
            
            context("Login form validate") {
                it("Check username empty") {
                    sut.login(username: "", password: "abcabc")
                    verify(loginDisplayMock.usernameInvalid(message: "Username is require")).wasCalled()
                }
                
                it("Check username length") {
                    sut.login(username: "asv", password: "ss")
                    verify(loginDisplayMock.usernameInvalid(message: "Username length must be > 5")).wasCalled()
                }
                
                it("check password empty") {
                    sut.login(username: "123456", password: "")
                    verify(loginDisplayMock.passwordInvalid(message: "Password is require")).wasCalled()
                }
                
                it("Check password length") {
                    sut.login(username: "123456", password: "abc")
                    verify(loginDisplayMock.passwordInvalid(message: "Password length must be > 5")).wasCalled()
                }
                
                it("Check login start") {
                    sut.login(username: "123456", password: "abcdef")
                    verify(loginDisplayMock.onStartLogin()).wasCalled()
                }
            }
        }
    }
}
