private ["_unitGroup", "_vehicle", "_lastAggro","_inNoAggroArea","_inArea","_result"];

_unitGroup = _this select 0;
_vehicle = _this select 1;

if (A3XAI_UAVDetectOnly) then {
	_lastAggro = _vehicle getVariable "AggroTime";
	if (isNil "AggroTime") then {
		_lastAggro = diag_tickTime - 180;
		_vehicle setVariable ["AggroTime",0];
	};

	if ((diag_tickTime - _lastAggro) > 180) then {
		if ((combatMode _unitGroup) isEqualTo "YELLOW") then {
			[_unitGroup,"IgnoreEnemies"] call A3XAI_forceBehavior;
			if (A3XAI_debugLevel > 1) then {diag_log format ["A3XAI Debug: Reset Group %1 %2 UAV to non-hostile mode.",_unitGroup,(typeOf _vehicle)]};
		};
	};
} else {
	_inArea = _vehicle call A3XAI_checkInNoAggroArea;
	_result = [_unitGroup,_inArea] call A3XAI_noAggroAreaToggle;
};

true
