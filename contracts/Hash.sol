// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.4;

contract Hash {
    function calHash(string memory _key) external view returns(bytes32) {
        return keccak256(abi.encodePacked(_key));
    }
}

//abracadabra 0xfd69353b27210d2567bc0ade61674bbc3fc01a558a61c2a0cb2b13d96f9387cd