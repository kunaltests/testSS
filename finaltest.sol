// SPDX-License-Identifier: MIT
pragma solidity 0.8;


contract D {
    function f() external {}
}
contract C {
    uint a;
    uint256 x;
    address owner;

    function f() public {
        h().f.selector;
    }

    function h() public returns (D) {
        x = 42;
        return new D();
    }
    
    function update(uint _a) external {
    //anything above
    a = _a;
    }

    function updateOwner(address _owner) external {
        require(owner==msg.sender);
        owner = _owner;
    }
    function updateOwner2(address _owner) external {
        require(owner==msg.sender);
        require(_owner!=owner);
        owner = _owner;
    }
    function updateOwner3(address _owner) external {
        require(owner==msg.sender);
        if(_owner==owner){
            revert("same");
        }
        owner = _owner;
    }
    function updateOwner5(address _owner) external {
        require(owner==msg.sender);
        if(_owner!=owner){
        owner = _owner;    
        }
        else{
            revert("same");
        } 
    }
    function updateOwner6(address _owner) external {
        require(owner==msg.sender);
        assert(owner!=_owner);
        owner = _owner;
    }
}
