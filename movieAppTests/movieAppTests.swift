//
//  movieAppTests.swift
//  movieAppTests
//
//  Created by Temitope on 30/08/2021.
//

import XCTest
@testable import movieApp

class movieAppTests: XCTestCase {

    var movies: [Movie]!
    
    let item1 = Movie(id: 0, adult: nil, backdropPath: nil, genreIDS: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: "one", video: nil, voteAverage: nil, voteCount: nil, genres: nil)
    
    let item2 = Movie(id: 1, adult: nil, backdropPath: nil, genreIDS: nil, originalLanguage: nil, originalTitle: nil, overview: nil, popularity: nil, posterPath: nil, releaseDate: nil, title: "two", video: nil, voteAverage: nil, voteCount: nil, genres: nil)

    override func setUpWithError() throws {
        movies = MoviePersisterManager.shared.load()
    }

    override func tearDownWithError() throws {
        movies = []
        MoviePersisterManager.shared.clear()
    }

    func test_movies_empty() throws {
        XCTAssertEqual(movies, [])
    }
    
    func test_count1() throws {
        MoviePersisterManager.shared.save(movie: item1)
        XCTAssertEqual(MoviePersisterManager.shared.load().count, 1)
    }
    
    func test_count2() throws {
        MoviePersisterManager.shared.save(movie: item1)
        MoviePersisterManager.shared.save(movie: item2)
        XCTAssertEqual(MoviePersisterManager.shared.load().count, 2)
    }
    
    func test_count_same_item() throws {
        MoviePersisterManager.shared.save(movie: item1)
        MoviePersisterManager.shared.save(movie: item1)
        XCTAssertEqual(MoviePersisterManager.shared.load().count, 1)
    }
    
    func test_remove_count1() throws {
        MoviePersisterManager.shared.save(movie: item1)
        MoviePersisterManager.shared.save(movie: item2)
        MoviePersisterManager.shared.remove(movie: item1)
        XCTAssertEqual(MoviePersisterManager.shared.load().count, 1)
    }
    

}
