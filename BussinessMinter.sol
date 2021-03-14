// SPDX-License-Identifier: MIT
pragma solidity =0.7.5;

// VokenTB (TeraByte) Business Minter
//
// More info:
//   https://voken.io
//
// Contact us:
//   support@voken.io


import "LibSafeMath.sol";
import "LibIVokenTB.sol";
import "LibAuthProxy.sol";


/**
 * @dev Business Minter
 */
contract BusinessMinter is AuthProxy {
    using SafeMath for uint256;
    
    uint256 private immutable VOKEN_ISSUE_MAX = 37_800_000e9;  // 37.8 million, 18% of total supply
    uint256 private _vokenIssued;

    IVokenTB private immutable VOKEN_TB = IVokenTB(0x1234567a022acaa848E7D6bC351d075dBfa76Dd4);

    receive()
        external
        payable
    {
        //
    }

    function status()
        public
        view
        returns (
            uint256 issued,
            uint256 quota
        )
    {
        issued = _vokenIssued;
        quota = VOKEN_ISSUE_MAX.sub(_vokenIssued);
    }
    
    function mint(
        address account,
        uint256 amount
    )
        public
        onlyProxy
        returns (bool)
    {
        _vokenIssued = _vokenIssued.add(amount);
        require(_vokenIssued <= VOKEN_ISSUE_MAX, "Quota exceeded");

        return VOKEN_TB.mint(account, amount);
    }

    function mintWithVesting(
        address account,
        uint256 amount,
        address vestingContract
    )
        public
        onlyProxy
        returns (bool)
    {
        _vokenIssued = _vokenIssued.add(amount);
        require(_vokenIssued <= VOKEN_ISSUE_MAX, "Quota exceeded");

        return VOKEN_TB.mintWithVesting(account, amount, vestingContract);
    }
}

