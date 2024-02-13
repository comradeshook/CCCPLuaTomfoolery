Rad = math.rad;
Deg = math.deg;
Max = math.max;
Min = math.min;
Cos = math.cos;
Sin = math.sin;
Sqrt = math.sqrt;
Ceil = math.ceil;
Atan2 = math.atan2;
Floor = math.floor;
Ceil = math.ceil;
Abs = math.abs;
Pi = math.pi;

-- Because we need ShortestDistance baybee
wrapX = SceneMan.SceneWrapsX;
wrapY = SceneMan.SceneWrapsY;
sceneWidth = SceneMan.SceneWidth;
sceneHeight = SceneMan.SceneHeight;

-- apparently std::signbit() returns true if num is negative
function Sign(num)
	return num < 0;
end

function GetSign(num)
	if num < 0 then
		return -1;
	else
		return 1;
	end
end

function Round(num)
	return num >= 0 and Floor(num + 0.5) or Ceil(num - 0.5); -- stole this from StackExchange, thanks ggVGc lol
end

function VecShortestDistance(TVector1, TVector2, toWrap)
	local returnVector = VecCopy(TVector2);
	VecSubtract(returnVector, TVector1);

	if toWrap and (wrapX or wrapY) then
		if wrapX then
			local xDiff = returnVector[1];
			if Abs(xDiff) > sceneWidth/2 then
				returnVector[1] = xDiff - GetSign(xDiff) * sceneWidth;
			end
		end

		if wrapY then
			local yDiff = returnVector[2];
			if Abs(yDiff) > sceneHeight/2 then
				returnVector[2] = yDiff - GetSign(yDiff) * sceneHeight;
			end
		end
	end
	
	return returnVector;
end

-- TO USE: This library essentially treats two-entry tables e.g. {1, 2} as vectors, 
-- letting you skip the astonishingly high cost of going back and forth between C++ and Lua.

-- First, you may need to convert an actual vector to a table via VecToTable().
-- After that, you can use all the following operators to process the tables as you
-- would vectors. Although this is clunkier than regular arithmetic operators, I don't
-- know how to overload those in Lua, and it's still a whole lot more performant anyways.

-- Note, however, that these tables can't be added directly to vectors (ala A + B),
-- so you might have to use VecTableToVector() for that purpose. Further note, manually
-- adding vector.X and table[1] etc is faster than vector + table! 

-- The conversion functions are unfortunately expensive, so this whole thing is best suited for long scripts;
-- small scripts may have any performance gain completely nulled by the conversion overhead.
-- ~ ComradeShook

--------------

-- CREATION - you REALLY don't need this, just define local newTable = {x, y}
function VecNew(X, Y)
	return {X, Y};
end

-- DESTRUCTION - i'm just following the source structure honestly
function VecReset(TVector)
	TVector[1] = 0;
	TVector[2] = 0;
	return TVector;
end

-- IMPORTANT MANAGEMENT FUNCTIONS - these aren't really things in source but are nice to have
function VecToTable(vector)
	return {vector.X, vector.Y};
end

function VecTableToVector(TVector)
	return Vector(TVector[1], TVector[2]);
end

function VecCopy(TVector)
	return {TVector[1], TVector[2]};
end

-- ARITHMETIC FUNCTIONS - These change the (first) table! Order of operations is as input.
function VecAdd(TVector1, TVector2)
	TVector1[1] = TVector1[1] + TVector2[1];
	TVector1[2] = TVector1[2] + TVector2[2];
	return TVector1
end

function VecSubtract(TVector1, TVector2)
	TVector1[1] = TVector1[1] - TVector2[1];
	TVector1[2] = TVector1[2] - TVector2[2];
	return TVector1
end

function VecMultiply(TVector, multiplier)
	TVector[1] = TVector[1] * multiplier;
	TVector[2] = TVector[2] * multiplier;
	return TVector;
end

function VecDivide(TVector, divisor)
	TVector[1] = TVector[1] / divisor;
	TVector[2] = TVector[2] / divisor;
	return TVector;
