#' Quarterbacks in the National Football League draft, 1997-2013
#'
#'
#'
#' @docType data
#'
#' @usage data(QB_draft)
#'
#' @format A data.frame object with one row for each American football college quarterback
#' who was drafted into the National Football League.
#'
#' - `Year`: Year drafted into the NFL
#' - `Round`: Draft round the player was selected
#' - `Pick`: Order of the player among those drafted in his year
#' - `NFLTeam`: The NFL team that drafted the player
#' - `College`: The college played for
#' - `Div1A`: Whether the college was in Division 1A of the NCAA
#' - `Name`: Player's name
#' - `ColG`: Number of college games played
#' - `ColRushAtt`: Number of rush attempts made in college games
#' - `ColRushYds`: Total yards gained in those rush attempts
#' - `ColRushTD`: Number of touchdowns scored in those rush attempts
#' - `ColAtt`: Number of passes attempted in college games
#' - `ColComp`: Number of completed passes in college games
#' - `ColInt`: Number of intercepted passes given up in college games
#' - `ColYds`: Total yards gained in college games
#' - `ColTD`: Total number of
#' - `G` - Number of NFL games played
#' - `Comp`: Number of passes completed in NFL games
#' - `Att`: Number of passes attempted in NFL games
#' - `Yds`: Number of yards gained in NFL games
#' - `TD`: Number of touchdowns scored in NFL games
#' - `Int`: Number of intercepted passes given up in NFL games
#' - `RushAtt`: Number of rushing attempts in NFL games
#' - `RushYds`: Total yards gained in those attempts
#' - `RushTD`: Number of times touchdown scored on a
#' - `CarAV`: "Career approximate value" statistic for player
#' - `Sacks`: Number of times sacked in NFL games
#' - `FumLost`: Number of fumbles made in NFL games
#' - `ProBowls`: Number of NFL pro-bowl games played
#' - `YrsStarterPrior2015`: Numbe of years the QB was a starter for their pro team (before 2015, when the data were assembled).
#' - `Wonderlic`: Score on Wonderlic intelligence test
#' - `height`: Height in inches
#' - `weight`: Weight in pounds
#' - `BenchReps`: Number of bench presses
#' - `Yard40`: Time to run 40 yards (secs)
#' - `Yard20`: Time to run 20 yards (secs)
#' - `Yard10`: Time to run 10 yards (secs)
#' - `VerticalJump`: Height of vertical jump (inches)
#' - `BroadJump`: Length of broad jump (inches)
#' - `shuttle`: time to complete the shuttle shuttle (secs)
#' - `cone`: time to complete the 3-cone drill (secs)
#' - `time`: the record time in seconds
#' - `swimmer` the name of the swimmer
#' - `date` a Date object containing the date the record was made
#' - `place` string descripting the location
#' - `sex`: coded as `F` and `M`
#' - `lengths`: the total distance was divided into lengths of either 25 or 50 meters. `lengths` gives the number of such lengths in the total distance.
#' - `dist`: the total distance (in meters) of the race
#'
#' @keywords datasets
#'
#' @source  Wolfson, J., Addona, V., and Schmicker, R. (2017) Forecasting the performance
#' of college prospects selected in the National Football League draft. In J.
#' Albert, M.E. Glickman, T.B. Swartz, & R.H. Koning (Eds.), Handbook of Statistical
#' Methods and Analyses in Sports. Chapman & Hall/CRC.
#'
"QB_draft"
