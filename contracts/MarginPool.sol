// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";
import {SafeCastLib} from "solmate/utils/SafeCastLib.sol";
import {FixedPointMathLib} from "solmate/utils/FixedPointMathLib.sol";

contract MarginPool is ERC20 {
    using SafeCastLib for *;
    using SafeTransferLib for ERC20;
    using FixedPointMathLib for uint256;

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/
    address public immutable market;
    address public immutable base;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(
        address _market,
        address _base,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
    ) ERC20(_name, _symbol, _decimals) {
        market = _market;
        base = _base;
    }

    /*//////////////////////////////////////////////////////////////
                              TRADING LOGIC
    //////////////////////////////////////////////////////////////*/

    function increasePosition() public {}

    function decreasePosition() public {}

    /*//////////////////////////////////////////////////////////////
                              VAULT LOGIC
    //////////////////////////////////////////////////////////////*/
}
