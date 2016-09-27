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

**Note**: Due to issues I have with Github this draft is not shown up in the repo's history. A more complete history of this draft and the next can be view in my [Gist](https://gist.github.com/JohnMCMa/56998a61645f3db3a643b91281df23fe).
## Design Changes after the third round of feedback ##
The last round of feedback indicates the axis labels were unclear about what these numbers, so I clarified those were group averages, and the number of players per group were also plotted on the circles by calling the `__data__` objects. The main graph title was also edited to show this is a group-based comparison.

While not initiated by any feedback, I have also unified the `font-family` attributes of all text-based items on the visualization to `sans-serif`.
## Design Changes after the first submission attempt ##
The grader noted that the `z` axis in the bubble graph code in Dimple.js controls the *radii* of the bubbles, which would cause inappropriate bubble comparisons. 
While not completely related to the grader's feedback, I also edited the `z` axis such that the mouseover text--called `getToolTipText` in Dimple.js--refers to the number of players in each handedness group in the mouseover text as "Number of players" rather than the non-indicative "name."

# Feedback #
## First draft ##
[Feedback on the first draft](https://discussions.udacity.com/t/need-feedback-for-p6-baseball/185799) was requested on Udacity forums in late August. After handling technical issues on setting up the Gist, I have only received one feedback from Myles. The main comments surrounding the visualization are:

- A lack of comment to explain the aim of the visualization,
- While the positive relationship between the HR and AVG is visible, the visualization provided no clear relationship between handedness and both HR and AVG.

Because of this I attempted to create visualizations for the central tendencies between the handedness groups as described above.
## Second draft ##
[Feedback for the second draft](https://discussions.udacity.com/t/feedback-for-second-draft-for-baseball/189573) was requested on September 20, 2016, which also included the intended narrative and discussed the data transformations used.

Two users, "georgeliu" and "CtrlAltDel" responded to the request. Both users opined that:

- The visualization was overly busy and distracting to the viewer, and
- The gridlines can be removed, as the usage of mouseover effects makes the gridlines unnecessary.
- Further introduction is needed.

"CtrlAltDel" also opined:

- I should explore some other types of encoding for the visualization, and
- Considering using the proportion of home runs on the Y-axis.

The first three points have been implemented in the next draft by concentrating on the narrative about handedness and performance, removing the gridlines, writing an introduction that is similar to the current summary, and changing the graph headline.

However, as for CtrlAltDel's other suggestions, he had latter conceded that his second opinion is logically faulty. as for his suggestion, it's my own opinion that scatter plot is adequate to visualize two continuous and one categorical variables, and the ability to visualize both continuous variables can be important, so I maintained the use of scatter plot, but with heavy changes.
## Third draft ##
[Feedback for the third draft](https://discussions.udacity.com/t/feedback-request-for-p6-baseball/189922) was requested on September 22, 2016. Only one person, luismirandacruz, responded. His opinion included the following:

- The graphic is overly large and is hard to read,
- It is unclear if I intended to compare HR and AVG,
- Whether the home run count is in "average per player", and
- The variables in the visualization are not self-explanatory. E.g., the size of the circles; suggesting I make it clear by labelling the number of players inside the circle.

I have fully implemented his third point in the final draft by clarifying in the axis labels that they are *group* averages, and took his advice on the fourth point on labelling the circles with the appropriate player counts, I decided to not act on his first two points. The resolution used in the SVG is 1400px X 800px, which is inherited from some of this course's projects and should be acceptable in modern monitors. As for the second point, since I do intend to compare the AVG and HR between the handedness groups, it is considered moot.

## Final draft ##
The final draft is marked as an update for [the third draft's feedback request](https://discussions.udacity.com/t/feedback-request-for-p6-baseball/189922) on September 22, 2016; no response has been received up to date.

# Resources #
- [Colorbrewer](http://colorbrewer2.org/)
- [Dimple.js website](http://dimplejs.org/), including examples and documentation
- [Stack Overflow Question #27535453, *How to normalise subgroups from a grouped data frame in R*](http://stackoverflow.com/questions/27435453/how-to-normalise-subgroups-from-a-grouped-data-frame-in-r), the major inspiration of the code used in `./data/baseball.data.R`.
- [*SVG Text Element*, Dashingd3js.com](https://www.dashingd3js.com/svg-text-element), the main reference of putting text on circles.
- [*How to create a bubble chart in R*](http://sharpsightlabs.com/blog/2014/10/31/bubble-chart-in-r-basic/), Sharp Sight Labs.