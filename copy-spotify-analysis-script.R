library(spotifyr)
library(tidyverse)
library(lubridate)
library(kableExtra)

id <- readr::read_csv('spotify-id.csv') # your unique login / authentication details
Sys.setenv(SPOTIFY_CLIENT_ID = id$id[1])
Sys.setenv(SPOTIFY_CLIENT_SECRET = id$id[2])
access_token <- get_spotify_access_token()
my_id <- '' # spotify id

my_plists <- get_user_playlists(my_id)
top_playlists <- my_plists %>% filter(str_detect(name, 'Your Top')) %>% arrange(name)


t16 <- get_playlist_tracks(top_playlists$id[1]) %>% 
  mutate(artist.name = map_chr(track.artists, function(x) x$name[1]))
t17 <- get_playlist_tracks(top_playlists$id[2]) %>% 
  mutate(artist.name = map_chr(track.artists, function(x) x$name[1]))
t18 <- get_playlist_tracks(top_playlists$id[3]) %>% 
  mutate(artist.name = map_chr(track.artists, function(x) x$name[1]))
t19 <- get_playlist_tracks(top_playlists$id[4]) %>% 
  mutate(artist.name = map_chr(track.artists, function(x) x$name[1]))
#t20 <- get_playlist_tracks(top_playlists$id[5]) %>% 
#  mutate(artist.name = map_chr(track.artists, function(x) x$name[1]))

f16 <- get_track_audio_features(t16$track.id)
f17 <- get_track_audio_features(t17$track.id)
f18 <- get_track_audio_features(t18$track.id)
f19 <- get_track_audio_features(t19$track.id)
# f20 <- get_track_audio_features(t20$track.id)

twenty_16 <- f16 %>% 
  left_join(t16, by = c('id' = 'track.id')) %>% 
  select(names(f16), track.name, artist.name, track.popularity) %>%
  mutate(year = '2016')

twenty_17 <- f17 %>% 
  left_join(t17, by = c('id' = 'track.id')) %>% 
  select(names(f16), track.name, artist.name, track.popularity) %>%
  mutate(year = '2017')

twenty_18 <- f18 %>% 
  left_join(t18, by = c('id' = 'track.id')) %>% 
  select(names(f16), track.name, artist.name, track.popularity) %>%
  mutate(year = '2018')

twenty_19 <- f19 %>% 
  left_join(t19, by = c('id' = 'track.id')) %>% 
  select(names(f16), track.name, artist.name, track.popularity) %>%
  mutate(year = '2019')

# twenty_20 <- f20 %>% 
#  left_join(t20, by = c('id' = 'track.id')) %>% 
#  select(names(f16), track.name, artist.name, track.popularity) %>%
#  mutate(year = '2020')

top <- rbind(twenty_16, twenty_17, twenty_18, twenty_19)

# top %>% write_csv('top100.csv')


