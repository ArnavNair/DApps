pragma solidity ^0.5.8;

contract Adoption{
    //Struct representing each pet
    struct Pet{
        address[] adopters;
        mapping (address => uint) bid;
    }
    
    
    //Array to store the adopterStatus
    mapping(uint => Pet) pets;
    
    
    //Mapping to store the status of each person's adoption power
    mapping(address => bool) adopterStatus;
    
    
    //Mapping to store each person's pet choice
    mapping(address => uint) choice;

    //Modifier to ensure that one person can only opt to adopt one pet
    modifier newAdopter(){
        require(!adopterStatus[msg.sender], "Sorry, you have already opted to adopt a pet");
        _;
    }


    //Function to adopt a pet, indicated by its petId
    function adopt(uint petId) public newAdopter returns(uint){
        //Validate the input petId
        require(petId >= 0 && petId <= 15);

        //Assign the adopter's address to this petId and update the adopter's adoption status and choice
        pets[petId].adopters.push(msg.sender);
        adopterStatus[msg.sender] = true;
        choice[msg.sender] = petId;

        //Return the petId to indicate the adoption process has been successfully completed.
        //This simplifies the testing process.
        return petId;
    }

    //Function to return the list of adopters
    function getAdopters(uint petId) public view returns(address[] memory){
        return pets[petId].adopters;
    }
    
    
    //Function to place a bid for a pet
    function placeBid(uint petId, uint amount) public{
        //Ensure the person is bidding for the pet he chose
        require(petId == choice[msg.sender], "Sorry, this isn't the pet you opted for.");
        
        //Accept the bid
        pets[petId].bid[msg.sender] += amount;
    }
    
    
    //Function to find the winning adopter for a given pet
    function getWinner(uint petId) public view returns(address){
        //Obtain the struct object for the give pet
        Pet storage pet = pets[petId];
        
        uint people = pet.adopters.length;
        address winner = pet.adopters[0];
        
        //Find the winning bidder
        for(uint i = 1; i < people; i = i + 1)
        {
            if(pet.bid[pet.adopters[i]] > pet.bid[winner])
                winner = pet.adopters[i];
        }
        
        //Return the winning adopter
        return winner;
    }
    
    /*NOTE: Bidding functionality has only been added to the Smart Contract.
      It is yet to be extended to the front-end of the DApp.*/
}