end

-- GETTERS AND SETTERS
function GetX(TVector)
	return TVector[1];
end

function SetX(TVector, newX)
	TVector[1] = newX;
	return TVector;
end

function GetY(TVector)
	return TVector[2];
end

function SetX(TVector, newY)
	TVector[2] = newY;
	return TVector;
end

function VecSetXY(TVector, newX, newY)
	TVector[1] = newX;
	TVector[2] = newY;
	return TVector;
end

function VecGetLargest(TVector)
	return Max(Abs(TVector[1]), Abs(TVector[2]))
end

function VecGetSmallest(TVector)
	return Min(Abs(TVector[1]), Abs(TVector[2]))
end

function VecGetXFlipped(TVector, xFlip)
	if xFlip then
		return {-TVector[1], TVector[2]}
	else
		return TVector
	end
end

function VecFlipX(TVector, xFlip)
	local vec = VecGetXFlipped(TVector, xFlip);
	VecSetXY(TVector, vec[1], vec[2]);
	return TVector;
end

function VecGetYFlipped(TVector, yFlip)
	if yFlip then
		return {TVector[1], -TVector[2]}
	else
		return TVector
	end
end

function VecFlipY(TVector, yFlip)
	local vec = VecGetXFlipped(TVector, yFlip);
	VecSetXY(TVector, vec[1], vec[2]);
	return TVector;
end

function VecXIsZero(TVector)
	return TVector[1] == 0;
end

function VecYIsZero(TVector)
	return TVector[2] == 0;
end

function VecIsZero(TVector)
	return TVector[1] == 0 and TVector[2] == 0;
end

function VecIsOpposedTo(TVector1, TVector2) 
	return ((TVector1[1] == 0 and TVector2[1] == 0) or (Sign(TVector1[1]) ~= Sign(TVector2[1]))) and ((TVector1[2] == 0 and TVector2[2] == 0) or (Sign(TVector1[2]) ~= Sign(TVector2[2])));
end

-- MAGNITUDE
function VecGetSqrMagnitude(TVector)
	return TVector[1] * TVector[1] + TVector[2] * TVector[2];
end

function VecGetMagnitude(TVector)
	return Sqrt(TVector[1] * TVector[1] + TVector[2] * TVector[2]);
end

function VecMagnitudeIsLessThan(TVector, magnitude)
	return VecGetSqrMagnitude(TVector) < magnitude * magnitude;
end

function VecMagnitudeIsGreaterThan(TVector, magnitude)
	return VecGetSqrMagnitude(TVector) > magnitude * magnitude;
end

function VecSetMagnitude(TVector, magnitude)
	if (TVector[1] ~= 0 or TVector[2] ~= 0) then
		local multiplier = magnitude/VecGetMagnitude(TVector);
		return VecMultiply(TVector, multiplier);
	else
		return {magnitude, 0};
	end
end

function VecCapMagnitude(TVector, cap)
	if VecGetMagnitude(TVector) > cap then
		VecSetMagnitude(TVector, cap);
	end
	return TVector;
end

function VecClampMagnitude(TVector, lowerMagnitudeLimit, upperMagnitudeLimit)
	local lowest = Min(lowerMagnitudeLimit, upperMagnitudeLimit);
	local highest = Max(lowerMagnitudeLimit, upperMagnitudeLimit);

	if lowerMagnitudeLimit == 0 and upperMagnitudeLimit == 0 then
		VecReset(TVector);
	elseif VecMagnitudeIsLessThan(TVector, lowest) then
		VecSetMagnitude(TVector, lowest);
	elseif VecMagnitudeIsGreaterThan(TVector, highest) then
		VecSetMagnitude(TVector, highest);
	end

	return TVector;
end

function VecGetNormalized(TVector)
	local returnVector = VecCopy(TVector);
	return VecDivide(returnVector, VecGetMagnitude(TVector));
end

