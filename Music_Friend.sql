# Query 1 AmountOfSongsJohnAndMary

# This query has all the requirements met. It has select statements, joins, filtering,
# aggregation(talked with Will about this), linking, and subqueries

# What this query is trying to do is its taking a user and songs and it is finding out the number of favorite songs there are for users.
# Then it is taking only the uers with the user profile id that is 1 and 3 and displaying in the order of who has the least amount of favorite songs
# to the largest amount. It also creates a view that gets replaced each time it is run.

USE music_friend;
Create or replace view AmountOfFavSongsJohnAndMary as
SELECT 
   count(song_genres) as 'num_of_favorite_genres',
    favorite_genre, CONCAT(first_name, ' ', last_name) AS Name
FROM songs
JOIN streams USING (song_id)
JOIN user_profile USING (profile_id)

WHERE song_genres = favorite_genre and profile_id in ( 
	select profile_id FROM user_profile where profile_id = 1 or profile_id=  3)
Group by Name 
ORDER BY num_of_favorite_genres;

select * from AmountOfFavSongsJohnAndMary;

#----------------------------------------------------------

SELECT (Artist.artist_first_name+' '+Artist.artist_last_name)AS Artist_name FROM Music_Friend.Artist,
(SELECT (Artist.artist_first_name+' '+Artist.artist_last_name) FROM Artist WHERE Artist.artist_id=songs.song_id)AS song_title 
INNER JOIN Weather_Table ON weather_Table.weather_id= Aritst.Artist_id
INNER JOIN Season_Table ON Season_Table.season_id = Weather_Table.Season_id
INNER JOIN Mood_table ON Mood_Table.mood_id = course_sections.course_id
