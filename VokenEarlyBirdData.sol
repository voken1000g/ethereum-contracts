// SPDX-License-Identifier: MIT
pragma solidity =0.7.5;


interface IEarlyBirdSale {
    function status() external view returns (uint256 vokenCap,
                                             uint256 vokenTotalSupply,
                                             uint256 vokenIssued,
                                             uint256 vokenBonuses,
                                             uint256 etherUSD,
                                             uint256 vokenUSD,
                                             uint256 weiMin,
                                             uint256 weiMax);
                                             
    function getAccountStatus(address account) external view returns (uint256 issued,
                                                                      uint256 bonuses,
                                                                      uint256 volume,
                                                        
                                                                      uint256 etherBalance,
                                                                      uint256 vokenBalance,

                                                                      uint160 voken,
                                                                      address referrer,
                                                                      uint160 referrerVoken);

    function vestingOf(address account) external view returns (uint256);
}


contract VokenEarlyBirdData {
    IEarlyBirdSale private immutable EARLY_BIRD_SALE = IEarlyBirdSale(0x1aaaa06374970dE748130EaccCdd2d0348E834c4);

    function data(address account)
        public
        view
        returns (
            uint256 weiMin,
            uint256 weiMax,

            uint256 vokenPrice,
            uint256 totalIssued,
            uint256 totalBonuses,

            uint256 issued,
            uint256 bonuses,
            uint256 vesting,

            uint256 referred
        )
    {
        (, , totalIssued, totalBonuses, , vokenPrice, weiMin, weiMax) = EARLY_BIRD_SALE.status();
        (issued, bonuses, referred, , , , ,) = EARLY_BIRD_SALE.getAccountStatus(account);
        vesting = EARLY_BIRD_SALE.vestingOf(account);
    }
}
