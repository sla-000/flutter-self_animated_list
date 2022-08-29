<a href="https://github.com/sla-000/flutter-self_animated_list/actions">
<img src="https://github.com/sla-000/flutter-self_animated_list/workflows/flutter%20test/badge.svg" alt="Analyze and tests status">
</a>
<a href="https://opensource.org/licenses/MIT">
<img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="MIT License"/>
</a>


# SelfAnimatedList

AnimatedList which animates itself when list of the data changes


## Problem

When we get list of some data from API and update tiles, usually we see some strange things 
happen - some tiles appear from nowhere and some disappear, in the length of one frame tiles 
shift somewhere and this happens every time data is updated.

We can use AnimatedList from flutter SDK. But how can we calculate diff between two consecutive 
lists and know what tiles to remove and what to add and where? This task is non-trivial and also 
we need some code to control add and remove of tiles.


## Solution

This widget incapsulates diff logic and wraps standard AnimatedList. All you need to do:
- pass list of your data to widget 
- create builder, that maps data to widget
- (optionally) add in/out animation


## Demo

### Add and remove two random tiles

<video src='docs/22.18.37.mp4' width=300/>

### Swap two random tiles

<video src='docs/22.18.16.mp4' width=300/>


## Caveats

- Swap algorithm is really dumb and make unnecessary add/remove ops
- Items widgets should have different keys or have no keys at all (see example)
