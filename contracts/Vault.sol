// SPDX-License-Identifier: UNLICENSED
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/extensions/AccessControlEnumerable.sol";

contract Vault is Ownable, AccessControlEnumerable {
    using SafeERC20 for IERC20; // Chua bt su dung

    IERC20 private token;
    uint256 public maxWithdrawAmount;
    bool public withdrawEnable;
    bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");

    constructor(address initOwner)
            Ownable(initOwner)
    {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    //set token
    function setToken(IERC20 _token) public onlyOwner {
        token = _token;
    }

    //set max withdraw
    function setMaxWithdrawAmount(uint256 _maxAmount) public onlyOwner {
        maxWithdrawAmount = _maxAmount;
    }

    //set withdraw enable
    function setWithdrawEnable(bool _isEnable) public onlyOwner {
        withdrawEnable = _isEnable;
    }


    function withdraw(address _to, uint256 _amount) external onlyWithdrawer {
        token.transfer(_to, _amount);
    }

    function deposit(uint256 _amout) external {
        SafeERC20.safeTransferFrom(token, msg.sender, address(this), _amout);
    }

    // check role withdraw
    modifier onlyWithdrawer() {
        require(owner() == _msgSender() || hasRole("WITHDRAWER_ROLE", _msgSender()), "Caller is not a withdrawer");
        _;
    }
}