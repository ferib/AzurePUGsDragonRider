if (AZP == nil) then
	AZP = {};
end
if (AZP.VersionControl == nil) then
	AZP.VersionControl = {};
end
AZP.VersionControl['DragonRider'] = 27;
if (AZP.DragonRider == nil) then
	AZP.DragonRider = {};
end
local ForgottenTomes, ArcaneEssence = nil, nil;
local WhisperingShadows = 0;
local NebulousScepter = 0;
local ArcaneObelisk = 0;
local v6, v7 = 30, 32;
local NebulousSorcery = false;
local v9 = {2022,2023,2024,2025,2107,2112,2151,2133};
local EnigmaticTotem = nil;
local MysticScript = nil;
local ShadowyAegis = nil;
AZP.DragonRider.OnLoad = function(v28)
	if (VigorFrameScale == nil) then
		VigorFrameScale = 1;
	end
	ForgottenTomes = CreateFrame("Frame", nil, UIParent);
	ForgottenTomes:RegisterEvent("VARIABLES_LOADED");
	ForgottenTomes:RegisterEvent("ADDON_LOADED");
	ForgottenTomes:RegisterEvent("ZONE_CHANGED");
	ForgottenTomes:SetScript("OnEvent", function(...)
		AZP.DragonRider:OnEvent(...);
	end);
end;
AZP.DragonRider.BuildVigorFrame = function(v29)
	ArcaneEssence = CreateFrame("FRAME", nil, UIParent);
	ArcaneEssence:SetSize(242, 100);
	ArcaneEssence:SetFrameStrata("MEDIUM");
	ArcaneEssence:SetFrameLevel(8);
	ArcaneEssence:RegisterForDrag("LeftButton");
	ArcaneEssence:SetMovable(true);
	ArcaneEssence:EnableMouse(true);
	ArcaneEssence:SetScript("OnDragStart", ArcaneEssence.StartMoving);
	ArcaneEssence:SetScript("OnDragStop", function()
		AZP.DragonRider:SavePosition();
		ArcaneEssence:StopMovingOrSizing();
	end);
	ArcaneEssence.VigorGemsSlots = {};
	NebulousScepter = AZP.DragonRider:GetMaxVigor();
	WhisperingShadows = NebulousScepter;
	for v82 = 1, 6 do
		ArcaneEssence.VigorGemsSlots[v82] = CreateFrame("StatusBar", nil, ArcaneEssence, "UIWidgetFillUpFrameTemplate");
		ArcaneEssence.VigorGemsSlots[v82]:SetSize(v6, v7);
		if (v82 == 1) then
			ArcaneEssence.VigorGemsSlots[v82]:SetPoint("TOPLEFT", ArcaneEssence, "TOPLEFT", 0, -35);
		else
			ArcaneEssence.VigorGemsSlots[v82]:SetPoint("LEFT", ArcaneEssence.VigorGemsSlots[v82 - 1], "RIGHT", 12, 0);
		end
		ArcaneEssence.VigorGemsSlots[v82].BG:SetAtlas("dragonriding_vigor_background");
		ArcaneEssence.VigorGemsSlots[v82].BG:SetSize(v6, v7);
		ArcaneEssence.VigorGemsSlots[v82].Bar:SetStatusBarTexture("dragonriding_vigor_fill");
		ArcaneEssence.VigorGemsSlots[v82].Bar:SetSize(v6, v7);
		ArcaneEssence.VigorGemsSlots[v82].Bar:SetMinMaxValues(0, 100);
		ArcaneEssence.VigorGemsSlots[v82].Spark:SetAtlas("dragonriding_vigor_spark");
		ArcaneEssence.VigorGemsSlots[v82].Spark:SetSize(v6, v7 / 4);
		ArcaneEssence.VigorGemsSlots[v82].Spark:SetPoint("CENTER", ArcaneEssence.VigorGemsSlots[v82].Bar:GetStatusBarTexture(), "TOP", 0, 0);
		ArcaneEssence.VigorGemsSlots[v82].Spark:Hide();
		ArcaneEssence.VigorGemsSlots[v82].SparkMask:SetAtlas("dragonriding_vigor_mask");
		ArcaneEssence.VigorGemsSlots[v82].SparkMask:SetSize(v6 * 2, v7 * 2);
		ArcaneEssence.VigorGemsSlots[v82].Frame:SetAtlas("dragonriding_vigor_frame");
		ArcaneEssence.VigorGemsSlots[v82].Frame:SetSize(v6 * 2, v7 * 2);
		if (v82 > NebulousScepter) then
			ArcaneEssence.VigorGemsSlots[v82]:Hide();
		end
	end
	ArcaneEssence.LeftWing = ArcaneEssence:CreateTexture(nil, "BACKGROUND");
	ArcaneEssence.LeftWing:SetAtlas("dragonriding_vigor_decor");
	ArcaneEssence.LeftWing:SetTexCoord(1, 0, 0, 1);
	ArcaneEssence.LeftWing:SetSize(46, 59);
	ArcaneEssence.LeftWing:SetPoint("RIGHT", ArcaneEssence, "LEFT", 14, -15);
	ArcaneEssence.RightWing = ArcaneEssence:CreateTexture(nil, "BACKGROUND");
	ArcaneEssence.RightWing:SetAtlas("dragonriding_vigor_decor");
	ArcaneEssence.RightWing:SetSize(46, 59);
	ArcaneEssence.RightWing:SetPoint("LEFT", ArcaneEssence, "RIGHT", 0, 0);
	ArcaneEssence.RightWing:SetPoint("LEFT", ArcaneEssence.VigorGemsSlots[NebulousScepter], "RIGHT", -13, -15);
	if (HideSideWings == true) then
		ArcaneEssence.LeftWing:Hide();
		ArcaneEssence.RightWing:Hide();
	end
	AZP.DragonRider:Hide();
	AZP.DragonRider:ZoneChanged();
	AZP.DragonRider:LockUnlockPosition();
