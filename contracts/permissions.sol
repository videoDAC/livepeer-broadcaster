// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

contract permissions {

    bool canAccess;

    function grantAccess() public {
        canAccess = true;
    }

    function revokeAccess() public {
        canAccess = false;
    }

    function canAccess(address user) external view returns (bool) {
        return canAccess;
    }

}
