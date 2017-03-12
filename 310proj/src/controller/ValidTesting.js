"use strict";
var validkeys = ["rooms_fullname", "rooms_shortname", "rooms_number", "room_name"];
var ValidKey = (function () {
    function ValidKey() {
    }
    return ValidKey;
}());
exports.ValidKey = ValidKey;
var validkeys;
constructor();
{
    validkeys = [];
}
function isValid(key) {
    if (validkeys.includes(key)) {
        return true;
    }
    else
        return false;
}
var result = isValid("rooms");
console.log(result);
//# sourceMappingURL=ValidTesting.js.map