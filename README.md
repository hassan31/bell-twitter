# Twitter Assignment
This assignment is developed in Xcode 11.0 using Swift 5.0 Language. The purpose of this assignment is to fetch the most recent tweets using your current location + based on selected radius in the TableView as well as in Mapview.

# Target
This assignment aims to minimum target of iOS 12.0

# Architecture / Design Patteren
This assignment is developed using MVP design patteren. Use of protocols, extensions is also there in this assignment.

# Features
- Fetch most recent tweets based on the location
- Fetch the tweets based on location + selected radius
- Search the tweets by typing any hash tags, name etc

# Use of Cocoa Pods
- TwitterKit
  - TwitterKit is used in this assignment as a main feature or functionality
  - As mentioned in the assignment to use the Twitter Framework to fetch the tweets etc
- Alamofire
  - Used Alamofire dependancy in this assignment to implemnet some rest api to
  - Make the favorite tweet
  - Retweet the selected / current tweet
  
# Unit Test
Native Unit test class `XCTestCase` is being used in this assignment. Tried to cover unit test of all the classes