end;
AZP.DragonRider.BuildOptionsPanel = function(v33)
	ShadowyAegis = CreateFrame("FRAME");
	ShadowyAegis:SetSize(500, 500);
	ShadowyAegis.name = "AzerPUG's Dragon Rider";
	ShadowyAegis.parent = nil;
	InterfaceOptions_AddCategory(ShadowyAegis);
	ShadowyAegis.title = ShadowyAegis:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge");
	ShadowyAegis.title:SetSize(ShadowyAegis:GetWidth(), 50);
	ShadowyAegis.title:SetPoint("TOP");
	ShadowyAegis.title:SetText("AzerPUG's Dragon Rider");
	ShadowyAegis.autoHideText = ShadowyAegis:CreateFontString("OpenOptionsFrameText", "ARTWORK", "GameFontNormalLarge");
	ShadowyAegis.autoHideText:SetPoint("TOPLEFT", 30, -50);
	ShadowyAegis.autoHideText:SetJustifyH("LEFT");
	ShadowyAegis.autoHideText:SetText("Hide when maxed.");
	ShadowyAegis.autoHideCheckbox = CreateFrame("CheckButton", nil, ShadowyAegis, "ChatConfigCheckButtonTemplate");
	ShadowyAegis.autoHideCheckbox:SetSize(20, 20);
	ShadowyAegis.autoHideCheckbox:SetPoint("RIGHT", ShadowyAegis.autoHideText, "LEFT", 0, 0);
	ShadowyAegis.autoHideCheckbox:SetHitRectInsets(0, 0, 0, 0);
	ShadowyAegis.autoHideCheckbox:SetChecked(VigorFrameAutoHide);
	ShadowyAegis.autoHideCheckbox:SetScript("OnClick", function()
		VigorFrameAutoHide = ShadowyAegis.autoHideCheckbox:GetChecked();
	end);
	ShadowyAegis.HideWingsText = ShadowyAegis:CreateFontString("OpenOptionsFrameText", "ARTWORK", "GameFontNormalLarge");
	ShadowyAegis.HideWingsText:SetPoint("TOPLEFT", 30, -75);
	ShadowyAegis.HideWingsText:SetJustifyH("LEFT");
	ShadowyAegis.HideWingsText:SetText("Hide side wings.");
	ShadowyAegis.WingsHideCheckbox = CreateFrame("CheckButton", nil, ShadowyAegis, "ChatConfigCheckButtonTemplate");
	ShadowyAegis.WingsHideCheckbox:SetSize(20, 20);
	ShadowyAegis.WingsHideCheckbox:SetPoint("RIGHT", ShadowyAegis.HideWingsText, "LEFT", 0, 0);
	ShadowyAegis.WingsHideCheckbox:SetHitRectInsets(0, 0, 0, 0);
	ShadowyAegis.WingsHideCheckbox:SetChecked(HideSideWings);
	ShadowyAegis.WingsHideCheckbox:SetScript("OnClick", function()
		if (ShadowyAegis.WingsHideCheckbox:GetChecked() == true) then
			HideSideWings = true;
			ArcaneEssence.LeftWing:Hide();
			ArcaneEssence.RightWing:Hide();
		else
			HideSideWings = false;
			ArcaneEssence.LeftWing:Show();
			ArcaneEssence.RightWing:Show();
		end
	end);
	ShadowyAegis.autoHideOutOfDragonIslesText = ShadowyAegis:CreateFontString("OpenOptionsFrameText", "ARTWORK", "GameFontNormalLarge");
	ShadowyAegis.autoHideOutOfDragonIslesText:SetPoint("TOPLEFT", 30, -100);
	ShadowyAegis.autoHideOutOfDragonIslesText:SetJustifyH("LEFT");
	ShadowyAegis.autoHideOutOfDragonIslesText:SetText("Automatically Hide outside of Dragon Isles.");
	ShadowyAegis.autoHideOutOfDragonIslesCheckbox = CreateFrame("CheckButton", nil, ShadowyAegis, "ChatConfigCheckButtonTemplate");
	ShadowyAegis.autoHideOutOfDragonIslesCheckbox:SetSize(20, 20);
	ShadowyAegis.autoHideOutOfDragonIslesCheckbox:SetPoint("RIGHT", ShadowyAegis.autoHideOutOfDragonIslesText, "LEFT", 0, 0);
	ShadowyAegis.autoHideOutOfDragonIslesCheckbox:SetHitRectInsets(0, 0, 0, 0);
	ShadowyAegis.autoHideOutOfDragonIslesCheckbox:SetChecked(VigorFrameAutoHideInWrongZone);
	ShadowyAegis.autoHideOutOfDragonIslesCheckbox:SetScript("OnClick", function()
		VigorFrameAutoHideInWrongZone = ShadowyAegis.autoHideOutOfDragonIslesCheckbox:GetChecked();
		AZP.DragonRider:ZoneChanged();
	end);
	ShadowyAegis.hideGlyphsText = ShadowyAegis:CreateFontString("OpenOptionsFrameText", "ARTWORK", "GameFontNormalLarge");
	ShadowyAegis.hideGlyphsText:SetPoint("TOPLEFT", 30, -125);
	ShadowyAegis.hideGlyphsText:SetJustifyH("LEFT");
	ShadowyAegis.hideGlyphsText:SetText("Hide Glyph location Pins");
	ShadowyAegis.hideGlyphsCheckbox = CreateFrame("CheckButton", nil, ShadowyAegis, "ChatConfigCheckButtonTemplate");
	ShadowyAegis.hideGlyphsCheckbox:SetSize(20, 20);
	ShadowyAegis.hideGlyphsCheckbox:SetPoint("RIGHT", ShadowyAegis.hideGlyphsText, "LEFT", 0, 0);
	ShadowyAegis.hideGlyphsCheckbox:SetHitRectInsets(0, 0, 0, 0);
	ShadowyAegis.hideGlyphsCheckbox:SetChecked(AZPHideGlyphs);
	ShadowyAegis.hideGlyphsCheckbox:SetScript("OnClick", function()
		AZPHideGlyphs = ShadowyAegis.hideGlyphsCheckbox:GetChecked();
		AZP.DragonRider:ZoneChanged();
	end);
	ShadowyAegis.hideRostrumsText = ShadowyAegis:CreateFontString("OpenOptionsFrameText", "ARTWORK", "GameFontNormalLarge");
	ShadowyAegis.hideRostrumsText:SetPoint("TOPLEFT", 30, -150);
	ShadowyAegis.hideRostrumsText:SetJustifyH("LEFT");
	ShadowyAegis.hideRostrumsText:SetText("Hide rostrum of transformation location Pins");
	ShadowyAegis.hideRostrumsCheckbox = CreateFrame("CheckButton", nil, ShadowyAegis, "ChatConfigCheckButtonTemplate");
	ShadowyAegis.hideRostrumsCheckbox:SetSize(20, 20);
	ShadowyAegis.hideRostrumsCheckbox:SetPoint("RIGHT", ShadowyAegis.hideRostrumsText, "LEFT", 0, 0);
	ShadowyAegis.hideRostrumsCheckbox:SetHitRectInsets(0, 0, 0, 0);
	ShadowyAegis.hideRostrumsCheckbox:SetChecked(AZPHideRostrums);
	ShadowyAegis.hideRostrumsCheckbox:SetScript("OnClick", function()
		AZPHideRostrums = ShadowyAegis.hideRostrumsCheckbox:GetChecked();
		AZP.DragonRider:ZoneChanged();
	end);
	ShadowyAegis.lockPositionText = ShadowyAegis:CreateFontString("OpenOptionsFrameText", "ARTWORK", "GameFontNormalLarge");
	ShadowyAegis.lockPositionText:SetPoint("TOPLEFT", 30, -175);
	ShadowyAegis.lockPositionText:SetJustifyH("LEFT");
	ShadowyAegis.lockPositionText:SetText("Lock Position");
	ShadowyAegis.lockPositionCheckbox = CreateFrame("CheckButton", nil, ShadowyAegis, "ChatConfigCheckButtonTemplate");
	ShadowyAegis.lockPositionCheckbox:SetSize(20, 20);
	ShadowyAegis.lockPositionCheckbox:SetPoint("RIGHT", ShadowyAegis.lockPositionText, "LEFT", 0, 0);
	ShadowyAegis.lockPositionCheckbox:SetHitRectInsets(0, 0, 0, 0);
	ShadowyAegis.lockPositionCheckbox:SetChecked(AZPLockPosition);
	ShadowyAegis.lockPositionCheckbox:SetScript("OnClick", function()
		AZP.DragonRider:LockUnlockPosition();
	end);
	ShadowyAegis.VigorFrameScaleText = ShadowyAegis:CreateFontString("OpenOptionsFrameText", "ARTWORK", "GameFontNormalLarge");
	ShadowyAegis.VigorFrameScaleText:SetPoint("TOPLEFT", 30, -250);
	ShadowyAegis.VigorFrameScaleText:SetJustifyH("LEFT");
	ShadowyAegis.VigorFrameScaleText:SetText("Custom Vigor Frame Scale:");
	ShadowyAegis.VigorFrameScaleSlider = CreateFrame("SLIDER", "VigorFrameScaleSlider", ShadowyAegis, "OptionsSliderTemplate");
	ShadowyAegis.VigorFrameScaleSlider:SetHeight(20);
	ShadowyAegis.VigorFrameScaleSlider:SetWidth(200);
	ShadowyAegis.VigorFrameScaleSlider:SetOrientation("HORIZONTAL");
	ShadowyAegis.VigorFrameScaleSlider:SetPoint("TOPLEFT", ShadowyAegis.VigorFrameScaleText, "BOTTOMLEFT", 0, -20);
	ShadowyAegis.VigorFrameScaleSlider:EnableMouse(true);
	ShadowyAegis.VigorFrameScaleSlider.tooltipText = "Scale for mana bars";
	VigorFrameScaleSliderLow:SetText("small");
	VigorFrameScaleSliderHigh:SetText("big");
	VigorFrameScaleSliderText:SetText("Scale");
	ShadowyAegis.VigorFrameScaleSlider:Show();
	ShadowyAegis.VigorFrameScaleSlider:SetMinMaxValues(0.5, 2);
	ShadowyAegis.VigorFrameScaleSlider:SetValueStep(0.1);
	ShadowyAegis.VigorFrameScaleSlider:SetScript("OnValueChanged", AZP.DragonRider.setScale);