function VecNormalize(TVector)
	local vec = VecGetNormalized(TVector);
	VecSetXY(TVector, vec[1], vec[2]);
	return TVector;
end

-- ROTATION
function VecGetAbsRadAngle(TVector)
	local radAngle = -Atan2(TVector[2], TVector[1]); 
	if radAngle < -Pi/2 then
		return radAngle + Pi*2;
	else
		return radAngle;
	end
end

function VecSetAbsRadAngle(TVector, angle)
	return VecRadRotate(TVector, angle - VecGetAbsRadAngle(TVector));
end

function VecGetAbsDegAngle(TVector)
	return Deg(VecGetAbsRadAngle(TVector))
end

function VecSetAbsDegAngle(TVector, angle)
	return VecDegRotate(TVector, angle - VecGetAbsDegAngle(TVector));
end

function VecGetRadRotatedCopy(TVector, angle)
	local returnVector = {TVector[1], TVector[2]};
	local adjustedAngle = -angle;
	returnVector[1] = TVector[1] * Cos(adjustedAngle) - TVector[2] * Sin(adjustedAngle);
	returnVector[2] = TVector[1] * Sin(adjustedAngle) + TVector[2] * Cos(adjustedAngle);
	return returnVector;
end

function VecRadRotate(TVector, angle)
	local vec = VecGetRadRotatedCopy(TVector, angle);
	VecSetXY(TVector, vec[1], vec[2]);
	return TVector;
end

function VecGetDegRotatedCopy(TVector, angle)
	return VecGetRadRotatedCopy(TVector, Rad(angle));
end

function VecDegRotate(TVector, angle)
	local vec = VecGetDegRotatedCopy(TVector, angle);
	VecSetXY(TVector, vec[1], vec[2]);
	return TVector;
end

function VecAbsRotateTo(TVector, refVector)
	return VecRadRotate(TVector, VecGetAbsRadAngle(refVector) - VecGetAbsRadAngle(TVector)); 
end

function VecGetPerpendicular(TVector)
	return {TVector[2], -TVector[1]}
end

function VecPerpendicularize(TVector)
	local vec = VecGetPerpendicular(TVector);
	VecSetXY(TVector, vec[1], vec[2]);
	return TVector;
end

-- ROUNDING
function VecRound(TVector)
	local vec = VecGetRounded(TVector);
	VecSetXY(TVector, vec[1], vec[2]);
	return TVector;
end

function VecToHalf(TVector)
	TVector[1] = Round(TVector[1] * 2) / 2;
	TVector[2] = Round(TVector[2] * 2) / 2;
	return TVector;
end

function VecFloor(TVector)
	local vec = VecGetFloored(TVector);
	VecSetXY(TVector, vec[1], vec[2]);
	return TVector;
end

function VecCeiling(TVector)
	local vec = VecGetCeilinged(TVector);
	VecSetXY(TVector, vec[1], vec[2]);
	return;
end

function VecGetRounded(TVector)
	return {Round(TVector[1]), Round(TVector[2])}
end

function VecGetRoundedX(TVector)
	return Round(TVector[1])
end

function VecGetRoundedY(TVector)
	return Round(TVector[2])
end

function VecGetFloored(TVector)
	return {Floor(TVector[1]), Floor(TVector[2])}
end

function VecGetFlooredX(TVector)
	return Floor(TVector[1])
end

function VecGetFlooredY(TVector)
	return Floor(TVector[2])
end

function VecGetCeilinged(TVector)
	return {Ceil(TVector[1]), Ceil(TVector[2])}
end

function VecGetCeilingedX(TVector)
	return Ceil(TVector[1])
end

function VecGetCeilingedY(TVector)
	return Ceil(TVector[2])
end

-- VECTOR PRODUCTS
function VecDot(TVector1, TVector2)
	return (TVector1[1] * TVector2[1]) + (TVector1[2] * TVector2[2]);
end

function VecCross(TVector1, TVector2)
	return (TVector1[1] * TVector2[2]) - (TVector2[1] * TVector1[2]);
end