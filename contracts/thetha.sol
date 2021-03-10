//SPDX-License-Identifier:MIT
pragma solidity 0.8.1;

import "./IERC20.sol";
import "./SafeMath.sol";
import "./YBET.sol";

contract XBET is IERC20 {
    using SafeMath for uint256;

    string public name;
    string public symbol;
    uint256 public _totalsupply;
    uint256 public decimal;
    address public owner;
    TFUEL dc;

    mapping(address => uint256) private balance;
    mapping(address => mapping(address => uint256)) allowed;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _total,
        uint256 _decimal,
        address _dc
    ) {
        owner = msg.sender;
        name = _name;
        symbol = _symbol;
        _totalsupply = _total;
        decimal = _decimal;
        balance[owner] = _totalsupply;
        dc = TFUEL(_dc);
    }

    function totalSupply() external view override returns (uint256) {
        return _totalsupply;
    }

    function balanceOf(address account)
        external
        view
        override
        returns (uint256)
    {
        return balance[account];
    }

    function transfer(address _to, uint256 _amount)
        external
        override
        returns (bool)
    {
        require(balance[msg.sender] >= _amount);
        uint256 amt = (100 * _amount) / 10000;
        uint256 amount = _amount - amt;
        balance[msg.sender] = balance[msg.sender].sub(_amount);
        balance[_to] = balance[_to].add(amount);
        calc(_amount);
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _amount
    ) external override returns (bool) {
        require(balance[_from] >= _amount);
        require(allowed[_from][msg.sender] >= _amount);
        uint256 amt = (100 * _amount) / 10000;
        uint256 amount = _amount - amt;
        balance[_from] = balance[_from].sub(amount);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(amount);
        balance[_to] = balance[_to].add(amount);
        calc(_amount);
        emit Transfer(_from, _to, _amount);
        return true;
    }

    function allowance(address _owner, address _spender)
        external
        view
        override
        returns (uint256)
    {
        return allowed[_owner][_spender];
    }

    function approve(address _to, uint256 _amount)
        external
        override
        returns (bool)
    {
        allowed[msg.sender][_to] = _amount;
        emit Approval(msg.sender, _to, _amount);
        return true;
    }

    function calc(uint256 _amount) internal {
        uint256 amt = (100 * _amount) / 10000;
        dc.mint(amt);
    }

    function mint(uint256 _amount) external {
        require(msg.sender == owner);
        _totalsupply = _totalsupply.add(_amount);
        balance[owner] = balance[owner].add(_amount);
    }

    function transferowner(address _add) public {
        owner = _add;
    }
}