end;
AZP.DragonRider.Show = function(v52, v53)
	if NebulousSorcery then
		ArcaneEssence:Show();
		for v85 = 1, v53 do
			ArcaneEssence.VigorGemsSlots[v85]:SetSize(v6, v7);
		end
		NebulousSorcery = false;
	end
end;
AZP.DragonRider.Hide = function(v54)
	if not NebulousSorcery then
		ArcaneEssence:Hide();
		NebulousSorcery = true;
	end
	local v55 = {UIWidgetPowerBarContainerFrame:GetChildren()};
	if (v55[3] ~= nil) then
		PowerBarSubChildren = {v55[3]:GetRegions()};
		for v86, v87 in ipairs(PowerBarSubChildren) do
			if (HideSideWings == true) then
				v87:SetAlpha(0);
			else
				v87:SetAlpha(1);
			end
		end
	end
end;
AZP.DragonRider.FillVigorFrame = function(v56)
	local v57 = AZP.DragonRider:GetRechargePercent();
	if (v57 == nil) then
		AZP.DragonRider:Hide();
		return;
	end
	local v58 = AZP.DragonRider:GetCurrentVigor();
	local v59, v60 = C_PlayerInfo.GetGlidingInfo();
	if (v60 == true) then
		WhisperingShadows = v58;
		AZP.DragonRider:Show(NebulousScepter);
		AZP.DragonRider:Hide();
	else
		if ((v57 < ArcaneObelisk) and (v57 ~= 0)) then
			if (WhisperingShadows < NebulousScepter) then
				WhisperingShadows = WhisperingShadows + 1;
			end
		end
		AZP.DragonRider:Show(NebulousScepter);
	end
	local v61 = WhisperingShadows + 1;
	for v84 = 1, NebulousScepter do
		if (v84 <= WhisperingShadows) then
			ArcaneEssence.VigorGemsSlots[v84].Bar:SetValue(100);
			ArcaneEssence.VigorGemsSlots[v84].Bar:SetStatusBarTexture("dragonriding_vigor_fillfull");
		elseif (v84 == v61) then
			ArcaneEssence.VigorGemsSlots[v84].Bar:SetValue(v57);
			ArcaneEssence.VigorGemsSlots[v84].Bar:SetStatusBarTexture("dragonriding_vigor_fill");
		else
			ArcaneEssence.VigorGemsSlots[v84].Bar:SetValue(0);
		end
		ArcaneEssence.VigorGemsSlots[v84].Spark:SetShown(v84 == (WhisperingShadows + 1));
	end
	if (v57 ~= 0) then
		ArcaneObelisk = v57;
	end
	if VigorFrameAutoHide then
		if (WhisperingShadows == NebulousScepter) then
			AZP.DragonRider:Hide();
		end
	end
