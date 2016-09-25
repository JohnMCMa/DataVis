# Summary #
The baseball data set includes data from 1,157 baseball players including their names, handnesses, weight, height, battling average (AVG) and home run count (HR). In this visualization, I plan to show that while there are far more right-handed baseball players in this data set, that have lower battling averages and home run counts compared to left-handed and both-handed players.
# Design #
## First draft ##
From my exploratory data analyses, I have noticed that:

- Right-handed players have lower average AVG and HR than other handedness groups, and
- AVG and HR are exponentially related.

As a result, I attempted to demonstrate this two trends by using a simple scatter plot.. Because AVG and HR are exponentially related, I decided that HR should be log-scaled.

Rather than the default color scheme used by Dimple.js, I used [ColourBrewer Qualitative 3-Class Dark2 scheme](http://colorbrewer2.org/#type=qualitative&scheme=Dark2&n=3), which is colorblind-safe.

## Design Changes after the first round of feedback ##
The only feedback I obtained from the first draft is that the while it communicated exponential relationship between AVG and HR, the fact that right-handed players have lower AVG and HR than the other two groups is not clear. Thus, I decided to show some measures of central tendencies of the handedness groups on the graph by superimposing [dual-measure area charts](http://dimplejs.org/examples_viewer.html?id=areas_dual_measure) to demonstrate "the most center players" from each handedness group. My code in determining the distance between a player's statistics to the center was implemented as and R script `./data/baseball.data.R`. This script used the `dplyr` module to perform the following steps:

1. Since AVG is a ratio between 0 to 1 and HR is a count, they are both first rescaled to a 0-100 scale.
2. For each handedness group, the geometric center point on the Cartesian plane is calculated as (group AVG mean, group HR mean).
3. Euclidean distances between each player and their corresponding group's center point were calculated.
4. The percentiles of the distances from group centers in (3) were determinated for each player.

The output of this R script is written as `./data/baseball_data_remodeled.csv`.

Within the HTML file, JavaScript was used to subset `data` for those players that are at the lowest distance quantile as `data_filtered`. `data_filtered` was then used to draw dual-measure area charts and superimposed over the original scatter plot, which was plotted using the unfiltered data. Separate legends tracks were generated to the two serieses and hand-tuned to match the series' aesthetics.
## Design Changes after the second round of feedback ##
Commentators noted the second draft was overly busy and the narrative is still unclear. Therefore I decided to remove one narrative, i.e. the exponential relationship between AVG and HR, from the visualization. This is because the Project's Data Set Options page prefers a visualization that *shows differences among the performance of the baseball players*, thus the relationship between AVG and HR is less important.

Therefore, the scatter plot was heavily changed to visualize the *group means* of AVG and HR, with the sizes of the circles controlled by the number of players within the handedness group.

Since I no longer intend to show the exponential relationship between AVG and HR, the Y-axis for HR was no longer log-scaled, and given the small number of data points, the limits of the axes were hand-adjusted to maximize the size of the dots.

In addition, based on feedback I have also removed the grid lines to decrease the amount of ink on the plot.
## Design Changes after the third round of feedback ##
The last round of feedback indicates the axis labels were unclear about what these numbers, so I clarified those were group averages, and the number of players per group were also plotted on the circles by calling the `__data__` objects. The main graph title was also edited to show this is a group-based comparison.

While not initiated by any feedback, I have also unified the `font-family` attributes of all text-based items on the visualization to `sans-serif`.
# Feedback #
## After first draft ##
## After second draft ##
## After third draft ##
## After final draft ##
# Resources #
- [Colorbrewer](http://colorbrewer2.org/)
- [Dimple.js website](http://dimplejs.org/), including examples and documentation
- [Stack Overflow Question #27535453, *How to normalise subgroups from a grouped data frame in R*](http://stackoverflow.com/questions/27435453/how-to-normalise-subgroups-from-a-grouped-data-frame-in-r), the major inspiration of the code used in `./data/baseball.data.R`.
- [*SVG Text Element*, Dashingd3js.com](https://www.dashingd3js.com/svg-text-element), the main reference of putting text on circles.