# Overview
This task is intended for people who interview for our iOS Software Engineer roles.

Please make sure you read [our expectations](../README.md#what-we-are-looking-for) first before starting the following tasks.
Take your time to polish your project. 
Testing is very important for us, add tests where is possible and design the app in a way that should be easy to be tested.

## iOS News App

Build an iOS application that shows the latest news from the United States, using the [newsapi.org](https://newsapi.org) service.

Running the app we should be able to see a list with the latest **US top headlines news** (see [newsapi.org documentation](https://newsapi.org/docs/)).
Each news item in the list should have the description of the article, the author, and the image associated to it. 
If the news doesn't have an image, present an image placeholder of your choice.

If the user clicks on a news item it will navigate to a page displaying the full news article selected.

In the news detail screen the app should also show the number of **likes** and the number of **comments** the news item has.
That information can be retrieved from two internal not authenticated endpoints: 
    * `https://cn-news-info-api.herokuapp.com/likes/<ARTICLEID>` 
    * `https://cn-news-info-api.herokuapp.com/comments/<ARTICLEID>`

The  `<ARTICLEID>`  is the article URL without the scheme and with the `/` replaced with a `-`.
For the article `https://www.cnn.com/2020/07/20/us/portland-protester-navy-veteran-beaten/index.html` the `ARTICLEID` is `www.cnn.com-2020-07-20-us-portland-protester-navy-veteran-beaten-index.html`

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
