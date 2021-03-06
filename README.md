# MDC-100 Series of Codelabs

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

# Learning Points
# MDC-101
- Using [TextField] widgets and [TextEditingController] widgets to take user input
- [ElevatedButton] vs [TextButton] and button design (to have one main elevated button and leave the rest as text buttons to guide the user)

# MDC-102
- Using [Card] Widgets for stylish display
- Using [GridView.count] to generate grids when there is a known number of children
- Using functions to generate widgets dynamically
- Using the [AppBar] Widget to create a platform-agnostic app bar with action buttons and a title

# MDC-103
- Creating and using themes to customize app 
- A glimpse at custom widgets like [AsymmetricView] and [CutCornerOutline] 
- Consulting the definition of Widgets when unsure about usage 
- Styling and customizing widget shapes and elevations


# MDC-104
- Using [Material] widgets to add shape 
- Different methods of implementing animation such as using [Tween], AnimatedFoo, or Transition widgets 
- Using [Stack] widgets to layer screens instead of navigating to a new route

# Next Steps
- [x] Add a page to display details about each product
    * Learning points
    * Using [Hero] Widgets to implement cross-page animations 
- [ ] Add widget unit tests for custom widgets
- [x] Fully document all methods 
    * Learning points
    * Writing concise summaries for classes and methods
    * Learning to think from a user's perspective to know what is important enough to be documented
- [x] Add a cart / checkout page
    * Learning points
    * Using the Provider package to manage state
    * Building models to deal with the business logic of the app
- [x] Use the Provider package to refactor some stateful widgets 
    * Learning points
    * Using the Provider package to manage state
    * Writing unit tests for classes that extend [ChangeNotifier]
- [x] Make custom loading animation
    * Learning Points
    * Extending built-in classes and overriding methods to better fit your needs
    * How to structure complex animations
    * How to make never-ending animations
- [x] Refactor [ProductRepository] methods into async methods to better simulate a database 
    * Learning points
    * Using [FutureBuilder] to handle [Future] objects
    * Using the keywords  `async` and `await`
    * Dealing with [Future] objects
    * Using [CircularProgressIndicator] to create loading screens
- [ ] Use Firebase to create a user authentication system
- [ ] Use Firestore to move [ProductsRepository] into a database
- [ ] Learn about integration tests and write one if appropriate

