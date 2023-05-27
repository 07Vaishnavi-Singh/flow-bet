
pub contract Pool{
   
   priv var TotalBetAmount : UInt
   priv let MIN_AMOUNT : UInt 
   priv let MAX_PLAYERS : UInt

   pub event MoneyAccepted(account:Address)
   pub event MoneyWithDrawn(account:Address ,amount:UFix64)
   init() {
   self.TotalBetAmount=0
   self.MIN_AMOUNT = 69
   self.MAX_PLAYERS = 100
   } 
    
   //accept only after the start of contest
   pub fun AcceptBet(address:Address , _amount:UInt ){

   // if 101th reg or greater panic
    if(_players >= self.MAX_PLAYERS){
    panic("Max participants exceeded")
    }

   //if less amount panic
    if(_amount<self.MIN_AMOUNT){
     panic("Amount not enough")
    }
    
    
    //calls the nft_mint.cdc
    emit MoneyAccepted(success:true)

    //increment the player
   } 
   
   //oracle triggers this
   pub fun DistributeFundsToWinners(){

   }
      
   priv fun getFlowTokenBalance(): UFix64 {
        let vaultRef = getAccount(acct: AuthAccount).getCapability(/public/flowTokenBalance).borrow<&{FungibleToken.Balance}>()
            ?? panic("Could not borrow Balance reference to the Vault")
        return vaultRef.balance
    }

}
