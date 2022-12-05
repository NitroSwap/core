// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.17;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {SafeTransferLib} from "solmate/utils/SafeTransferLib.sol";
import {SafeCastLib} from "solmate/utils/SafeCastLib.sol";
import {FixedPointMathLib} from "solmate/utils/FixedPointMathLib.sol";

error InsufficientFundsError();

/**
 * @title MarginPool
 * @author Alberto Cevallos
 *
 * MarginPool is a contract for decentralized margin trading on Ethereum.
 * Lenders are able to deposit and withdraw a base asset from the pool.
 * Traders can borrow this base asset and trade spot markets with leverage.
 * All swaps are done using the best price found through Cowswap's router
 * (eg. Uniswap V2, Curve V2).
 */
contract MarginPool is ERC20 {
    using SafeCastLib for *;

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
    /**
     * Returns the balance of base assets in the contract in addition
     * to any tokens lent out in unrealized positions.
     */
    function balance() public view virtual returns (uint256) {
        return ERC20(base).balanceOf(address(this));
    }

    /**
     * Deposits the base asset into the vault, and mints a corresponding
     * number of shares to the user, pro rata.
     *
     * @param amount    Number of tokens of the base asset being deposited
     */
    function deposit(uint256 amount) public {
        uint256 pool = balance();
        uint256 beforeBal = ERC20(base).balanceOf(address(this));
        SafeTransferLib.safeTransferFrom(
            ERC20(base),
            msg.sender,
            address(this),
            amount
        );
        uint256 afterBal = ERC20(base).balanceOf(address(this));
        amount = afterBal - beforeBal;
        uint256 shares = 0;
        if (totalSupply == 0) {
            shares = amount;
        } else {
            shares = (amount * totalSupply) / pool;
        }
        _mint(msg.sender, shares);
    }

    /**
     * Withdraws a given number of base asset tokens from the vault
     * by redeeming shares owned by the caller.
     *
     * @param shares    Number of share being redeemed
     */
    function withdraw(uint256 shares) public {
        uint256 r = (balance() * shares) / totalSupply;
        _burn(msg.sender, shares);

        // check balance
        uint256 b = ERC20(base).balanceOf(address(this));
        if (b < r) revert InsufficientFundsError();
        SafeTransferLib.safeTransfer(ERC20(base), msg.sender, r);
    }
}
