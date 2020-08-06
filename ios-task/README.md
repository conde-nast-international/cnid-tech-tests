# Overview
This assessment is intended for people who interview for our iOS Software Engineer roles. There are three options for candidates completing this assessment; please read through each carefully and let us know which you would prefer to use.

## General assessment criteria
 * Please make sure you read [our expectations](../README.md#what-we-are-looking-for) first before starting the following tasks.
 * Take your time to polish your project.
 * At Conde Nast we unit test our code and strive to allow code design to be guided by these. Please add unit tests where possible in your solution. Feel free to use XCTest or, if it's your preference, a 3rd party utility like Quick/Nimble

## Option 1: Take-home exercise

Build an iOS application that shows the latest news from the United States, using the [newsapi.org](https://newsapi.org) service.

Running the app we should be able to see a list with the latest **US top headlines news** (see [newsapi.org documentation](https://newsapi.org/docs/)).
Each news item in the list should have the description of the article, the author, and the image associated to it. 
If the news doesn't have an image, present an image placeholder of your choice.

If the user clicks on a news item it will navigate to a new screen displaying the full news article selected, and some info regarding it.

The additional info are the number of **likes** and the number of **comments** the news item has.
That information can be retrieved from two internal not authenticated endpoints: 

 * `https://cn-news-info-api.herokuapp.com/likes/<ARTICLEID>` 
 * `https://cn-news-info-api.herokuapp.com/comments/<ARTICLEID>`

The  `<ARTICLEID>`  is the article URL without the scheme and with the `/` replaced with a `-`.
For the article `https://www.theverge.com/2020/7/21/21332300/nikon-z5-full-frame-mirrorless-camera-price-release-date-specs/index.html` the `ARTICLEID` is `www.theverge.com-2020-7-21-21332300-nikon-z5-full-frame-mirrorless-camera-price-release-date-specs-index.html`

The app should have tests around the functionalities.
Although UI and UX are important, the goal of this demo is to show your thought process and how you architect your application. The design should take into consideration features that might be added in the future, like for example, offline reading, bookmarking, etc.

### Submission
See ["how to submit your work"](../README.md#how-to-submit-code)

### FAQ

Q: Should I commit my `newsapi.org` token?  
A: No, but please provide one for us

Q: What version of iOS must I support?  
A: The minimum version of the app is iOS 13, and feel free to use Swift 5.2 and its features. 

Q: Can I use libraries, frameworks, CocoaPods etc?  
A: Yes, but be prepared to justify why you did so.

## Option 2: Share existing code

If you have some existing iOS code that you would be prepared to share with us, we can look at that instead. The code should meet the following criteria:

* It should be of a similar scale as the feature discussed in Option 1
* It should demonstrate how you approach a problem
* It should be something that you are able to discuss with us

## Option 3: Pairing exercise

Lastly, if you prefer, you may choose to carry out a "no preparation required" pairing exercise during the interview with our engineers.
