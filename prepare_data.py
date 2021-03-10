import requests
import nba_api
import json
from nba_api.stats.endpoints import leaguegamefinder
from nba_api.stats.static import teams

def prepareTeamData(abb):
    print("Parsing data for " + abb)
    team = teams.find_team_by_abbreviation(abb)
    team_id = team['id']
    gamefinder = leaguegamefinder.LeagueGameFinder(team_id_nullable=team_id)
    games = gamefinder.get_data_frames()[0]
    games = games[games.SEASON_ID.str[-4:] == '2020']
    pts = 0
    fga = 0
    fgp = 0
    fg3a = 0
    fg3p = 0
    ftm = 0
    offr = 0
    defr = 0
    ass = 0
    stl = 0
    blk = 0
    tov = 0
    pts_a = 0
    for x in range(0, 5):
        game = games.iloc[x]
        pts += pts + game.PTS
        fga += game.FGA
        fgp += game.FG_PCT
        fg3a += game.FG3A
        fg3p += game.FG3_PCT
        ftm += game.FTM
        offr += game.OREB
        defr += game.DREB
        ass += game.AST
        stl += game.STL
        blk += game.BLK
        tov += game.TOV
        pts_a += game.PTS + (-1 * game.PLUS_MINUS)
    return [fga / 5, fgp / 5, fg3a / 5, fg3p / 5, ftm / 5, offr / 5, defr / 5, ass / 5, stl / 5, blk / 5, tov / 5, pts_a / 5, pts / 5]

# SET UP ABBREVIATIONS

nba_teams = teams.get_teams()
t = {}
t['teams'] = []
for team in nba_teams:
    abb = team['abbreviation']
    data = prepareTeamData(abb)
    team_data = {
        'name' : abb,
        'fieldGoalAttemps' : data[0],
        'fieldGoalPercentage' : data[1],
        'fieldGoal3Attempts' : data[2],
        'fieldGoal3Percentage' : data[3],
        'freeThrowsMade' : data[4],
        'offensiveRebounds' : data[5],
        'defensiveRebounds' : data[6],
        'assists' : data[7],
        'steals' : data[8],
        'blocks' : data[9],
        'turnovers' : data[10],
        'pointsAllowed' : data[11],
        'points' : data[12]
    }
    t['teams'].append(team_data)
with open('data.json', 'w') as outfile:
    json.dump(t, outfile)