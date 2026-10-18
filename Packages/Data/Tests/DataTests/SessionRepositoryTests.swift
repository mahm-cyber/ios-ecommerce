//
//  SessionRepositoryTests.swift
//  DataTests
//
//  Created by NamaaIT Apple3 on 18/10/2026.
//

import Foundation
import Testing
@testable import Data

struct SessionRepositoryTests {

    @Test
    func coldStartWithExistingTokenStartsAuthenticated() throws {
        let fakeKeychain = TestKeychainStorage()
        try fakeKeychain.save(key: "auth_token", string: "existing_token_abc")

        let repository = AppSessionRepository(keychainStorage: fakeKeychain)

        #expect(repository.state == .authenticated(token: "existing_token_abc"))
        #expect(repository.token == "existing_token_abc")
    }

    @Test
    func coldStartWithoutTokenStartsUnauthenticated() {
        let fakeKeychain = TestKeychainStorage()

        let repository = AppSessionRepository(keychainStorage: fakeKeychain)

        #expect(repository.state == .unauthenticated)
        #expect(repository.token == nil)
    }

    @Test
    func signInPersistsTokenAndUpdatesState() throws {
        let fakeKeychain = TestKeychainStorage()
        let repository = AppSessionRepository(keychainStorage: fakeKeychain)

        #expect(repository.state == .unauthenticated)

        try repository.signIn(token: "new_login_token_xyz")

        #expect(repository.state == .authenticated(token: "new_login_token_xyz"))
        #expect(repository.token == "new_login_token_xyz")
        #expect(try fakeKeychain.readString(key: "auth_token") == "new_login_token_xyz")
    }

    @Test
    func signOutClearsTokenAndResetsState() throws {
        let fakeKeychain = TestKeychainStorage()
        try fakeKeychain.save(key: "auth_token", string: "active_token_123")

        let repository = AppSessionRepository(keychainStorage: fakeKeychain)
        #expect(repository.state == .authenticated(token: "active_token_123"))

        try repository.signOut()

        #expect(repository.state == .unauthenticated)
        #expect(repository.token == nil)
        #expect(try fakeKeychain.readString(key: "auth_token") == nil)
    }
}
