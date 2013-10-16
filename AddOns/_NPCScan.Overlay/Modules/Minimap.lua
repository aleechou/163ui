--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Modules/Minimap.lua - Canvas for the Minimap.                              *
  ****************************************************************************]]


local Overlay = select( 2, ... );
local Minimap = Minimap;
local NS = CreateFrame( "Frame" );

NS.InsideAlphaMultiplier = 1 / 3;
NS.UpdateDistance = 0.5;
NS.UpdateRateDefault  = 0.04;
NS.UpdateRateRotating = 0.02; -- Faster so that spinning the minimap appears smooth
local UpdateRate = NS.UpdateRateDefault;

local UpdateForce, IsInside, RotateMinimap, Radius, Quadrants;

-- Lots of thanks to Routes (http://www.wowace.com/addons/routes/)




do
	local SplitPoints = {};
	local X, Y, Facing, Width, Height;
	local FacingSin, FacingCos;

	local PaintPath;
	do
		--- @return True if the point's quadrant is rounded.
		local function IsQuadrantRound ( X, Y )
			return Quadrants[ Y <= 0 -- Y-axis is flipped
				and ( X >= 0 and 1 or 2 )
				 or ( X >= 0 and 4 or 3 ) ];
		end
		local Points, LastExitPoint, IsClockwise = {};
		local LastRoundX, LastRoundY;

		local AddRoundSplit;
		do
			local AngleStart, AngleEnd, AngleIncrement;
			local ArcSegmentLength, TwoPi = math.pi / 20, math.pi * 2;
			local Atan2, Cos, Sin = math.atan2, math.cos, math.sin;
			--- Fills the triangle's intersection with round minimap borders.
			-- @param EndX..EndY  Intersection point to fill to from (LastRoundX,LastRoundY).
			function AddRoundSplit ( EndX, EndY )
				AngleStart, AngleEnd = Atan2( -LastRoundY, LastRoundX ), Atan2( -EndY, EndX );
				LastRoundX, LastRoundY = nil;

				if ( IsClockwise ) then
					AngleIncrement = -ArcSegmentLength;
					if ( AngleStart < AngleEnd ) then
						AngleStart = AngleStart + TwoPi;
					end
				else
					AngleIncrement = ArcSegmentLength;
					if ( AngleEnd < AngleStart ) then
						AngleEnd = AngleEnd + TwoPi;
					end
				end

				for Angle = AngleStart + AngleIncrement, AngleEnd - AngleIncrement / 2, AngleIncrement do
					Points[ #Points + 1 ] = Cos( Angle ) / 2;
					Points[ #Points + 1 ] = -Sin( Angle ) / 2;
				end
			end
		end

		local AddSplit;
		do
			local Infinity = math.huge;
			local StartX, StartY;
			local Ax, Ay, Bx, By;
			local SplitX, SplitY, Side;
			local StartDistance2, StartPoint;
			local NearestDistance2, NearestPoint;
			local Distance2;
			local ForStart, ForEnd, ForStep;
			--- Adds split points between the last exit intersection and the most recent entrance intersection.
			-- @param WrapToStart  True if (EndX,EndY) is the first point and doesn't need to be re-added to the Points list.
			function AddSplit ( EndX, EndY, WrapToStart )
				StartX, StartY = Points[ LastExitPoint ], Points[ LastExitPoint + 1 ];
				LastExitPoint = nil;

				if ( IsQuadrantRound( StartX, StartY ) ) then
					LastRoundX, LastRoundY = StartX, StartY;
				else
					LastRoundX, LastRoundY = nil;
				end

				if ( #SplitPoints > 0 ) then
					if ( IsClockwise ) then -- Split points to the right of line AB are valid
						Ax, Ay = EndX, EndY;
						Bx, By = StartX, StartY;
					else
						Ax, Ay = StartX, StartY;
						Bx, By = EndX, EndY;
					end

					-- Find first split point after start
					StartDistance2, StartPoint = Infinity;
					NearestDistance2, NearestPoint = Infinity;
					ForEnd, ForStep = #SplitPoints - 1, IsClockwise and -2 or 2;
					for Index = IsClockwise and ForEnd or 1, IsClockwise and 1 or ForEnd, ForStep do
						SplitX, SplitY = SplitPoints[ Index ], SplitPoints[ Index + 1 ];
						Side = ( Bx - Ax ) * ( SplitY - Ay ) - ( By - Ay ) * ( SplitX - Ax );

						if ( Side > 0 ) then -- Valid split point
							Distance2 = ( StartX - SplitX ) ^ 2 + ( StartY - SplitY ) ^ 2;
							if ( Distance2 < NearestDistance2 ) then
								NearestPoint, NearestDistance2 = Index, Distance2;
							end
							if ( Distance2 < StartDistance2 and Distance2 < ( EndX - SplitX ) ^ 2 + ( EndY - SplitY ) ^ 2 ) then
								StartPoint, StartDistance2 = Index, Distance2;
							end
						end
					end
					if ( not StartPoint ) then
						StartPoint = NearestPoint;
					end

					-- Add all split points after start
					if ( StartPoint ) then
						SplitX, SplitY = SplitPoints[ StartPoint ], SplitPoints[ StartPoint + 1 ];
						if ( LastRoundX ) then
							AddRoundSplit( SplitX, SplitY );
						elseif ( SplitX == 0 or SplitY == 0 ) then
							LastRoundX, LastRoundY = SplitX, SplitY;
						end
						Points[ #Points + 1 ] = SplitX;
						Points[ #Points + 1 ] = SplitY;

						ForStart, ForEnd = StartPoint + 2, StartPoint + #SplitPoints - 2;
						for Index = IsClockwise and ForEnd or ForStart, IsClockwise and ForStart or ForEnd, ForStep do
							SplitX, SplitY = SplitPoints[ ( Index - 1 ) % #SplitPoints + 1 ], SplitPoints[ Index % #SplitPoints + 1 ];
							Side = ( Bx - Ax ) * ( SplitY - Ay ) - ( By - Ay ) * ( SplitX - Ax );

							if ( Side > 0 ) then -- Valid split point
								if ( LastRoundX ) then
									AddRoundSplit( SplitX, SplitY );
								elseif ( SplitX == 0 or SplitY == 0 ) then
									LastRoundX, LastRoundY = SplitX, SplitY;
								end
								Points[ #Points + 1 ] = SplitX;
								Points[ #Points + 1 ] = SplitY;
							else
								break;
							end
						end
					end
				end

				if ( LastRoundX ) then
					AddRoundSplit( EndX, EndY );
				end
				if ( not WrapToStart ) then
					-- Add re-entry point
					Points[ #Points + 1 ] = EndX;
					Points[ #Points + 1 ] = EndY;
				end
			end
		end

		local AddIntersection;
		do
			local ABx, ABy;
			local PointX, PointY;
			local IntersectPos, Intercept, Length2, Temp;
			--- Adds the intersection of line AB with the minimap to the Points list.
			-- @param PerpDist2  Distance from center to intersection squared.
			-- @param IsExiting  True if should save found intersection as the last exit point.
			function AddIntersection ( Ax, Ay, Bx, By, PerpDist2, IsExiting )
				PointX, PointY = nil;
				ABx, ABy = Ax - Bx, Ay - By;
				--assert( ABx ~= 0 or ABy ~= 0, "Points A and B don't form a line." );

				-- Clip to square
				if ( Ax >= -0.5 and Ax <= 0.5 and Ay >= -0.5 and Ay <= 0.5 ) then
					PointX, PointY = Ax, Ay;
				else
					if ( ABy ~= 0 ) then -- Not horizontal line
						-- Test vertical intersection
						Intercept = ABy < 0 and -0.5 or 0.5;
						IntersectPos = ( Ay - Intercept ) / ABy;
						if ( IntersectPos >= 0 and IntersectPos <= 1 ) then
							PointX = Ax - ABx * IntersectPos;
							if ( PointX >= -0.5 and PointX <= 0.5 ) then
								PointY = Intercept;
							end
						end
					end

					if ( not PointY -- Was no vertical intersect
						and ABx ~= 0 -- Not vertical line
					) then
						-- Test horizontal intersection
						Intercept = ABx < 0 and -0.5 or 0.5;
						IntersectPos = ( Ax - Intercept ) / ABx;
						if ( IntersectPos >= 0 and IntersectPos <= 1 ) then
							PointY = Ay - ABy * IntersectPos;
							if ( PointY >= -0.5 and PointY <= 0.5 ) then
								PointX = Intercept;
							end
						end
					end

					if ( not PointX or not PointY ) then
						return;
					end
				end

				if ( IsQuadrantRound( PointX, PointY ) ) then
					-- Clip to circle
					if ( PerpDist2 < 0.25 ) then
						Length2 = ABx * ABx + ABy * ABy;
						Temp = ABx * Bx + ABy * By;

						IntersectPos = ( ( Temp * Temp - Length2 * ( Bx * Bx + By * By - 0.25 ) ) ^ 0.5 - Temp ) / Length2;
						if ( IntersectPos >= 0 and IntersectPos <= 1 ) then
							PointX, PointY = Bx + ABx * IntersectPos, By + ABy * IntersectPos;
						else
							return;
						end
					else
						return;
					end
				end

				if ( LastExitPoint ) then
					AddSplit( PointX, PointY );
				else
					if ( IsExiting ) then
						LastExitPoint = #Points + 1;
					end
					Points[ #Points + 1 ] = PointX;
					Points[ #Points + 1 ] = PointY;
				end
			end
		end

		local COORD_MAX = 2 ^ 16 - 1;
		local BYTES_PER_TRIANGLE = 2 * 2 * 3;
		local wipe = wipe;
		local Ax, Ax2, Ay, Ay2, Bx, Bx2, By, By2, Cx, Cx2, Cy, Cy2;
		local ABx, ABy, BCx, BCy, ACx, ACy;
		local AInside, BInside, CInside;
		local IntersectPos, PerpX, PerpY;
		local ABPerpDist2, BCPerpDist2, ACPerpDist2;
		local Dot00, Dot01, Dot02, Dot11, Dot12;
		local Denominator, U, V;
		local Texture, Left, Top;
		--- Callback to ApplyZone to clip and paint all path triangles to the minimap.
		-- @see Overlay.ApplyZone
		function PaintPath ( self, PathData, FoundX, FoundY, R, G, B )
			if ( FoundX ) then
				FoundX, FoundY = FoundX * Width - X, FoundY * Height - Y;
				if ( RotateMinimap ) then
					FoundX, FoundY = FoundX * FacingCos - FoundY * FacingSin, FoundX * FacingSin + FoundY * FacingCos;
				end
				--Do Not remove.  Disabled to unclutter map untill good way to limit number can be fount
				--Overlay.DrawFound( self, FoundX + 0.5, FoundY + 0.5, Overlay.DetectionRadius / ( Radius * 2 ), "OVERLAY", R, G, B );
			end

			local PointsOffset, LinesOffset, TrianglesOffset = Overlay.GetPathPrimitiveOffsets( PathData );
			for Index = TrianglesOffset, #PathData, BYTES_PER_TRIANGLE do
				Ax, Ax2, Ay, Ay2, Bx, Bx2, By, By2, Cx, Cx2, Cy, Cy2 = PathData:byte( Index, Index + BYTES_PER_TRIANGLE - 1 );
				Ax, Ay = ( Ax * 256 + Ax2 ) / COORD_MAX * Width - X, ( 1 - ( Ay * 256 + Ay2 ) / COORD_MAX ) * Height - Y;
				Bx, By = ( Bx * 256 + Bx2 ) / COORD_MAX * Width - X, ( 1 - ( By * 256 + By2 ) / COORD_MAX ) * Height - Y;
				Cx, Cy = ( Cx * 256 + Cx2 ) / COORD_MAX * Width - X, ( 1 - ( Cy * 256 + Cy2 ) / COORD_MAX ) * Height - Y;

				if ( RotateMinimap ) then
					Ax, Ay = Ax * FacingCos - Ay * FacingSin, Ax * FacingSin + Ay * FacingCos;
					Bx, By = Bx * FacingCos - By * FacingSin, Bx * FacingSin + By * FacingCos;
					Cx, Cy = Cx * FacingCos - Cy * FacingSin, Cx * FacingSin + Cy * FacingCos;
				end

				if ( -- If all points are on one side, cannot possibly intersect
					not ( ( Ax > 0.5 and Bx > 0.5 and Cx > 0.5 )
					or ( Ax < -0.5 and Bx < -0.5 and Cx < -0.5 )
					or ( Ay > 0.5 and By > 0.5 and Cy > 0.5 )
					or ( Ay < -0.5 and By < -0.5 and Cy < -0.5 ) )
				) then
					if ( IsQuadrantRound( Ax, Ay ) ) then
						AInside = Ax * Ax + Ay * Ay <= 0.25;
					else
						AInside = Ax <= 0.5 and Ax >= -0.5 and Ay <= 0.5 and Ay >= -0.5;
					end
					if ( IsQuadrantRound( Bx, By ) ) then
						BInside = Bx * Bx + By * By <= 0.25;
					else
						BInside = Bx <= 0.5 and Bx >= -0.5 and By <= 0.5 and By >= -0.5;
					end
					if ( IsQuadrantRound( Cx, Cy ) ) then
						CInside = Cx * Cx + Cy * Cy <= 0.25;
					else
						CInside = Cx <= 0.5 and Cx >= -0.5 and Cy <= 0.5 and Cy >= -0.5;
					end

					if ( AInside and BInside and CInside ) then -- No possible intersections
						Overlay.TextureAdd( self, "ARTWORK", R, G, B,
							Ax + 0.5, Ay + 0.5, Bx + 0.5, By + 0.5, Cx + 0.5, Cy + 0.5 );
					else
						ABx, ABy = Ax - Bx, Ay - By;
						BCx, BCy = Bx - Cx, By - Cy;
						ACx, ACy = Ax - Cx, Ay - Cy;

						if ( ( ABx ~= 0 or ABy ~= 0 ) and ( BCx ~= 0 or BCy ~= 0 ) and ( ACx ~= 0 or ACy ~= 0 ) ) then
							-- Intersection between the side and a line perpendicular to it that passes through the center
							IntersectPos = ( Ax * ABx + Ay * ABy ) / ( ABx * ABx + ABy * ABy );
							PerpX, PerpY = Ax - IntersectPos * ABx, Ay - IntersectPos * ABy;
							ABPerpDist2 = PerpX * PerpX + PerpY * PerpY; -- From center to intersection squared

							IntersectPos = ( Bx * BCx + By * BCy ) / ( BCx * BCx + BCy * BCy );
							PerpX, PerpY = Bx - IntersectPos * BCx, By - IntersectPos * BCy;
							BCPerpDist2 = PerpX * PerpX + PerpY * PerpY;

							IntersectPos = ( Ax * ACx + Ay * ACy ) / ( ACx * ACx + ACy * ACy );
							PerpX, PerpY = Ax - IntersectPos * ACx, Ay - IntersectPos * ACy;
							ACPerpDist2 = PerpX * PerpX + PerpY * PerpY;


							if ( #Points > 0 ) then
								wipe( Points );
							end
							LastExitPoint = nil;

							-- Check intersection with circle with radius at minimap's corner
							if ( ABPerpDist2 < 0.5 or BCPerpDist2 < 0.5 or ACPerpDist2 < 0.5 ) then -- Inside radius ~= 0.71
								-- Find all polygon vertices
								IsClockwise = BCx * ( By + Cy ) + ABx * ( Ay + By ) + ( Cx - Ax ) * ( Cy + Ay ) > 0;
								if ( AInside ) then
									Points[ #Points + 1 ] = Ax;
									Points[ #Points + 1 ] = Ay;
								else
									AddIntersection( Ax, Ay, Cx, Cy, ACPerpDist2, true );
									AddIntersection( Ax, Ay, Bx, By, ABPerpDist2 );
								end
								if ( BInside ) then
									Points[ #Points + 1 ] = Bx;
									Points[ #Points + 1 ] = By;
								else
									AddIntersection( Bx, By, Ax, Ay, ABPerpDist2, true );
									AddIntersection( Bx, By, Cx, Cy, BCPerpDist2 );
								end
								if ( CInside ) then
									Points[ #Points + 1 ] = Cx;
									Points[ #Points + 1 ] = Cy;
								else
									AddIntersection( Cx, Cy, Bx, By, BCPerpDist2, true );
									AddIntersection( Cx, Cy, Ax, Ay, ACPerpDist2 );
								end
								if ( LastExitPoint ) then -- Final split points between C and A
									AddSplit( Points[ 1 ], Points[ 2 ], true );
								end

								-- Draw tris between convex polygon vertices
								for Index = #Points, 6, -2 do
									Overlay.TextureAdd( self, "ARTWORK", R, G, B,
										Points[ 1 ] + 0.5, Points[ 2 ] + 0.5, Points[ Index - 3 ] + 0.5, Points[ Index - 2 ] + 0.5, Points[ Index - 1 ] + 0.5, Points[ Index ] + 0.5 );
								end
							end

							if ( #Points == 0 ) then -- No intersections
								-- Check if the center is in the triangle
								Dot00, Dot01 = ACx * ACx + ACy * ACy, ACx * BCx + ACy * BCy;
								Dot02 = ACx * -Cx - ACy * Cy;
								Dot11, Dot12 = BCx * BCx + BCy * BCy, BCx * -Cx - BCy * Cy;

								Denominator = Dot00 * Dot11 - Dot01 * Dot01;
								if ( Denominator ~= 0 ) then -- Points aren't co-linear
									U, V = ( Dot11 * Dot02 - Dot01 * Dot12 ) / Denominator,
										( Dot00 * Dot12 - Dot01 * Dot02 ) / Denominator;

									if ( U > 0 and V > 0 and U + V < 1 ) then -- Entire minimap is contained
										for Index = 1, 4 do
											Texture = Overlay.TextureCreate( self, "ARTWORK", R, G, B );
											Left, Top = Index == 2 or Index == 3, Index <= 2;
											Texture:SetPoint( "LEFT", self, Left and "LEFT" or "CENTER" );
											Texture:SetPoint( "RIGHT", self, Left and "CENTER" or "RIGHT" );
											Texture:SetPoint( "TOP", self, Top and "TOP" or "CENTER" );
											Texture:SetPoint( "BOTTOM", self, Top and "CENTER" or "BOTTOM" );
											if ( Quadrants[ Index ] ) then -- Rounded
												Texture:SetTexture( [[Interface\CHARACTERFRAME\TempPortraitAlphaMask]] );
												Texture:SetTexCoord( Left and 0 or 0.5, Left and 0.5 or 1, Top and 0 or 0.5, Top and 0.5 or 1 );
											else -- Square
												Texture:SetTexture( [[Interface\Buttons\WHITE8X8]] );
												Texture:SetTexCoord( 0, 1, 0, 1 );
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local MinimapShapes = { -- Credit to MobileMinimapButtons as seen at <http://www.wowwiki.com/GetMinimapShape>
		-- [ Shape ] = { Q1, Q2, Q3, Q4 }; where true = rounded and false = squared
		[ "ROUND" ]                 = {  true,  true,  true,  true };
		[ "SQUARE" ]                = { false, false, false, false };
		[ "CORNER-TOPRIGHT" ]       = {  true, false, false, false };
		[ "CORNER-TOPLEFT" ]        = { false,  true, false, false };
		[ "CORNER-BOTTOMLEFT" ]     = { false, false,  true, false };
		[ "CORNER-BOTTOMRIGHT" ]    = { false, false, false,  true };
		[ "SIDE-TOP" ]              = {  true,  true, false, false };
		[ "SIDE-LEFT" ]             = { false,  true,  true, false };
		[ "SIDE-BOTTOM" ]           = { false, false,  true,  true };
		[ "SIDE-RIGHT" ]            = {  true, false, false,  true };
		[ "TRICORNER-BOTTOMLEFT" ]  = { false,  true,  true,  true };
		[ "TRICORNER-BOTTOMRIGHT" ] = {  true, false,  true,  true };
		[ "TRICORNER-TOPRIGHT" ]    = {  true,  true, false,  true };
		[ "TRICORNER-TOPLEFT" ]     = {  true,  true,  true, false };
	};
	local LastQuadrants, UpdateRangeRing;
	local RadiiInside = { 150, 120, 90, 60, 40, 25 };
	local RadiiOutside = { 233 + 1 / 3, 200, 166 + 2 / 3, 133 + 1 / 3, 100, 66 + 2 / 3 };
	local Cos, Sin = math.cos, math.sin;
	--- Draws paths on the minimap from a given player position and direction.
	function NS:Paint ( Map, NewX, NewY, NewFacing )
		Overlay.TextureRemoveAll( self );

		Quadrants = MinimapShapes[ GetMinimapShape and GetMinimapShape() ] or MinimapShapes[ "ROUND" ];
		if ( Quadrants ~= LastQuadrants ) then -- Minimap shape changed
			LastQuadrants = Quadrants;
			UpdateRangeRing = true;

			-- Cache split points
			wipe( SplitPoints );
			for Quadrant = 1, 4 do
				if ( Quadrants[ Quadrant ] ) then -- Round
					if ( not Quadrants[ ( Quadrant - 2 ) % 4 + 1 ] ) then -- Transition from previous
						local Angle = ( Quadrant - 1 ) * math.pi / 2;
						-- Round coords to exactly 0 or 0.5; Necessary for later comparisons
						SplitPoints[ #SplitPoints + 1 ] = floor( Cos( Angle ) + 0.5 ) * 0.5;
						SplitPoints[ #SplitPoints + 1 ] = floor( Sin( Angle ) + 0.5 ) * -0.5;
					end
					if ( not Quadrants[ Quadrant % 4 + 1 ] ) then -- Transition to next
						local Angle = Quadrant * math.pi / 2;
						SplitPoints[ #SplitPoints + 1 ] = floor( Cos( Angle ) + 0.5 ) * 0.5;
						SplitPoints[ #SplitPoints + 1 ] = floor( Sin( Angle ) + 0.5 ) * -0.5;
					end
				else -- Square
					local Left, Top = Quadrant == 2 or Quadrant == 3, Quadrant <= 2;
					SplitPoints[ #SplitPoints + 1 ] = Left and -0.5 or 0.5;
					SplitPoints[ #SplitPoints + 1 ] = Top and -0.5 or 0.5;
				end
			end
		end

		if ( not Radius ) then -- Minimap radius changed
			Radius = ( IsInside and RadiiInside or RadiiOutside )[ Minimap:GetZoom() + 1 ];
			UpdateRangeRing = true;
		end
		if ( Overlay.Options.ModulesExtra[ "Minimap" ].RangeRing ) then
			if ( UpdateRangeRing ) then -- Re-fit ring quadrants to minimap shape and size
				UpdateRangeRing = nil;
				local RingRadius = Radius / Overlay.DetectionRadius / 2;
				local Min, Max = 0.5 - RingRadius, 0.5 + RingRadius;

				for Index = 1, 4 do
					local Texture = self.RangeRing[ Index ];
					if ( Quadrants[ Index ] and Radius < Overlay.DetectionRadius ) then -- Round and too large to fit
						Texture:Hide();
					else
						local Left, Top = Index == 2 or Index == 3, Index <= 2;
						Texture:SetTexCoord( Left and Min or 0.5, Left and 0.5 or Max, Top and Min or 0.5, Top and 0.5 or Max );
						Texture:Show();
					end
				end
			end
			self.RangeRing:Show();
		end

		local Side = Radius * 2;
		Width, Height = Overlay.GetMapSize( Map );
		Width, Height = Width / Side, Height / Side; -- Simplifies data decompression
		X, Y = NewX / Side, NewY / Side;
		Facing = NewFacing;

		if ( RotateMinimap ) then
			FacingSin, FacingCos = Sin( Facing ), Cos( Facing );
		end

		Overlay.ApplyZone( self, Map, PaintPath );
	end
end




--- Force a repaint when the minimap swaps between indoor and outdoor zoom.
function NS:MINIMAP_UPDATE_ZOOM ()
	local Zoom = Minimap:GetZoom();
	if ( GetCVar( "minimapZoom" ) == GetCVar( "minimapInsideZoom" ) ) then -- Indeterminate case
		Minimap:SetZoom( Zoom > 0 and Zoom - 1 or Zoom + 1 ); -- Any change to make the cvars unequal
	end
	IsInside = Minimap:GetZoom() == GetCVar( "minimapInsideZoom" ) + 0;
	Minimap:SetZoom( Zoom );
	UpdateForce, Radius = true;

	-- Update indoor alpha value
	if ( self.Alpha ) then
		self:SetAlpha( self.Alpha );
	end
end
--- Force a repaint and cache map size when changing zones.
function NS:ZONE_CHANGED_NEW_AREA ()
	UpdateForce = true;
	if ( not WorldMapFrame:IsVisible() ) then
		SetMapToCurrentZone();
	end
end
do
	local GetCurrentMapAreaID = GetCurrentMapAreaID;
	local MapLast;
	--- Force a repaint if world map swaps back to the current zone (making player coordinates available).
	function NS:WORLD_MAP_UPDATE ()
		local Map = GetCurrentMapAreaID();
		if ( MapLast ~= Map ) then -- Changed zones
			MapLast = Map;

			if ( Map == Overlay.GetMapID( GetRealZoneText() ) ) then -- Now showing current zone
				UpdateForce = true;
			end
		end
	end
end
--- Force a repaint when minimap gets shown or module gets enabled.
function NS:OnShow ()
	UpdateForce = true;
end
do
	local GetPlayerMapPosition = GetPlayerMapPosition;
	local GetRealZoneText = GetRealZoneText;
	local GetCVarBool = GetCVarBool;
	local GetPlayerFacing = GetPlayerFacing;
	local GetCurrentMapAreaID = GetCurrentMapAreaID;
	local UpdateNext = 0;
	local LastX, LastY, LastFacing;
	--- Throttles repaints based on a timer, and only repaints if the minimap view changes.
	function NS:OnUpdate ( Elapsed )
		UpdateNext = UpdateNext - Elapsed;
		if ( UpdateForce or UpdateNext <= 0 ) then
			UpdateNext = UpdateRate;

			local Map = Overlay.GetMapID( GetRealZoneText() );
			local X, Y = GetPlayerMapPosition( "player" );
			if ( not Map
				or ( X == 0 and Y == 0 )
				or X < 0 or X > 1 or Y < 0 or Y > 1
				or Map ~= GetCurrentMapAreaID() -- Coordinates will be for wrong map
			) then
				UpdateForce = nil;
				self.RangeRing:Hide();
				Overlay.TextureRemoveAll( self );
				return;
			end

			RotateMinimap = GetCVarBool( "rotateMinimap" );
			UpdateRate = self[ RotateMinimap and "UpdateRateRotating" or "UpdateRateDefault" ];

			local Facing = RotateMinimap and GetPlayerFacing() or 0;
			local Width, Height = Overlay.GetMapSize( Map );
			X, Y = X * Width, Y * Height;

			if ( UpdateForce or Facing ~= LastFacing or ( X - LastX ) ^ 2 + ( Y - LastY ) ^ 2 >= self.UpdateDistance ) then
				UpdateForce = nil;
				LastX, LastY = X, Y;
				LastFacing = Facing;

				return self:Paint( Map, X, Y, Facing );
			end
		end
	end
end




do
	local Backup = NS.SetAlpha;
	--- Fades overlay when indoors.
	function NS:SetAlpha ( Alpha, ... )
		return Backup( self, IsInside and Alpha * NS.InsideAlphaMultiplier or Alpha, ... );
	end
end
--- Reparents this canvas to Frame.
-- @return True if set successfully.
function NS:SetMinimapFrame ( Frame )
	if ( self.ScrollFrame and self.ScrollFrame:GetParent() ~= Frame ) then
		self.ScrollFrame:SetParent( Frame );
		self.ScrollFrame:SetAllPoints();
		UpdateForce, Radius = true;
		return true;
	end
end

--- Force a repaint if shown paths change.
-- @param Map  AreaID that changed, or nil if all zones must update.
function NS:OnMapUpdate ( Map )
	if ( not Map or Map == Overlay.GetMapID( GetRealZoneText() ) ) then
		UpdateForce = true;
	end
end
--- Shows the canvas when enabled.
function NS:OnEnable ()
	self.ScrollFrame:Show();
	self:RegisterEvent( "WORLD_MAP_UPDATE" );
	self:RegisterEvent( "ZONE_CHANGED_NEW_AREA" );
end
--- Hides the canvas when disabled.
function NS:OnDisable ()
	self.ScrollFrame:Hide();
	Overlay.TextureRemoveAll( self );
	self:UnregisterEvent( "WORLD_MAP_UPDATE" );
	self:UnregisterEvent( "ZONE_CHANGED_NEW_AREA" );
end
do
	--- Hook to force a repaint when minimap zoom changes.
	local function SetZoom ( self, Zoom, ... )
		UpdateForce, Radius = true;
	end
	--- Initializes the canvas after its dependencies load.
	function NS:OnLoad ()
		self.ScrollFrame = CreateFrame( "ScrollFrame" );
		self.ScrollFrame:Hide();
		self.ScrollFrame:SetScrollChild( self );

		self:SetAllPoints();
		self:SetScript( "OnShow", self.OnShow );
		self:SetScript( "OnUpdate", self.OnUpdate );
		self:SetScript( "OnEvent", Overlay.Modules.OnEvent );
		self:RegisterEvent( "MINIMAP_UPDATE_ZOOM" );
		hooksecurefunc( Minimap, "SetZoom", SetZoom );

		local RangeRing = CreateFrame( "Frame", nil, self.ScrollFrame ); -- [ Quadrant ] = Texture;
		self.RangeRing = RangeRing;
		-- Setup the range ring's textures
		RangeRing:SetAllPoints();
		RangeRing:SetAlpha( 0.8 );
		local Color = NORMAL_FONT_COLOR;
		for Index = 1, 4 do
			local Texture = RangeRing:CreateTexture();
			RangeRing[ Index ] = Texture;

			local Left, Top = Index == 2 or Index == 3, Index <= 2;
			Texture:SetPoint( "LEFT", RangeRing, Left and "LEFT" or "CENTER" );
			Texture:SetPoint( "RIGHT", RangeRing, Left and "CENTER" or "RIGHT" );
			Texture:SetPoint( "TOP", RangeRing, Top and "TOP" or "CENTER" );
			Texture:SetPoint( "BOTTOM", RangeRing, Top and "CENTER" or "BOTTOM" );
			Texture:SetTexture( [[SPELLS\CIRCLE]] );
			Texture:SetBlendMode( "ADD" );
			Texture:SetVertexColor( Color.r, Color.g, Color.b );
		end

		self:SetMinimapFrame( Minimap );
	end
end
--- Clears all methods and scripts to be garbage collected.
function NS:OnUnload ()
	self:SetScript( "OnShow", nil );
	self:SetScript( "OnUpdate", nil );
	self:SetScript( "OnEvent", nil );
	self:UnregisterEvent( "MINIMAP_UPDATE_ZOOM" );
end
--- Clears most module data to be garbage collected.
function NS:OnUnregister ()
	self.Paint, self.OnShow, self.OnUpdate = nil;
	self.MINIMAP_UPDATE_ZOOM = nil;
	self.ZONE_CHANGED_NEW_AREA = nil;
	self.WORLD_MAP_UPDATE = nil;
end




--- Enables the minimap range ring.
-- @return True if changed.
function NS.RangeRingSetEnabled ( Enable )
	if ( Enable ~= Overlay.Options.ModulesExtra[ "Minimap" ].RangeRing ) then
		Overlay.Options.ModulesExtra[ "Minimap" ].RangeRing = Enable;

		NS.Config.RangeRing:SetChecked( Enable );

		if ( Enable ) then
			UpdateForce = true;
		elseif ( NS.Loaded ) then
			NS.RangeRing:Hide();
		end
		return true;
	end
end
--- Synchronizes custom settings to options table.
function NS:OnSynchronize ( OptionsExtra )
	self.RangeRingSetEnabled( OptionsExtra.RangeRing ~= false );
end




Overlay.Modules.Register( "Minimap", NS, Overlay.L.MODULE_MINIMAP );

local Config = NS.Config;
local Checkbox = CreateFrame( "CheckButton", "$parentRangeRing", Config, "InterfaceOptionsCheckButtonTemplate" );
Config.RangeRing = Checkbox;
--- Toggles the range ring when clicked.
function Checkbox.setFunc ( Enable )
	NS.RangeRingSetEnabled( Enable == "1" );
end

Checkbox:SetPoint( "TOPLEFT", Config.Enabled, "BOTTOMLEFT" );
local Label = _G[ Checkbox:GetName().."Text" ];
Label:SetPoint( "RIGHT", Config, "RIGHT", -6, 0 );
Label:SetJustifyH( "LEFT" );
Label:SetFormattedText( Overlay.L.MODULE_RANGERING_FORMAT, Overlay.DetectionRadius );
Checkbox:SetHitRectInsets( 4, 4 - Label:GetStringWidth(), 4, 4 );
Checkbox.SetEnabled = Overlay.Config.ModuleCheckboxSetEnabled;
Checkbox.tooltipText = Overlay.L.MODULE_RANGERING_DESC;
Config:AddControl( Checkbox );

Config:SetHeight( Config:GetHeight() + Checkbox:GetHeight() );