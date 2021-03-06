//
//  LoginRepositorySpec.swift
//  Networking
//
//  Created by Pablo Giorgi on 5/5/17.
//  Copyright © 2017 Wolox. All rights reserved.
//

import Quick
import Nimble
import Networking

internal class LoginRepositorySpec: QuickSpec {
    
    override func spec() {
        
        var repository: LoginRepositoryType!
        
        beforeEach() {
            let networkingConfiguration = NetworkingConfiguration(useSecureConnection: true,
                                                                  domainURL: "localhost",
                                                                  port: 8080,
                                                                  subdomainURL: "/local-path-1.0",
                                                                  usePinningCertificate: false)
            
            repository = LoginRepository(networkingConfiguration: networkingConfiguration,
                                         requestExecutor: LocalRequestExecutor(),
                                         sessionManager: SessionManagerMock())
        }
        
        describe("#login") {
            
            context("when the request is correctly performed") {
                
                it("succeeds") { waitUntil { done in
                    repository.login().startWithResult {
                        switch $0 {
                        case .success: done()
                        case .failure: fail()
                        }
                    }
                }}
                
            }
            
            context("when the request has an error") {
                
                it("fails") { waitUntil { done in
                    repository.failingLogin().startWithResult {
                        switch $0 {
                        case .success: fail()
                        case .failure: done()
                        }
                    }
                }}
                
            }
            
        }
        
    }
    
}
