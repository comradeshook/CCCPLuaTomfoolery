local Rad = math.rad;
local Max = math.max;
local Min = math.min;
local Cos = math.cos;
local Sin = math.sin;
local Sqrt = math.sqrt;
local Ceil = math.ceil;
local Random = math.random;
local Atan2 = math.atan2;
local Pi = math.pi;

-- TO USE: First, you may need to convert an actual vector to a table via VecToTable().
-- After that, you can use all the following operators to essentially treat
-- that table as a vector, but MUCH CHEAPER performance-wise since it skips having to 
-- go back and forth between Lua and C++.
-- Note, however, that these tables can't be added directly to vectors (ala A + B),
-- so you have to use VecTableToVector() for that purpose. The conversion functions
-- are unfortunately expensive, so this whole thing is best suited for long scripts;
-- small scripts may have any performance gain completely nulled by the conversion overhead.
-- ~ ComradeShook

-- also i'm not done adding all the functions yet sorry

local function VecToTable(vector)
	return {vector.X, vector.Y};
end

local function VecTableToVector(TVector)
	return Vector(inputTable[1], inputTable[2]);
end

local function VecCopy(TVector)
	return {TVector[1], TVector[2]};
end

local function VecAdd(TVector1, TVector2)
	TVector1[1] = TVector1[1] + TVector2[1];
	TVector1[2] = TVector1[2] + TVector2[2];
	return TVector1
end

local function VecSubtract(TVector1, TVector2)
	TVector1[1] = TVector1[1] - TVector2[1];
	TVector1[2] = TVector1[2] - TVector2[2];
	return TVector1
end

local function VecMultiply(TVector, multiplier)
	TVector[1] = TVector[1] * multiplier;
	TVector[2] = TVector[2] * multiplier;
	return TVector;
end

local function VecDivide(TVector, divisor)
	TVector[1] = TVector[1] / divisor;
	TVector[2] = TVector[2] / divisor;
	return TVector;
end

local function VecGetMagnitude(TVector)
	return Sqrt(TVector[1] * TVector[1] + TVector[2] * TVector[2]);
end
local function VecGetMagnitudeSqr(TVector)
	return TVector[1] * TVector[1] + TVector[2] * TVector[2];
end

local function VecGetAbsRadAngle(TVector)
	local radAngle = -Atan2(TVector[2], TVector[1]); 
	if radAngle < -Pi/2 then
		return radAngle + Pi*2;
	else
		return radAngle;
	end
end

local function VecSetMagnitude(TVector, magnitude)
	if (TVector[1] ~= 0 or TVector[2] ~= 0) then
		local multiplier = magnitude/VecGetMagnitude(TVector);
		return VecMultiply(TVector, multiplier);
	else
		return {magnitude, 0};
	end
end

local function VecCapMagnitude(TVector, cap)
	if VecGetMagnitude(TVector) > cap then
		VecSetMagnitude(TVector, cap);
	end
	return TVector;
end

local function VecGetRadRotatedCopy(TVector, angle)
	local returnVector = {TVector[1], TVector[2]};
	local adjustedAngle = -angle;
	returnVector[1] = TVector[1] * Cos(adjustedAngle) - TVector[2] * Sin(adjustedAngle);
	returnVector[2] = TVector[1] * Sin(adjustedAngle) + TVector[2] * Cos(adjustedAngle);
	return returnVector;
end

local function VecAbsRotateTo(TVector, refVector)
	return VecGetRadRotatedCopy(TVector, VecGetAbsRadAngle(refVector) - VecGetAbsRadAngle(TVector)); 
end