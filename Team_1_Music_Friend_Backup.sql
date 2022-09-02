# Query 1 AmountOfSongsJohnAndMary(Avram)

# This query has all the requirements met. It has select statements, joins, filtering,
# aggregation(talked with Will about this), linking, and subqueries

# What this query is trying to do is its taking a user and songs and it is finding out the number of favorite songs there are for users.
# Then it is taking only the uers with the user profile id that is 1 and 3 and displaying in the order of who has the least amount of favorite songs
# to the largest amount. It also creates a view that gets replaced each time it is run.

Create or replace view AmountOfFavSongsJohnAndMary as
SELECT 
   count(song_genres) as 'num_of_favorite_genres',
    favorite_genre, CONCAT(first_name, ' ', last_name) AS name
FROM songs
JOIN streams USING (song_id)
JOIN user_profile USING (profile_id)

WHERE song_genres = favorite_genre and profile_id in ( 
	select profile_id FROM user_profile where profile_id = 1 or profile_id=  3)
Group by name 
ORDER BY num_of_favorite_genres;

select * from AmountOfFavSongsJohnAndMary;

#----------------------------------------------------------


# query 2 NumOfJohnsSongsForSunnySeason
# What this query is trying to do is to find the number of songs that would be for sunny season
# it is taking the season_is that is less than  4, which will include the season spring and summer and none and displaying
#the season the song belongs to. It as well has a new that will display when the code is ran 
Create or replace view NumOfJohnsSongsForSunnySeason as

SELECT ss.season_id, season, COUNT(*) AS SunnySongs 
FROM Song_For_Situation ss
INNER JOIN Season_Table s ON s.season_id = ss.season_id

WHERE s.season_id < 4
GROUP BY ss.season_id;

select * from NumOfJohnsSongsForSunnySeason;
#-------------------------------------------------------------------------------
# Query 3
#In this query, we use artist name to filter out songs by weather condition, we have filtered out songs that are specifically for winter(snow) weather 
CREATE OR REPLACE VIEW ArtistSongSnowyWeather AS 

SELECT CONCAT (Artist.artist_first_name,' ',Artist.artist_last_name) AS Artistname,song_title,weather
    from songs
         join weather_table using(weather_id)
         join Artist using (artist_id)
    WHERE weather = 'Snow';
    
select * from ArtistSongSnowyWeather;   

