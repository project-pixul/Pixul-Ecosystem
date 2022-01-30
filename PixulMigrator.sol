// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

pragma solidity >= 0.5.0 <0.9.0;

contract SWAP_TOKEN
{
    IERC20 public tokenA;
    address public ownerA;
    uint public amountA;
    IERC20 public tokenB;
    address public ownerB;

    constructor(address _tokenA,address _ownerA,uint _amountA,address _tokenB,address _ownerB)
    {
        tokenA = IERC20(_tokenA);
        ownerA = _ownerA;
        amountA = _amountA;
        tokenB = IERC20(_tokenB);
        ownerB = _ownerB;
    }

    function SWAP() public {
        require(msg.sender == ownerA, "You do not have permission to call this function");
        require(tokenA.allowance(ownerA, address(this)) >= amountA,"you cannot transfer tokens more than your approved limit");
        require(tokenB.allowance(ownerB, address(this)) >= amountA,"you cannot transfer tokens more than your approved limit");
        token_TransferFrom(tokenA, ownerA, ownerB, amountA);
        token_TransferFrom(tokenB, ownerB, ownerA, amountA);
    }

    function token_TransferFrom(IERC20 token,address _from,address _to,uint _value) private {
        bool sent = token.transferFrom(_from, _to, _value);
        require(sent, "Token transfer failed");
    }

}