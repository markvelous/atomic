// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.4;

contract Hash {
    function calHash(string memory _key) external view returns(bytes32) {
        return keccak256(abi.encodePacked(_key));
    }
}

//Rumpelstiltskin   0x5115460c6aac7ed0b7541e41a93baa60af199b2d9d816e14d192a861db75ff22
//RJ                0x260a02b0653707e6f244a7e46ea158975462e4fda30a6b6453b6a16450061fa6
