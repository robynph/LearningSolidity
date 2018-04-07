pragma solidity ^0.4.19;
/* user repository - This contract governs the application registry of Users, Models, Subscriptions.  
* .
*  .
* Tuesday V1.3draft
*/
import "./Factory.sol";
import "./ModelWallet.sol";

contract UserRepository is Factory {
    //Events
    
    event OwnerAddition(address indexed owner);
    event ModelAddition(address indexed model);
    //event SubscriptionAddition(address indexed wallet, address indexed model);
    //  Registration blockchain instantiation
    User[] users;
    Model[] models;
    Subscription[] subscriptions;
    
    // Registration Structs
    struct User {
        address owner; /* This is an Ethereum Account Address - user must have keys and password */
        address walletAddress;
        uint userID;
        bytes32 username;
        bytes32 email;
        bool registered;
        uint bounty;
    }
    struct Model {
        address owner;
        address ownerWallet;
        address modelAddress; /* This is a deployed model contract */
        uint modelID;
        uint modelSLA;
        uint modelRate;
    }
    struct Subscription {
        address owner;
        address walletAddress; /* Unique UserId or wallet address from User{struct} */
        address modelAddress; /* Unique ModelId or contract address from Model{struct} SmileDetector Contract */
        uint userID;
        uint modelID;
        uint subscriptionID;
        uint contractSLA;
        uint contractRate;
    }
    // Mapping
    mapping (address => bool) public isOwner;
    //mapping (address => uint) public regModels;
    //address[] public owners;
    //uint public ownerCount;

    //mapping(uint => User[]) public userslist;
   // mapping(bytes32 => Model[]) public modellist;
   // mapping(bytes32 => Subscription[]) public sublist;
    
    // Modifiers
    modifier onlyByOwner(uint userId) {
        require(msg.sender == users[userId].owner);
        _;
    }
    modifier onlyIfUserNotYetRegistered(uint userId) {
        require(users[userId].registered == false);
        _;
    }
    modifier onlyIfUserIsRegistered(address _owner) {
        require(msg.sender == _owner);
        require(registered(_owner) == true);
        _;
    }
    // Events
    
    // Functions
    /// @dev Checks if a user is registered.
    /// @param _owner Address of owner.
    
    function registered(address _owner) public constant returns(bool isRegistered){
        for (uint i=0; i<users.length - 1; i++)
            if (users[i].owner == _owner) {
                return(true);
                //break;
            } 
        return( isOwner[_owner] ); 
        //return(true);
    }

    
    function transferAmount(address receiver, uint amount) private {
        assert(receiver.send(amount));
    }
    /*
     * Public functions
     */
    /// @dev Allows verified creation of multisignature wallet.
    /// @param _owners List of initial owners.
    /// @param _required Number of required confirmations.
    /// @return Returns wallet address.
    function createWallet(address[] _owners, uint _required) public returns (address wallet) {
        wallet = new ModelWallet(_owners, _required);
        register(wallet);
    }
    
    /// @notice Adds a new User to the blockchain.
    /// @dev User is associated to bounty and sender.
    /// @param _owner User's  address.
    function addUser(address[] _owner, bytes32 _username, bytes32 _email) public payable returns(uint userId){
        User memory newUser;
        //address[] memory multisigOwners;
        //multisigOwners[0] = _owner;
        newUser.owner = _owner[0];  /*Hardcoded to allow only one owner*/
        newUser.walletAddress = createWallet(_owner,1);
        newUser.userID = users.length+1;
        newUser.username = _username;
        newUser.email = _email;
        newUser.registered = true;
        newUser.bounty = msg.value;  /* Temporary variable to tranfer value to wallet */
        transferAmount(newUser.walletAddress,msg.value);
        users.push(newUser);
        isOwner[_owner[0]] = true;
        emit OwnerAddition(_owner[0]);
        return (users.length);
    }
    /// @notice Adds a new Model to the blockchain.
    /// @dev Model is associated to SLA and Rate.
    /// @param _walletAddress User's  address.
    /// @param _modelAddress Models's  address.
    function addModel(address _walletAddress, address _modelAddress, uint _SLA, uint _Rate)  public returns(uint modelID){
        Model memory newModel;
        newModel.owner = msg.sender; 
        newModel.ownerWallet = _walletAddress; 
        newModel.modelAddress = _modelAddress;
        newModel.modelID = models.length+1;
        newModel.modelSLA = _SLA; /* Lookup SLA and Rate from Model Contract*/
        newModel.modelRate = _Rate;
        models.push(newModel);
        emit ModelAddition(_modelAddress);
        return (models.length);
    }                             
    /// @notice Adds a new Model to the blockchain.
    /// @dev Model is associated to SLA and Rate.
    /// @param _walletAddress User's  address.
    /// @param _modelAddress Models's  address.
    function addSubscription(address _walletAddress, address _modelAddress, uint _SLA, uint _Rate)  public returns(uint subscriptionID){
        Subscription memory newSub;
        newSub.owner = msg.sender;
        newSub.walletAddress = _walletAddress;
        newSub.modelAddress = _modelAddress;
        newSub.subscriptionID = subscriptions.length+1;
        newSub.contractSLA = _SLA; /* Lookup SLA and Rate from Model Contract*/
        newSub.contractRate = _Rate;
        subscriptions.push(newSub);
        //emit SubscriptionAddition(_walletAddress, _modelAddress);
        return (subscriptions.length);
    }
    /*
     * Public functions
     */
    /// @dev Allows verified creation of multisignature wallet.
    /// @param _owner List of initial owners.
    /// @return Returns wallet address.
    function getWallet(address _owner) constant public returns (address walletAddress){
        uint i;
        for (i=0; i<users.length; i++){
            if(users[i].owner == _owner)
                return(users[i].walletAddress);
                break;
        }
        return (0);    
    }
    /*
     * Public functions
     */
    /// @dev Allows verified creation of multisignature wallet.
    /// @param _owner List of initial owners.
    /// @return Returns wallet address.
    function getModels(address _owner) constant public returns (address[] modelAddress){
        uint i;
        uint num=0;
        address[] memory modelsTemp = new address[](models.length);
        for (i=0; i<models.length; i++){
            if(models[i].owner == _owner){
                modelsTemp[num] = models[i].modelAddress;
                num++;

            }
        }
        return (modelsTemp);    
    }

    /// @notice Return the number of Users stored in the blockchain.
    /// @return The number of users stored in the blockchain.
    function getNumUsers() constant public returns(uint length) {
        return users.length;
    }
    /// @notice Return the number of Models stored in the blockchain.
    /// @return The number of users stored in the blockchain.
    function getNumModels() constant public returns(uint length) {
        return models.length;
    }
    /// @notice Return the number of Subscriptions stored in the blockchain.
    /// @return The number of users stored in the blockchain.
    function getNumSubscriptions() constant public returns(uint length) {
        return subscriptions.length;
    }
    
    /// @notice Return the number of Models in the blockchain for user with
    /// given id.
    /// @param _userID Id of user to be retrieved.
    /// @return The number of Models in the blockchain for model with
    /// given id.
    /*
    function getNumModelsforUser(uint _userID) constant public returns (uint num) {
        num = 0;
        for (uint i = 0; i<models.length; i++) {
          if (models[i].owner == users[_userID].owner) { 
            num += 1;
          }
        }
        return num;
    } */
    /// @notice Return the number of Models in the blockchain for user with
    /// given id.
    /// @param _userID Id of user to be retrieved.
    /// @return The number of Models in the blockchain for model with
    /// given id.
    /*
    function getNumSubscriptionsforUser(uint _userID) constant public returns (uint num) {
        num = 0;
        for (uint i = 0; i<subscriptions.length; i++) {
          if (subscriptions[i].owner == users[_userID].owner) { 
            num += 1;
          }
        }
        return num;
    } */
    
    /// @notice Return the user with given unique id.
    /// @param _userID Id of user to be retrieved.
    /// @return The user associated to the id, as a tuple with form (owner, bounty, initialError, targetError, weight address).
    function getUserWallet(uint _userID) constant public returns (address) {
        User memory currentUser;
        currentUser = users[_userID];
        return (currentUser.walletAddress);
    }
    function getModelWallet(uint _modelID) constant public returns (address) {
        Model memory currentModel;
        currentModel = models[_modelID];
        return (currentModel.modelAddress);
    }
    function getSubscription(uint _subID) constant public returns (address) {
        Subscription memory currentSub;
        currentSub = subscriptions[_subID];
        return (currentSub.modelAddress);
    }
    /*
    function getUserList() constant public returns (User[]) {
        return (users);
    }
    function getModelList() constant public returns (Model[]) {
        return (models);
    }
    function getSubscriptionList() constant public returns (Subscription[]) {
        return (subscriptions);
    } */
    /// @dev Returns list of owners.
    /// @return List of owner addresses.
    
    function getOwners()
        public constant returns (address[] _owners)
    {
        address[] memory ownersTemp = new address[](users.length);
        uint i;
        for (i=0; i<users.length; i++){
                ownersTemp[i] = users[i].owner;
        }
        return ownersTemp;
    }
}
