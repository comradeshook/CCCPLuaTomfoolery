This is where i'll be storing various Lua things for public use in Cortex Command Community Project. You probably shouldn't expect them to work in other Lua implementations if they're not completely generalised. :V

__TableVectorLibrary.lua__ - A fat load of functions that's pretty much CC's Vector functions translated to Lua, and which uses tables instead of vectors. Reason behind this being that currently, using vectors in CC is FAR SLOWER than tables, which doesn't matter for small scripts but can quickly become problematic in large scripts with long for-loops. 
This is clunkier to work with and introduces some overhead from conversion, but can massively improve performance.

__MegaGib.lua__ - Provides a function that gibs the target MO and ALL of its children.

__SelfGib.lua__ - Attach this to an MOSRotating to make it instantly gib when spawned and/or thrown.

__RandomEmissionRectangle.lua__ - Script to spawn a given particle in a random position within a given rectangle.

__RandomiseEmissionOffset.lua__ - Attach to an AEmitter to randomise ``EmissionOffset`` of ALL its emissions to a random value within a given rectangle.

~ ComradeShook