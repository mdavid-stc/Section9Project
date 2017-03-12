The Changing Flow of the Nile River
========================================================
author: Mark David
date: 12 March 2017
autosize: true

The Data
========================================================

The data set used here is the "Nile" data set built into R.

```r
data("Nile")
```

The Description from the Help file says these are:<br>
"Measurements of the annual flow of the river Nile at Aswan [Egypt], 1871–1970 in 10^8 m^3 <i>with apparent changepoint</i>"

The summary of the measurements looks like:

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  456.0   798.5   893.5   919.4  1032.0  1370.0 
```

The Goal
========================================================

The goal of this project is to explore what is meant by "apparent changepoint" in the Description.

If we look at the original data (in gray on the plot in the provided Shiny app), it seems quite jagged, so there is not an immediately obvious point where the flow changes permanently.

What we want to see is a sharp discontinuity, like a "step" function, where the long-term flow of the river either increases or decreases a significant amount in one year.

To get a longer-term view, we apply smoothing operations to the data. If we did this to the entire data set, we would see the overall rising or falling trend, but that is not enough here. To see a changepoint, we want to see two trends: one before the change point (solid black line) and a different one afterwards (blue line).

How To Interact with the Graph
========================================================

There are two controls you can use to try to find the changepoint:

1. Year Slider
   + Use this slider to check different changepoint years.
   + The chosen year will be marked with a vertical dotted line in the Shiny graph.
   + The graph will update with new smoothed lines for the data on each side of that year.
2. Pick the Smoothing Function
   + Different smoothing functions will give different results.
   + Try choosing different functions to see if one shows the difference better than the others.

Hint
========================================================

A clear discontinuity will look like one of these example graphs:

![plot of chunk unnamed-chunk-3](NileFlow-figure/unnamed-chunk-3-1.png)

<i><small>Try looking just before the turn of the century.</small></i>
