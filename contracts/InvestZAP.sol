// File: @openzeppelin\contracts\token\ERC20\IERC20.sol

pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}

// File: @openzeppelin\contracts\GSN\Context.sol

pragma solidity ^0.5.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin\contracts\ownership\Ownable.sol

pragma solidity ^0.5.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

// File: @openzeppelin\contracts\math\SafeMath.sol

pragma solidity ^0.5.0;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     * - Subtraction cannot overflow.
     *
     * _Available since v2.4.0._
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     * - The divisor cannot be zero.
     *
     * _Available since v2.4.0._
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin\contracts\utils\Address.sol

pragma solidity ^0.5.5;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * This test is non-exhaustive, and there may be false-negatives: during the
     * execution of a contract's constructor, its address will be reported as
     * not containing a contract.
     *
     * IMPORTANT: It is unsafe to assume that an address for which this
     * function returns false is an externally-owned account (EOA) and not a
     * contract.
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies in extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != 0x0 && codehash != accountHash);
    }

    /**
     * @dev Converts an `address` into `address payable`. Note that this is
     * simply a type cast: the actual underlying value is not changed.
     *
     * _Available since v2.4.0._
     */
    function toPayable(address account) internal pure returns (address payable) {
        return address(uint160(account));
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     *
     * _Available since v2.4.0._
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-call-value
        (bool success, ) = recipient.call.value(amount)("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
}


interface Compound {
    function approve ( address spender, uint256 amount ) external returns ( bool );
    function mint ( uint256 mintAmount ) external returns ( uint256 );
    function balanceOf(address _owner) external view returns (uint256 balance);
    function transfer(address _to, uint _value) external returns (bool success);
    function redeem(uint256 redeemTokens) external returns (uint256);
}

interface Fulcrum {
    function mintWithEther(address receiver, uint256 maxPriceAllowed) external payable returns (uint256 mintAmount);
    function mint(address receiver, uint256 amount) external payable returns (uint256 mintAmount);
    function burnToEther(address receiver, uint256 burnAmount, uint256 minPriceAllowed) external returns (uint256 loanAmountPaid);
    function burn(address receiver, uint256 burnAmount) external returns (uint256 loanAmountPaid);
    function balanceOf(address _owner) external view returns (uint256 balance);
}

interface ILendingPoolAddressesProvider {
    function getLendingPool() external view returns (address);
}

interface Aave {
    function deposit(address _reserve, uint256 _amount, uint16 _referralCode) external;
    function redeemUnderlying(address _reserve, address payable _user, uint256 _amount, uint256 _aTokenBalanceAfterRedeem) external;
    function balanceOf(address _owner) external view returns (uint256 balance);
}

interface AToken {
    function redeem(uint256 amount) external;
    function balanceOf(address _owner) external view returns (uint256 balance);
}

interface IIEarnManager {
    function recommend(address _token) external view returns (
      string memory choice,
      uint256 capr,
      uint256 iapr,
      uint256 aapr,
      uint256 dapr
    );
}

contract Structs {
    struct Val {
        uint256 value;
    }

    struct TotalPar {
        uint128 borrow;
        uint128 supply;
    }

    enum ActionType {
        Deposit,   // supply tokens
        Withdraw,  // borrow tokens
        Transfer,  // transfer balance between accounts
        Buy,       // buy an amount of some token (externally)
        Sell,      // sell an amount of some token (externally)
        Trade,     // trade tokens against another account
        Liquidate, // liquidate an undercollateralized or expiring account
        Vaporize,  // use excess tokens to zero-out a completely negative account
        Call       // send arbitrary data to an address
    }

    enum AssetDenomination {
        Wei, // the amount is denominated in wei
        Par  // the amount is denominated in par
    }

    enum AssetReference {
        Delta, // the amount is given as a delta from the current value
        Target // the amount is given as an exact number to end up at
    }

    struct AssetAmount {
        bool sign; // true if positive
        AssetDenomination denomination;
        AssetReference ref;
        uint256 value;
    }

    struct ActionArgs {
        ActionType actionType;
        uint256 accountId;
        AssetAmount amount;
        uint256 primaryMarketId;
        uint256 secondaryMarketId;
        address otherAddress;
        uint256 otherAccountId;
        bytes data;
    }

    struct Info {
        address owner;  // The address that owns the account
        uint256 number; // A nonce that allows a single address to control many accounts
    }

    struct Wei {
        bool sign; // true if positive
        uint256 value;
    }
}

contract DyDx is Structs {
    function getEarningsRate() public view returns (Val memory);
    function getMarketInterestRate(uint256 marketId) public view returns (Val memory);
    function getMarketTotalPar(uint256 marketId) public view returns (TotalPar memory);
    function getAccountWei(Info memory account, uint256 marketId) public view returns (Wei memory);
    function operate(Info[] memory, ActionArgs[] memory) public;
}

contract InvestZAP is Ownable, Structs {
    using SafeMath for uint;
    using Address for address;

    mapping(address => address) public compound;
    mapping(address => address) public fulcrum;
    mapping(address => address) public aave;
    mapping(address => uint256) public dydx;

    address public APR;
    address public AAVE;
    address public DYDX;

    enum CurrentLender {
        NONE,
        DYDX,
        COMPOUND,
        AAVE,
        FULCRUM
    }

    constructor() public {
        APR = address(0x9CaD8AB10daA9AF1a9D2B878541f41b697268eEC);
        DYDX = address(0x1E0447b19BB6EcFdAe1e4AE1694b0C3659614e4e);
        AAVE = address(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);

        addCToken(0x6B175474E89094C44Da98b954EedeAC495271d0F, 0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643); // cDAI
        addCToken(0x0D8775F648430679A709E98d2b0Cb6250d2887EF, 0x6C8c6b02E7b2BE14d4fA6022Dfd6d75921D90E4E); // cBAT
        addCToken(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE, 0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5); // cETH
        addCToken(0x1985365e9f78359a9B6AD760e32412f4a445E862, 0x158079Ee67Fce2f58472A96584A73C7Ab9AC95c1); // cREP
        addCToken(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48, 0x39AA39c021dfbaE8faC545936693aC917d5E7563); // cUSDC
        addCToken(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599, 0xC11b1268C1A384e55C48c2391d8d480264A3A7F4); // cWBTC
        addCToken(0xE41d2489571d322189246DaFA5ebDe1F4699F498, 0xB3319f5D18Bc0D84dD1b4825Dcde5d5f7266d407); // cZRX

        addAToken(0x6B175474E89094C44Da98b954EedeAC495271d0F, 0xfC1E690f61EFd961294b3e1Ce3313fBD8aa4f85d); // aDAI
        addAToken(0x0000000000085d4780B73119b644AE5ecd22b376, 0x4DA9b813057D04BAef4e5800E36083717b4a0341); // aTUSD
        addAToken(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48, 0x9bA00D6856a4eDF4665BcA2C2309936572473B7E); // aUSDC
        addAToken(0xdAC17F958D2ee523a2206206994597C13D831ec7, 0x71fc860F7D3A592A4a98740e39dB31d25db65ae8); // aUSDT
        addAToken(0x57Ab1ec28D129707052df4dF418D58a2D46d5f51, 0x625aE63000f46200499120B906716420bd059240); // aSUSD
        addAToken(0x80fB784B7eD66730e8b1DBd9820aFD29931aab03, 0x7D2D3688Df45Ce7C552E19c27e007673da9204B8); // aLEND
        addAToken(0x0D8775F648430679A709E98d2b0Cb6250d2887EF, 0xE1BA0FB44CCb0D11b80F92f4f8Ed94CA3fF51D00); // aBAT
        addAToken(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE, 0x3a3A65aAb0dd2A17E3F1947bA16138cd37d08c04); // aETH
        addAToken(0x514910771AF9Ca656af840dff83E8264EcF986CA, 0xA64BD6C70Cb9051F6A9ba1F163Fdc07E0DfB5F84); // aLINK
        addAToken(0xdd974D5C2e2928deA5F71b9825b8b646686BD200, 0x9D91BE44C06d373a8a226E1f3b146956083803eB); // aKNC
        addAToken(0x1985365e9f78359a9B6AD760e32412f4a445E862, 0x71010A9D003445aC60C4e6A7017c1E89A477B438); // aREP
        addAToken(0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2, 0x7deB5e830be29F91E298ba5FF1356BB7f8146998); // aMKR
        addAToken(0x0F5D2fB29fb7d3CFeE444a200298f468908cC942, 0x6FCE4A401B6B80ACe52baAefE4421Bd188e76F6f); // aMANA
        addAToken(0xE41d2489571d322189246DaFA5ebDe1F4699F498, 0x6Fb0855c404E09c47C3fBCA25f08d4E41f9F062f); // aZRX
        addAToken(0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F, 0x328C4c80BC7aCa0834Db37e6600A6c49E12Da4DE); // aSNX
        addAToken(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599, 0xFC4B8ED459e00e5400be803A9BB3954234FD50e3); // aWBTC

        addIToken(0xE41d2489571d322189246DaFA5ebDe1F4699F498, 0xA7Eb2bc82df18013ecC2A6C533fc29446442EDEe); // iZRX
        addIToken(0x1985365e9f78359a9B6AD760e32412f4a445E862, 0xBd56E9477Fc6997609Cf45F84795eFbDAC642Ff1); // iREP
        addIToken(0xdd974D5C2e2928deA5F71b9825b8b646686BD200, 0x1cC9567EA2eB740824a45F8026cCF8e46973234D); // iKNC
        addIToken(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599, 0xBA9262578EFef8b3aFf7F60Cd629d6CC8859C8b5); // iWBTC
        addIToken(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48, 0xF013406A0B1d544238083DF0B93ad0d2cBE0f65f); // iUSDC
        addIToken(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE, 0x77f973FCaF871459aa58cd81881Ce453759281bC); // iETH
        addIToken(0x6B175474E89094C44Da98b954EedeAC495271d0F, 0x493C57C4763932315A328269E1ADaD09653B9081); // iDAI
        addIToken(0x514910771AF9Ca656af840dff83E8264EcF986CA, 0x1D496da96caf6b518b133736beca85D5C4F9cBc5); // iLINK
        addIToken(0x57Ab1ec28D129707052df4dF418D58a2D46d5f51, 0x49f4592E641820e928F9919Ef4aBd92a719B4b49); // iSUSD

        addDToken(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE, 0); // dETH
        addDToken(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48, 2); // dUSDC
        addDToken(0x6B175474E89094C44Da98b954EedeAC495271d0F, 3); // dDAI
    }

    function set_new_APR(address _new_APR) public onlyOwner {
        APR = _new_APR;
    }

    function recommend(address _token) public view returns (CurrentLender) {
      (,uint256 capr,uint256 iapr,uint256 aapr,uint256 dapr) = IIEarnManager(APR).recommend(_token);
      uint256 max = 0;
      if (capr > max) {
        max = capr;
      }
      if (iapr > max) {
        max = iapr;
      }
      if (aapr > max) {
        max = aapr;
      }
      if (dapr > max) {
        max = dapr;
      }

      CurrentLender newLender = CurrentLender.NONE;
      if (max == dapr) {
        newLender = CurrentLender.DYDX;
      }
      if (max == aapr) {
        newLender = CurrentLender.AAVE;
      }
      if (max == iapr) {
        newLender = CurrentLender.FULCRUM;
      }
      if (max == capr) {
        newLender = CurrentLender.COMPOUND;
      }
      return newLender;
    }

    function balanceDydx(address _token) public view returns (uint256) {
        return balanceDydxAddress(_token, address(this));
    }
    function balanceDydxAddress(address _token, address _owner) public view returns (uint256) {
        uint256 marketID = dydx[_token];
        Wei memory bal = DyDx(DYDX).getAccountWei(Info(_owner, 0), marketID);
        return bal.value;
    }
    function balanceCompound(address _token) public view returns (uint256) {
        return balanceCompoundAddress(_token, address(this));
    }
    function balanceCompoundAddress(address _token, address _owner) public view returns (uint256) {
        return Compound(compound[_token]).balanceOf(_owner);
    }
    function balanceFulcrum(address _token) public view returns (uint256) {
      return balanceFulcrumAddress(_token, address(this));
    }
    function balanceFulcrumAddress(address _token, address _owner) public view returns (uint256) {
      return Fulcrum(fulcrum[_token]).balanceOf(_owner);
    }
    function balanceAave(address _token) public view returns (uint256) {
      return balanceAaveAddress(_token, address(this));
    }
    function balanceAaveAddress(address _token, address _owner) public view returns (uint256) {
      return AToken(aave[_token]).balanceOf(_owner);
    }

    function supplyDydx(address _token, uint256 amount) public returns(uint) {
        uint256 marketID = dydx[_token];

        Info[] memory infos = new Info[](1);
        infos[0] = Info(address(this), 0);

        AssetAmount memory amt = AssetAmount(true, AssetDenomination.Wei, AssetReference.Delta, amount);
        ActionArgs memory act;
        act.actionType = ActionType.Deposit;
        act.accountId = 0;
        act.amount = amt;
        act.primaryMarketId = marketID;
        act.otherAddress = address(this);

        ActionArgs[] memory args = new ActionArgs[](1);
        args[0] = act;

        DyDx(DYDX).operate(infos, args);
    }

    function withdrawDydx(address _token, uint256 amount) public {
        uint256 marketID = dydx[_token];

        Info[] memory infos = new Info[](1);
        infos[0] = Info(address(this), 0);

        AssetAmount memory amt = AssetAmount(true, AssetDenomination.Wei, AssetReference.Delta, amount);
        ActionArgs memory act;
        act.actionType = ActionType.Withdraw;
        act.accountId = 0;
        act.amount = amt;
        act.primaryMarketId = marketID;
        act.otherAddress = address(this);

        ActionArgs[] memory args = new ActionArgs[](1);
        args[0] = act;

        DyDx(DYDX).operate(infos, args);
    }

    function balance(address _token) public view returns (uint256) {
      return IERC20(_token).balanceOf(address(this));
    }

    function approveToken(address _token) public {
        IERC20(_token).approve(compound[_token], uint(-1)); //also add to constructor
        IERC20(_token).approve(DYDX, uint(-1));
        IERC20(_token).approve(AAVE, uint(-1));
        IERC20(_token).approve(fulcrum[_token], uint(-1));
    }

    /*function transferAll(address _token) public {
      uint256 amount = balanceCompoundAddress(_token, msg.sender);
      if (amount > 0) {
        transferCompound(_token, amount);
      }
      amount = balanceDydxAddress(_token, msg.sender);
      if (amount > 0) {
        transferDydx(_token, amount);
      }
      amount = balanceFulcrumAddress(_token, msg.sender);
      if (amount > 0) {
        transferFulcrum(_token, amount);
      }
      amount = balanceAaveAddress(_token, msg.sender);
      if (amount > 0) {
        transferAave(_token, amount);
      }
    }*/

    function withdrawAll(address _token) public {
      uint256 amount = balanceCompound(_token);
      if (amount > 0) {
        withdrawCompound(_token, amount);
      }
      amount = balanceDydx(_token);
      if (amount > 0) {
        withdrawDydx(_token, amount);
      }
      amount = balanceFulcrum(_token);
      if (amount > 0) {
        withdrawFulcrum(_token, amount);
      }
      amount = balanceAave(_token);
      if (amount > 0) {
        withdrawAave(_token, amount);
      }
    }

    function rebalance(address _token) public {
      CurrentLender newLender = recommend(_token);

      withdrawAll(_token);

      if (balance(_token) > 0) {
        if (newLender == CurrentLender.DYDX) {
          supplyDydx(_token, balance(_token));
        }
        if (newLender == CurrentLender.FULCRUM) {
          supplyFulcrum(_token, balance(_token));
        }
        if (newLender == CurrentLender.COMPOUND) {
          supplyCompound(_token, balance(_token));
        }
        if (newLender == CurrentLender.AAVE) {
          supplyAave(_token, balance(_token));
        }
      }
    }

    function supplyAave(address _token, uint amount) public {
      Aave(AAVE).deposit(_token, amount, 0);
    }
    function supplyFulcrum(address _token, uint amount) public {
      require(Fulcrum(fulcrum[_token]).mint(address(this), amount) > 0, "FULCRUM: supply failed");
    }
    function supplyCompound(address _token, uint amount) public {
        require(Compound(compound[_token]).mint(amount) == 0, "COMPOUND: supply failed");
    }

    function withdrawAave(address _token, uint amount) public {
        AToken(aave[_token]).redeem(amount);
    }
    function withdrawFulcrum(address _token, uint amount) public {
        require(Fulcrum(fulcrum[_token]).burn(address(this), amount) > 0, "FULCRUM: withdraw failed");
    }
    function withdrawCompound(address _token, uint amount) public {
        require(Compound(compound[_token]).redeem(amount) == 0, "COMPOUND: withdraw failed");
    }

    function addCToken(
      address token,
      address cToken
    ) public onlyOwner {
        compound[token] = cToken;
    }

    function addIToken(
      address token,
      address iToken
    ) public onlyOwner {
        fulcrum[token] = iToken;
    }

    function addAToken(
      address token,
      address aToken
    ) public onlyOwner {
        aave[token] = aToken;
    }

    function addDToken(
      address token,
      uint256 dToken
    ) public onlyOwner {
        dydx[token] = dToken;
    }


    function set_new_AAVE(address _new_AAVE) public onlyOwner {
        AAVE = _new_AAVE;
    }
    function set_new_DYDX(address _new_DYDX) public onlyOwner {
        DYDX = _new_DYDX;
    }

    // incase of half-way error
    function inCaseTokenGetsStuck(IERC20 _TokenAddress) onlyOwner public {
        uint qty = _TokenAddress.balanceOf(address(this));
        _TokenAddress.transfer(msg.sender, qty);
    }
    // incase of half-way error
    function inCaseETHGetsStuck() onlyOwner public{
        (bool result, ) = msg.sender.call.value(address(this).balance)("");
        require(result, "transfer of ETH failed");
    }

}
