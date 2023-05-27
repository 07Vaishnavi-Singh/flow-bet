import NonFungibleToken from "./interfaces/NonFungibleToken.cdc"
import FungibleToken from "./interfaces/FungibleToken.cdc"
import FlowToken from "./tokens/FlowToken.cdc"

pub contract Bet : NonFungibleToken {

    pub let creators: {String: Address}
    
    pub fun isAvailable(name: String): Bool {
       if self.creators[name] == nil {
          return true
        }
        return false
   }
    
    pub fun getAllOwners(): {String: Address} {
    return self.creators
     }

    pub struct BetInfo {
        pub let id: UInt64
        pub let name: String
        pub let description: String
        pub let creator: Address
        pub let amount: UFix64
        pub let team: [Address]
        pub let expiry: UFix64

        init(id: UInt64,
         name: String,
         description: String,
         creator: Address, 
         amount: UFix64,
         team: [Address],
         expiry: UFix64) {
                self.id = id
                self.name = name
                self.description = description
                self.creator = creator
                self.amount = amount
                self.team = team
                self.expiry = expiry    
          
            
        }
    }

    pub resource interface BetPublic {
        pub let id : UInt64
        pub let name : String
        pub let creator : Address
        pub let expiry : UFix64
        pub fun getBetInfo() : BetInfo
        pub fun getTeam() : [Address]
        pub fun getname() : String

    }
     
    pub resource NFT: BetPublic , NonFungibleToken.INFT {
        pub let id : UInt64
        pub let name : String
        pub let description : String
        pub let expiry : UFix64

        init(id: UInt64, name: String, description: String , expiry: UFix64) {
            self.id = id
            self.name = name
            self.description = description
            self.expiry = expiry
        }

        pub fun getname() : String {
            return self.name
        }
        
        pub fun getBetInfo() : BetInfo {
        let creator = Bet.creators[self.name] 
            return BetInfo(
                id: self.id,
                name: self.name,
                description: self.description,
                creator: creator,
                amount: self.amount,
                team: self.team,
                expiry: self.expiry
            )
        }
         
    }
    
} 