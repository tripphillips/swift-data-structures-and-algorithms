//
//  TrieTests.swift
//  TrieTests
//
//  Created by Trip Phillips on 5/10/22.
//

import XCTest
@testable import Trie

class TrieTests: XCTestCase {

    func test_insert_contains_stringIntoEmptyTrie() {
        let sut = makeEmptyTrie()
        sut.insert("Test")
        XCTAssertTrue(sut.contains("Test"))
    }
    
    func test_insert_contains_stringIntoTrie() {
        let sut = makeEmptyTrie()
        sut.insert("TestF")
        XCTAssertTrue(sut.contains("TestF"))
    }
    
    func test_remove_contains_stringInEmptyTrie() {
        let sut = makeEmptyTrie()
        sut.remove("Test")
        XCTAssertFalse(sut.contains("Test"))
    }
    
    func test_remove_contains_stringInTrie() {
        let sut = makeTrie()
        sut.remove("Test")
        XCTAssertFalse(sut.contains("Test"))
    }
    
    func test_collectionsStartWith_stringInTrie() {
        let sut = makeTrie()
        let result = sut.collections(startingWith: "T")
        XCTAssertEqual(result, ["Test", "TestFooBar"])
    }
    
    func test_collectionsStartWith_stringInTrie2() {
        let sut = makeTrie()
        let result = sut.collections(startingWith: "Tess")
        XCTAssertNotEqual(result, ["Test", "TestFooBar"])
    }
    
    private func makeEmptyTrie() -> Trie<String> {
        let trie = Trie<String>()
        return trie
    }
    
    private func makeTrie() -> Trie<String> {
        let trie = Trie<String>()
        trie.insert("Test")
        trie.insert("Foo")
        trie.insert("Bar")
        trie.insert("TestFooBar")
        return trie
    }
}
