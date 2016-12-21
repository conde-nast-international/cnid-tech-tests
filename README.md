# Interview

This is a coding exercise to help us assess candidates looking to join the team at Condé Nast International.  The test is intended to be completed at home, and we expect you to spend no more than 1-2 hours on it.  If you haven't finished in that time, you can send us your progress - we don't want you to spend days on this.  We understand that your time is valuable, and appreciate any time that you contribute towards building a strong team here.  If you really cannot spare the time, you may want to take a look at Option 2.

## Option 1

There is a JSON file containing 10 articles.  An article has fixed data such as the title and cover image, but also has a content field which is an array of objects that can be distinguished by the ```type``` property.  The possible types in this dataset are ```plaintext```, ```pull_quote``` and ```h2```. Using this JSON file as your data source we would like you to create a website that does the following:

- The root of the site should display a list of the articles, with their title and picture.
- Clicking an article should take you to a page that displays the article and update the url.
- The article page should layout the content with styling for each type of content.  For example a pull quote may look like this:

> Your pull quote may look something like this


### What we are looking for

- We anticipate that the website may have future requirements, so you should aim for maintainability with your solution.
- The javascript ecosystem changes quickly, so we like to see knowledge of javascript fundamentals
- We want to discover how you write code day-to-day
- We don't want you to spend hours tweaking every pixel.  Keep it simple.

### Submission

You can submit your code however you want - send the details to your point of contact.  Please include a README containing any setup instructions and keep the setup steps simple.  

### FAQ

Q: What browsers must I support?  
A: Latest firefox & chrome, but don't worry about any browser inconsistencies.

Q: Can I use transpilers?  
A: Yes, but you [may not need to](http://kangax.github.io/compat-table/es6/).

Q: Can I use libraries, frameworks, etc?  
A: Yes, but please consider the 'What we are looking for?' guidelines.

Q: Should my solution be client-side only/server-side only/client-server?  
A: That's up to you.  We are interested in how you solve the problem, so we don't want to force you down any particular route.

## Option 2

If you have some personal code that you would be prepared to share with us, we can assess that instead.  The code should meet the following criteria:

- It should be at least 1-2 hours of your own work
- Ideally, it should involve an element of web development
- It should demonstrate how you approach a problem
- It should be something that you are able to discuss with us

### Submission

You can submit your code however you want - send the details to your point of contact.  Please include a README containing any setup instructions and keep the setup steps simple.

## Option 3

Create a node.js 'Hello World' web application and deploy it to a free AWS account using appropriate tools and best practices.  When deployed, the root url should display 'Hello World'. Do not send us your AWS credentials - we will take your solution and deploy it to our own account.

### What we are looking for

- We anticipate that the app may have future infrastructure requirements, so you should aim for maintainability with your solution.
- Those naughty [Chaos Monkeys](https://github.com/netflix/chaosmonkey) have been known to randomly terminate AWS instances.  Your solution should be resilient to this.
- Members of the team use various OSes and distributions.  It would be great if they could develop the application locally in a consistent environment.
- We want to discover how you handle infrastructure day-to-day.
- Monitoring is great but we don't want you to worry about it for now.
- The same goes for CI servers.

### What we are not looking for

## Submission

You can submit your code however you want - send the details to your point of contact.  Please include a README containing any setup instructions and keep the setup steps simple.
