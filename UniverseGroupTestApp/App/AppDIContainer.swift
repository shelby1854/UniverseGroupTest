//
//  AppDIContainer.swift
//  UniverseGroupTestApp
//
//  Created by Pavlo Bratkevych on 26.01.2025.
//


final class AppDIContainer {
    // MARK: - Services
    lazy var filmsService: FilmsServiceProtocol = {
        FilmsService()
    }()
    
    // MARK: - Scenes
    func makeSplashScene() -> (view: SplashViewController, viewModel: SplashViewModel) {
        let splashVM = SplashViewModel(filmsService: filmsService)
        let splashVC = SplashViewController(viewModel: splashVM)
        
        return (splashVC, splashVM)
    }
    
    func makeFilmsScene() -> (view: FilmsViewController, viewModel: FilmsViewModel) {
        let filmsVM = FilmsViewModel(filmsService: filmsService)
        let filmsVC = FilmsViewController(viewModel: filmsVM)
        
        return (filmsVC, filmsVM)
    }
    
    func makeFavoritesScene() -> (view: FavoritesViewController, viewModel: FavoritesViewModel) {
        let favoritesFilmsVM = FavoritesViewModel(filmsService: filmsService)
        let favoriteFilmsVC = FavoritesViewController(viewModel: favoritesFilmsVM)
        
        return (favoriteFilmsVC, favoritesFilmsVM)
    }
}
