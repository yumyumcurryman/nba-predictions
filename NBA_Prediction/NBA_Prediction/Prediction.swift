//
//  Prediction.swift
//  NBA_Prediction
//
//  Created by Micah Elias on 2/8/21.
//

import Foundation


class Prediction {
    
    struct Teams: Codable {
        var teams : [Team]
    }
    
    struct Team: Codable {
        var name : String
        var fieldGoalAttemps : Double
        var fieldGoalPercentage : Double
        var fieldGoal3Attempts : Double
        var fieldGoal3Percentage : Double
        var freeThrowsMade : Double
        var offensiveRebounds : Double
        var defensiveRebounds : Double
        var assists : Double
        var steals : Double
        var blocks : Double
        var turnovers : Double
        var pointsAllowed : Double
        var points : Double
    }
    
    func predict(teamA: String, teamB: String) {
        let model = PredictionModel()
        let data = Data(getJSONString().utf8)
        let decoder = JSONDecoder()
        if let jsonTeams = try? decoder.decode(Teams.self, from: data) {
            var teams = [Team]()
            teams = jsonTeams.teams
            var team_A: Team? = nil
            var team_B: Team? = nil
            for team in teams {
                if team.name == teamA {
                    team_A = team
                } else if team.name == teamB {
                    team_B = team
                }
            }
            do {
                let aPrediction = try model.prediction(field_goals_attempted: team_A!.fieldGoalAttemps, field_goal_percentage: team_A!.fieldGoalPercentage, field_goal_3_attempted: team_A!.fieldGoal3Attempts, field_goal_3_percentage: team_A!.fieldGoal3Percentage, free_throws_made: team_A!.freeThrowsMade, offensive_rebounds: team_A!.offensiveRebounds, defensive_rebounds: team_A!.defensiveRebounds, assists: team_A!.assists, steals: team_A!.steals, blocks: team_A!.blocks, turnovers: team_A!.turnovers, points_allowed: team_B!.points)
                let bPrediction = try model.prediction(field_goals_attempted: team_B!.fieldGoalAttemps, field_goal_percentage: team_B!.fieldGoalPercentage, field_goal_3_attempted: team_B!.fieldGoal3Attempts, field_goal_3_percentage: team_B!.fieldGoal3Percentage, free_throws_made: team_B!.freeThrowsMade, offensive_rebounds: team_B!.offensiveRebounds, defensive_rebounds: team_B!.defensiveRebounds, assists: team_B!.assists, steals: team_B!.steals, blocks: team_B!.blocks, turnovers: team_B!.turnovers, points_allowed: team_A!.points)
                var aRaw = Int(aPrediction.points)
                var bRaw = Int(bPrediction.points)
                if aRaw > bRaw{
                    print("\(teamA) will beat \(teamB) by a score of \(aRaw) to \(bRaw)")
                } else {
                    print("\(teamB) will beat \(teamA) by a score of \(bRaw) to \(aRaw)")
                };
            } catch {
                print(error)
            }
        }
    }
    

    
    
    
    func getJSONString() -> String {
        return """
{"teams": [{"name": "ATL", "fieldGoalAttemps": 88.0, "fieldGoalPercentage": 0.4566, "fieldGoal3Attempts": 35.2, "fieldGoal3Percentage": 0.37779999999999997, "freeThrowsMade": 21.4, "offensiveRebounds": 10.8, "defensiveRebounds": 33.4, "assists": 26.0, "steals": 6.4, "blocks": 4.6, "turnovers": 13.2, "pointsAllowed": 119.6, "points": 717.2}, {"name": "BOS", "fieldGoalAttemps": 87.4, "fieldGoalPercentage": 0.43339999999999995, "fieldGoal3Attempts": 35.4, "fieldGoal3Percentage": 0.41279999999999994, "freeThrowsMade": 17.6, "offensiveRebounds": 10.8, "defensiveRebounds": 29.8, "assists": 20.6, "steals": 6.6, "blocks": 2.6, "turnovers": 9.4, "pointsAllowed": 110.2, "points": 665.0}, {"name": "CLE", "fieldGoalAttemps": 89.0, "fieldGoalPercentage": 0.44620000000000004, "fieldGoal3Attempts": 28.8, "fieldGoal3Percentage": 0.29100000000000004, "freeThrowsMade": 17.0, "offensiveRebounds": 10.2, "defensiveRebounds": 30.8, "assists": 22.4, "steals": 5.8, "blocks": 5.0, "turnovers": 12.4, "pointsAllowed": 125.6, "points": 655.0}, {"name": "NOP", "fieldGoalAttemps": 85.2, "fieldGoalPercentage": 0.5212000000000001, "fieldGoal3Attempts": 32.4, "fieldGoal3Percentage": 0.43640000000000007, "freeThrowsMade": 18.8, "offensiveRebounds": 10.4, "defensiveRebounds": 33.6, "assists": 27.8, "steals": 6.2, "blocks": 5.0, "turnovers": 11.2, "pointsAllowed": 119.0, "points": 775.6}, {"name": "CHI", "fieldGoalAttemps": 87.6, "fieldGoalPercentage": 0.49660000000000004, "fieldGoal3Attempts": 33.8, "fieldGoal3Percentage": 0.40140000000000003, "freeThrowsMade": 13.8, "offensiveRebounds": 9.2, "defensiveRebounds": 33.4, "assists": 27.4, "steals": 5.8, "blocks": 5.4, "turnovers": 12.6, "pointsAllowed": 112.2, "points": 697.4}, {"name": "DAL", "fieldGoalAttemps": 89.4, "fieldGoalPercentage": 0.496, "fieldGoal3Attempts": 42.2, "fieldGoal3Percentage": 0.4312, "freeThrowsMade": 20.8, "offensiveRebounds": 8.8, "defensiveRebounds": 33.4, "assists": 27.6, "steals": 3.6, "blocks": 2.8, "turnovers": 10.6, "pointsAllowed": 129.6, "points": 824.8}, {"name": "DEN", "fieldGoalAttemps": 91.0, "fieldGoalPercentage": 0.4702, "fieldGoal3Attempts": 35.0, "fieldGoal3Percentage": 0.3536, "freeThrowsMade": 12.2, "offensiveRebounds": 9.6, "defensiveRebounds": 31.8, "assists": 25.2, "steals": 7.0, "blocks": 5.8, "turnovers": 11.4, "pointsAllowed": 109.6, "points": 677.0}, {"name": "GSW", "fieldGoalAttemps": 88.0, "fieldGoalPercentage": 0.49560000000000004, "fieldGoal3Attempts": 43.0, "fieldGoal3Percentage": 0.42639999999999995, "freeThrowsMade": 15.2, "offensiveRebounds": 7.0, "defensiveRebounds": 39.0, "assists": 29.6, "steals": 7.0, "blocks": 5.2, "turnovers": 14.2, "pointsAllowed": 110.2, "points": 699.8}, {"name": "HOU", "fieldGoalAttemps": 87.0, "fieldGoalPercentage": 0.42279999999999995, "fieldGoal3Attempts": 44.6, "fieldGoal3Percentage": 0.3234, "freeThrowsMade": 14.0, "offensiveRebounds": 8.4, "defensiveRebounds": 33.2, "assists": 23.0, "steals": 6.8, "blocks": 3.6, "turnovers": 12.4, "pointsAllowed": 112.8, "points": 603.0}, {"name": "LAC", "fieldGoalAttemps": 85.4, "fieldGoalPercentage": 0.5142, "fieldGoal3Attempts": 29.4, "fieldGoal3Percentage": 0.45339999999999997, "freeThrowsMade": 17.4, "offensiveRebounds": 9.8, "defensiveRebounds": 36.4, "assists": 22.0, "steals": 7.4, "blocks": 5.2, "turnovers": 12.6, "pointsAllowed": 109.8, "points": 748.6}, {"name": "LAL", "fieldGoalAttemps": 88.2, "fieldGoalPercentage": 0.5138, "fieldGoal3Attempts": 29.2, "fieldGoal3Percentage": 0.306, "freeThrowsMade": 20.6, "offensiveRebounds": 9.2, "defensiveRebounds": 36.8, "assists": 27.4, "steals": 8.8, "blocks": 6.8, "turnovers": 17.6, "pointsAllowed": 110.4, "points": 722.4}, {"name": "MIA", "fieldGoalAttemps": 80.2, "fieldGoalPercentage": 0.4434, "fieldGoal3Attempts": 36.2, "fieldGoal3Percentage": 0.3878, "freeThrowsMade": 20.4, "offensiveRebounds": 7.6, "defensiveRebounds": 37.0, "assists": 24.2, "steals": 7.4, "blocks": 3.8, "turnovers": 14.0, "pointsAllowed": 98.2, "points": 636.0}, {"name": "MIL", "fieldGoalAttemps": 89.8, "fieldGoalPercentage": 0.5062, "fieldGoal3Attempts": 33.2, "fieldGoal3Percentage": 0.3970000000000001, "freeThrowsMade": 18.0, "offensiveRebounds": 9.2, "defensiveRebounds": 34.6, "assists": 23.8, "steals": 7.4, "blocks": 4.4, "turnovers": 9.6, "pointsAllowed": 114.0, "points": 740.6}, {"name": "MIN", "fieldGoalAttemps": 94.4, "fieldGoalPercentage": 0.458, "fieldGoal3Attempts": 40.0, "fieldGoal3Percentage": 0.38360000000000005, "freeThrowsMade": 12.6, "offensiveRebounds": 11.0, "defensiveRebounds": 30.4, "assists": 27.6, "steals": 9.8, "blocks": 4.8, "turnovers": 12.0, "pointsAllowed": 117.8, "points": 710.0}, {"name": "BKN", "fieldGoalAttemps": 81.8, "fieldGoalPercentage": 0.48440000000000005, "fieldGoal3Attempts": 35.0, "fieldGoal3Percentage": 0.36940000000000006, "freeThrowsMade": 20.6, "offensiveRebounds": 7.8, "defensiveRebounds": 31.8, "assists": 25.0, "steals": 5.4, "blocks": 4.8, "turnovers": 15.6, "pointsAllowed": 116.6, "points": 668.4}, {"name": "NYK", "fieldGoalAttemps": 89.4, "fieldGoalPercentage": 0.4608, "fieldGoal3Attempts": 29.2, "fieldGoal3Percentage": 0.3842, "freeThrowsMade": 11.4, "offensiveRebounds": 11.0, "defensiveRebounds": 39.6, "assists": 21.2, "steals": 7.4, "blocks": 4.0, "turnovers": 13.6, "pointsAllowed": 100.0, "points": 650.2}, {"name": "ORL", "fieldGoalAttemps": 90.4, "fieldGoalPercentage": 0.445, "fieldGoal3Attempts": 31.2, "fieldGoal3Percentage": 0.3678, "freeThrowsMade": 16.4, "offensiveRebounds": 11.6, "defensiveRebounds": 36.4, "assists": 22.0, "steals": 6.4, "blocks": 4.6, "turnovers": 12.2, "pointsAllowed": 113.2, "points": 700.6}, {"name": "IND", "fieldGoalAttemps": 91.8, "fieldGoalPercentage": 0.43900000000000006, "fieldGoal3Attempts": 34.8, "fieldGoal3Percentage": 0.3846, "freeThrowsMade": 10.6, "offensiveRebounds": 9.2, "defensiveRebounds": 33.2, "assists": 26.8, "steals": 7.8, "blocks": 5.6, "turnovers": 9.6, "pointsAllowed": 109.2, "points": 648.8}, {"name": "PHI", "fieldGoalAttemps": 73.0, "fieldGoalPercentage": 0.4976, "fieldGoal3Attempts": 21.6, "fieldGoal3Percentage": 0.31739999999999996, "freeThrowsMade": 19.2, "offensiveRebounds": 9.0, "defensiveRebounds": 31.6, "assists": 18.8, "steals": 6.0, "blocks": 3.6, "turnovers": 12.4, "pointsAllowed": 96.2, "points": 437.8}, {"name": "PHX", "fieldGoalAttemps": 74.2, "fieldGoalPercentage": 0.5104, "fieldGoal3Attempts": 24.2, "fieldGoal3Percentage": 0.3586, "freeThrowsMade": 11.8, "offensiveRebounds": 9.2, "defensiveRebounds": 30.6, "assists": 22.4, "steals": 5.6, "blocks": 3.2, "turnovers": 11.0, "pointsAllowed": 91.2, "points": 456.2}, {"name": "POR", "fieldGoalAttemps": 90.6, "fieldGoalPercentage": 0.44239999999999996, "fieldGoal3Attempts": 39.4, "fieldGoal3Percentage": 0.398, "freeThrowsMade": 19.0, "offensiveRebounds": 12.6, "defensiveRebounds": 35.4, "assists": 16.2, "steals": 5.8, "blocks": 4.8, "turnovers": 10.4, "pointsAllowed": 107.2, "points": 750.2}, {"name": "SAC", "fieldGoalAttemps": 91.8, "fieldGoalPercentage": 0.47639999999999993, "fieldGoal3Attempts": 35.2, "fieldGoal3Percentage": 0.35860000000000003, "freeThrowsMade": 14.4, "offensiveRebounds": 9.8, "defensiveRebounds": 34.6, "assists": 27.0, "steals": 6.2, "blocks": 4.4, "turnovers": 11.6, "pointsAllowed": 115.4, "points": 697.2}, {"name": "SAS", "fieldGoalAttemps": 90.0, "fieldGoalPercentage": 0.43600000000000005, "fieldGoal3Attempts": 27.4, "fieldGoal3Percentage": 0.33280000000000004, "freeThrowsMade": 21.0, "offensiveRebounds": 8.0, "defensiveRebounds": 37.2, "assists": 24.2, "steals": 6.2, "blocks": 6.0, "turnovers": 10.8, "pointsAllowed": 108.4, "points": 696.2}, {"name": "OKC", "fieldGoalAttemps": 94.8, "fieldGoalPercentage": 0.44700000000000006, "fieldGoal3Attempts": 33.6, "fieldGoal3Percentage": 0.3202, "freeThrowsMade": 13.4, "offensiveRebounds": 9.8, "defensiveRebounds": 37.6, "assists": 26.8, "steals": 8.6, "blocks": 3.8, "turnovers": 13.8, "pointsAllowed": 110.8, "points": 643.0}, {"name": "TOR", "fieldGoalAttemps": 89.4, "fieldGoalPercentage": 0.49879999999999997, "fieldGoal3Attempts": 33.4, "fieldGoal3Percentage": 0.4408, "freeThrowsMade": 19.4, "offensiveRebounds": 9.0, "defensiveRebounds": 29.8, "assists": 25.6, "steals": 8.4, "blocks": 5.2, "turnovers": 11.0, "pointsAllowed": 119.4, "points": 733.8}, {"name": "UTA", "fieldGoalAttemps": 87.2, "fieldGoalPercentage": 0.48979999999999996, "fieldGoal3Attempts": 41.0, "fieldGoal3Percentage": 0.41079999999999994, "freeThrowsMade": 18.8, "offensiveRebounds": 10.2, "defensiveRebounds": 38.4, "assists": 24.6, "steals": 4.4, "blocks": 5.8, "turnovers": 14.2, "pointsAllowed": 106.0, "points": 768.0}, {"name": "MEM", "fieldGoalAttemps": 87.6, "fieldGoalPercentage": 0.45640000000000003, "fieldGoal3Attempts": 38.2, "fieldGoal3Percentage": 0.37839999999999996, "freeThrowsMade": 17.4, "offensiveRebounds": 13.2, "defensiveRebounds": 28.6, "assists": 29.4, "steals": 8.2, "blocks": 3.8, "turnovers": 14.0, "pointsAllowed": 118.0, "points": 698.6}, {"name": "WAS", "fieldGoalAttemps": 89.4, "fieldGoalPercentage": 0.40040000000000003, "fieldGoal3Attempts": 34.8, "fieldGoal3Percentage": 0.2512, "freeThrowsMade": 20.2, "offensiveRebounds": 11.0, "defensiveRebounds": 34.4, "assists": 22.0, "steals": 6.6, "blocks": 5.2, "turnovers": 14.4, "pointsAllowed": 117.6, "points": 617.0}, {"name": "DET", "fieldGoalAttemps": 86.6, "fieldGoalPercentage": 0.458, "fieldGoal3Attempts": 34.6, "fieldGoal3Percentage": 0.3194, "freeThrowsMade": 18.8, "offensiveRebounds": 10.8, "defensiveRebounds": 30.0, "assists": 25.0, "steals": 7.8, "blocks": 5.4, "turnovers": 13.8, "pointsAllowed": 113.6, "points": 665.2}, {"name": "CHA", "fieldGoalAttemps": 93.0, "fieldGoalPercentage": 0.48260000000000003, "fieldGoal3Attempts": 35.4, "fieldGoal3Percentage": 0.40759999999999996, "freeThrowsMade": 15.0, "offensiveRebounds": 12.6, "defensiveRebounds": 35.4, "assists": 23.6, "steals": 7.0, "blocks": 4.2, "turnovers": 14.0, "pointsAllowed": 114.6, "points": 733.4}]}
"""
    }

    
}
