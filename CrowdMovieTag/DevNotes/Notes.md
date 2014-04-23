Sam's todo list for the Controller Branch

Branch TODO:

Revisit:
- Update Profile Score based on user actions

- AllMovies
- Implement search
	- Access stored procedures

- Add Error Handling

? Implement Admin 
	? What tasks does an admin perform?


+ AddMoviePage

+ Profile retrieval
	+ Retrieve tags
	+ Retreive votes
	+ Retreive movies

+ MovieDetails
	+ Calculate the score: Score is updated when a vote is cast
	+ ApplyExistingTag
	+ Apply New Tag
	+ Voting
	+ Movie Tag Retrieval

+ AddMovie: Add submitterID to the movie

+ Switch tagMap to Vote

+ Redo Database Initialization to actually map Votes to users

+ Movie Adding
	+ Authentication
	+ Validation
	+ Model Binding

+ Movie Details page
	+ Bind Movie
	+ Query for tags for that movie
		+ May need a custom select method, probably not though
	+ Add a tag for the movie
		+ Authenticate!

+ Add database context
	+ Movie
	+ Tags
+ Implement User Management
	+ Login -> ASP.net
	+ Registration -> ASP.Net
		+ Create a profile entry from a registration
	+ Figure out what table to use for the users -> ASP.net

