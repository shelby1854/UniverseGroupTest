# UniverseGroupTestApp
 
UniverseGroupTestApp is an iOS application built using the MVVM (Model-View-ViewModel) architecture pattern with dependency injection and RxSwift for reactive programming. The app allows users to browse films, mark them as favorites, and manage their favorite films.

Features
Splash Screen: A loading screen that transitions to the main content.
Films List: Displays a list of films fetched from a service.
Favorites Management:
Mark films as favorites.
Remove selected or all favorite films.
Placeholder view when there are no favorite films.
Reactive Programming: Utilizes RxSwift for binding data between ViewModels and Views.
Dependency Injection: Centralized DI container (AppDIContainer) for managing services and view creation.
Architecture
The app follows MVVM (Model-View-ViewModel) with a Coordinator pattern for navigation. Key architectural components include:

1. AppCoordinator
Manages the application's navigation flow, starting from the splash screen and transitioning to the main tab bar.

2. MainCoordinator
Handles navigation within the main tab bar, setting up the FilmsViewController and FavoritesViewController as tabs.

3. AppDIContainer
Manages dependency injection and provides scene creation methods for controllers and ViewModels.

4. RxSwift
Used for reactive data binding, ensuring that UI updates are synchronized with data changes.

Future Improvements
Networking: Replace mock data with real API calls.
Unit Tests: Add tests for ViewModels and services using mock implementations.
Localization: Add support for multiple languages.
Animations: Enhance UI transitions and interactions with animations.
