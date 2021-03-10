import requests
import pandas
import csv
# import tensorflow as tf
# from keras import layers
# from keras.layers.experimental import preprocessing

import numpy

from nba_api.stats.endpoints import leaguegamefinder
from nba_api.stats.static import teams

nba_teams = teams.get_teams()
team_abbreviations = []

rows = []

for team in nba_teams:
    team_abbreviations.append(team['abbreviation'])

for abb in team_abbreviations:
    team = teams.find_team_by_abbreviation(abb)
    team_id = team['id']
    gamefinder = leaguegamefinder.LeagueGameFinder(team_id_nullable=team_id)
    games = gamefinder.get_data_frames()[0]
    games = games[games.SEASON_ID.str[-4:] == '2020']
    for x in range(0, 20):
        print("Processing games for " + abb)
        game = games.iloc[x]
        points = game.PTS
        field_goals_attempted = game.FGA
        field_goal_percentage = game.FG_PCT
        field_goal_3_attempted = game.FG3A
        field_goal_3_percentage = game.FG3_PCT
        free_throws_made = game.FTM
        offensive_rebounds = game.OREB
        defensive_rebounds = game.DREB
        assists = game.AST
        steals = game.STL
        blocks = game.BLK
        turnovers = game.TOV
        points_allowed = points + (-1 * game.PLUS_MINUS)
        game_final = [field_goals_attempted, field_goal_percentage, field_goal_3_attempted, field_goal_3_percentage, free_throws_made, offensive_rebounds, defensive_rebounds, assists, steals, blocks, turnovers, points_allowed, points]
        rows.append(game_final)

fields = ["field_goals_attempted", "field_goal_percentage", "field_goal_3_attempted", "field_goal_3_percentage", "free_throws_made", "offensive_rebounds", "defensive_rebounds", "assists", "steals", "blocks", "turnovers", "points_allowed", "points"]
# name of csv file
filename = "2020_data.csv"

# writing to csv file
with open(filename, 'w') as csvfile:
    # creating a csv writer object
    csvwriter = csv.writer(csvfile)

    # writing the fields
    csvwriter.writerow(fields)

    # writing the data rows
    csvwriter.writerows(rows)
    print("done writing nba data")

# nba_data_train = pandas.read_csv("nba_data.csv", names=fields)
# nba_data_train.head()
# nba_data_features = nba_data_train.copy()
# data_labels = nba_data_features.pop('points')
# model = tf.keras.Sequential([
#   layers.Dense(64),
#   layers.Dense(1)
# ])
#
# model.compile(loss = tf.losses.MeanSquaredError(),
#                       optimizer = tf.optimizers.Adam())