end;
AZP.DragonRider.SavePosition = function(v62)
	local v63, v64, v65, v66, v67 = ArcaneEssence:GetPoint();
	VigorFramePosition = {v63,v64,v65,v66,v67};
end;
AZP.DragonRider.LoadPosition = function(v68)
	if (VigorFramePosition == nil) then
		ArcaneEssence:SetPoint("CENTER", 0, 0);
	else
		ArcaneEssence:SetPoint(VigorFramePosition[1], VigorFramePosition[2], VigorFramePosition[3], VigorFramePosition[4], VigorFramePosition[5]);
	end
end;
AZP.DragonRider.LockUnlockPosition = function(v69)
	if (ShadowyAegis.lockPositionCheckbox:GetChecked() == true) then
		ArcaneEssence:EnableMouse(false);
		ArcaneEssence:SetMovable(false);
		ArcaneEssence:RegisterForDrag();
		ArcaneEssence:SetScript("OnDragStart", nil);
		ArcaneEssence:SetScript("OnDragStop", nil);
		AZPLockPosition = true;
	else
		ArcaneEssence:EnableMouse(true);
		ArcaneEssence:SetMovable(true);
		ArcaneEssence:RegisterForDrag("LeftButton");
		ArcaneEssence:SetScript("OnDragStart", ArcaneEssence.StartMoving);
		ArcaneEssence:SetScript("OnDragStop", function()
			AZP.DragonRider:SavePosition();
			ArcaneEssence:StopMovingOrSizing();
		end);
		AZPLockPosition = false;
	end
