Rad = math.rad;
Deg = math.deg;
Max = math.max;
Min = math.min;
Cos = math.cos;
Sin = math.sin;
Sqrt = math.sqrt;
Ceil = math.ceil;
Random = math.random;
Atan2 = math.atan2;
Pi = math.pi;
Floor = math.floor;
Ceil = math.ceil;
Abs = math.abs;

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

-- IMPORTANT MANAGEMENT FUNCTIONS
function VecToTable(vector)
	return {vector.X, vector.Y};
end

function VecTableToVector(TVector)
	return Vector(inputTable[1], inputTable[2]);
end

function VecCopy(TVector)
	return {TVector[1], TVector[2]};
end

-- ARITHMETIC FUNCTIONS - These change the (first) table!
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

-- GETTERS - These don't change the input table.
function VecGetRoundedX(TVector)
	return Floor(TVector[1] + 0.5)
end

function VecGetRoundedY(TVector)
	return Floor(TVector[2] + 0.5)
end

function VecGetRounded(TVector)
	return {Floor(TVector[1] + 0.5), Floor(TVector[2] + 0.5)}
end

function VecGetFlooredX(TVector)
	return Floor(TVector[1])
end

function VecGetFlooredY(TVector)
	return Floor(TVector[2])
end

function VecGetFloored(TVector)
	return {Floor(TVector[1]), Floor(TVector[2])}
end

function VecGetCeilingedX(TVector)
	return Ceil(TVector[1])
end

function VecGetCeilingedY(TVector)
	return Ceil(TVector[2])
end

function VecGetCeilinged(TVector)
	return {Ceil(TVector[1]), Ceil(TVector[2])}
end

function VecGetMagnitude(TVector)
	return Sqrt(TVector[1] * TVector[1] + TVector[2] * TVector[2]);
end
function VecGetSqrMagnitude(TVector)
	return TVector[1] * TVector[1] + TVector[2] * TVector[2];
end

function VecGetLargest(TVector)
	return Max(Abs(TVector[1]), Abs(TVector[2]))
end

function VecGetSmallest(TVector)
	return Min(Abs(TVector[1]), Abs(TVector[2]))
end

function VecGetNormalized(TVector)
	local returnVector = VecCopy(TVector);
	return VecDivide(returnVector, VecGetMagnitude(TVector));
end

function VecGetPerpendicular(TVector)
	return {TVector[2], -TVector[1]}
end

function VecGetAbsRadAngle(TVector)
	local radAngle = -Atan2(TVector[2], TVector[1]); 
	if radAngle < -Pi/2 then
		return radAngle + Pi*2;
	else
		return radAngle;
	end
end

function VecGetAbsDegAngle(TVector)
	return Deg(VecGetAbsRadAngle(TVector))
end

function VecGetXFlipped(TVector, xFlip)
	if xFlip then
		return {-TVector[1], TVector[2]}
	else
		return TVector
	end
end

function VecGetYFlipped(TVector, yFlip)
	if yFlip then
		return {TVector[1], -TVector[2]}
	else
		return TVector
	end
end

-- SETTERS - By definition these must change the table. :V
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

function VecGetRadRotatedCopy(TVector, angle)
	local returnVector = {TVector[1], TVector[2]};
	local adjustedAngle = -angle;
	returnVector[1] = TVector[1] * Cos(adjustedAngle) - TVector[2] * Sin(adjustedAngle);
	returnVector[2] = TVector[1] * Sin(adjustedAngle) + TVector[2] * Cos(adjustedAngle);
	return returnVector;
end

function VecAbsRotateTo(TVector, refVector)
	return VecGetRadRotatedCopy(TVector, VecGetAbsRadAngle(refVector) - VecGetAbsRadAngle(TVector)); 
end

function VecMagnitudeIsGreaterThan(TVector, magnitude)
	return VecGetSqrMagnitude(TVector) > magnitude * magnitude;
end

function VecMagnitudeIsLessThan(TVector, magnitude)
	return VecGetSqrMagnitude(TVector) < magnitude * magnitude;
end

-- TO ADD:
-- VecClampMagnitude()
-- VecFlipX()
-- VecFlipY()
-- VecIsZero()
-- VecIsOpposedTo()
-- VecDot()
-- VecCross()
-- VecRound()
-- VecToHalf()
-- VecFloor()
-- VecCeiling()
-- VecNormalize()
-- VecPerpendicularize()
-- VecReset()
-- VecRadRotate()
-- VecDegRotate()
-- VecSetXY()