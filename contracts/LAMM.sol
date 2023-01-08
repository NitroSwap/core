// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import {ERC4626} from "solmate/mixins/ERC4626.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";
import {FixedPointMathLib} from "solmate/utils/FixedPointMathLib.sol";

error InsufficientFundsError();

/**
 * @title LAMM
 * @author Alberto Cevallos
 *
 * The Loan Automated Market Maker (LAMM) is a smart contract that
 * provides constant function liquidity for undercollateralized loans.
 * In a LAMM, users can deposit margin and borrow leverage multiple
 * times higher than their collateral value.
 */
contract LAMM is ERC4626 {
    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/
    ERC20 public immutable trading;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(
        ERC20 _base,
        ERC20 _trading,
        string memory _name,
        string memory _symbol
    ) ERC4626(_base, _name, _symbol) {
        trading = _trading;
    }

    /*//////////////////////////////////////////////////////////////
                              TRADING LOGIC
    //////////////////////////////////////////////////////////////*/

    function increasePosition() public {}

    function decreasePosition() public {}

    /*//////////////////////////////////////////////////////////////
                              VAULT LOGIC
    //////////////////////////////////////////////////////////////*/
    /*//////////////////////////////////////////////////////////////
                          INTERNAL HOOKS LOGIC
    //////////////////////////////////////////////////////////////*/

    function beforeWithdraw(uint256 assets, uint256 shares)
        internal
        virtual
        override
    {}

    function afterDeposit(uint256 assets, uint256 shares)
        internal
        virtual
        override
    {}
}