end;
AZP.DragonRider.GetRechargePercent = function(v70)
	local v71 = C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo(4460);
	if (v71 == nil) then
		return nil;
	else
		return v71.fillValue;
	end
end;
AZP.DragonRider.GetMaxVigor = function(v72)
	return C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo(4460).numTotalFrames;
end;
AZP.DragonRider.GetCurrentVigor = function(v73)
	return C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo(4460).numFullFrames;
end;
AZP.DragonRider.ZoneChanged = function(v74)
	EnigmaticTotem = C_Map.GetBestMapForUnit("PLAYER");
	if not VigorFrameAutoHideInWrongZone then
		if ((MysticScript == nil) or MysticScript:IsCancelled()) then
			if (ArcaneEssence == nil) then
				AZP.DragonRider:BuildVigorFrame();
				AZP.DragonRider:LoadPosition();
			end
			MysticScript = C_Timer.NewTicker(1, function()
				AZP.DragonRider:FillVigorFrame();
			end);
		end
	end
	if (VigorFrameAutoHideInWrongZone and tContains(v9, EnigmaticTotem)) then
		if ((MysticScript == nil) or MysticScript:IsCancelled()) then
			if (ArcaneEssence == nil) then
				AZP.DragonRider:BuildVigorFrame();
				AZP.DragonRider:LoadPosition();
			end
			MysticScript = C_Timer.NewTicker(1, function()
				AZP.DragonRider:FillVigorFrame();
			end);
		end
	end
	if (VigorFrameAutoHideInWrongZone and not tContains(v9, EnigmaticTotem)) then
		if (MysticScript ~= nil) then
			MysticScript:Cancel();
		end
		if (ArcaneEssence ~= nil) then
			AZP.DragonRider:Hide();
		end
		return;
	end
end;
AZP.DragonRider.setScale = function(v75, v76)
	if (ArcaneEssence ~= nil) then
		VigorFrameScale = v76;
		ArcaneEssence:SetScale(v76);
	end
end;
AZP.DragonRider.OnEvent = function(v77, v78, v79, ...)
	if (v79 == "VARIABLES_LOADED") then
		C_Timer.After(2, function()
			if (VigorFrameAutoHideInWrongZone == nil) then
				VigorFrameAutoHideInWrongZone = true;
			end
			AZP.DragonRider:BuildOptionsPanel();
			AZP.DragonRider:ZoneChanged();
			VigorFrameScaleSlider:SetValue(VigorFrameScale);
		end);
	elseif (v79 == "ZONE_CHANGED") then
		AZP.DragonRider:ZoneChanged();
	end
end;
AZP.DragonRider:OnLoad();
