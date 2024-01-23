This is where i'll be storing various Lua things for public use in Cortex Command Community Project. You probably shouldn't expect them to work in other Lua implementations if they're not completely generalised. :V

__TableVectorLibrary.lua__
A fat load of functions that's pretty much CC's Vector functions translated to Lua, and which uses tables instead of vectors. Reason behind this being that currently, using vectors in CC is FAR SLOWER than tables, which doesn't matter for small scripts but can quickly become problematic in large scripts with long for-loops. 
This is clunkier to work with and introduces some overhead from conversion, but can massively improve performance.

~ ComradeShook
