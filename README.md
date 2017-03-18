# swift-bootstrap

# README #

## Coding standards ##

### Naming ###

* Use descriptive names with camelcase for classes, methods, variables, etc. Classes should be capitalized while method names should start with lowercase
Spacing
* One line between any line of code (Not on variables definitions)
* Method braces always open in the same line
* Use one space separation between any operators for clarity

### Code Separation ###

* Use //MARK: - to make navigating the code easier

### Conditionals ###

* Conditionals bodies should always be in braces

### Ternary Operator ###

* Should only be used when increases clarity

### Methods ###

* There should be an space between method arguments

### Extensions naming ###

* ClassName+Functionality

### Protocols ###

* Declare all protocols in its own file
* File should have the same name as the protocol

### Use of self ###

* Avoid using self since Swift doesn’t require it to access objects or
methods

### Completion blocks ###

* Don't include their definition unless is necessary e.g () -> () in remove () -> ()

### Types ###

* Try to use native types when available

### Type inference ###

* Let the compiler infer the type for a constant or variable unless you need to specify a type

### Declarations ###

* Prefer short declarations over full generics syntax

### Semicolons ###

* No need to use them, you should not have two statements in the same line

### Code header comments ###

* Should be removed as the code belongs to the team not to the person the has created the class

### Other considerations ###

* Keep it simple
* Keep classes and methods short
* No comments (the code should be self explanatory)

### Folders ###

* Create class folders in finder and drag them to Xcode

### Configs ###

* Configuration driven by xcconfigs

## Unit Testing ##

* Unit testing is done using XCTest
