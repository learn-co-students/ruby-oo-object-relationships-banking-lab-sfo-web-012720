require 'pp'
 
class Transfer
 
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
 
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
 
  end
 
  def valid?
 
    if self.sender.valid? === true && self.receiver.valid? === true
 
      return true
 
    else
 
      return false
 
    end
 
  end
 
  def execute_transaction
 
    #pp self.sender.name
    #pp self.sender.status
    #pp self.sender.valid?
    #pp self.sender.balance
 
    if self.status === "complete"
      return
 
    elsif self.valid? === false || self.sender.balance < amount
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
   
    elsif self.status === "pending"
      self.receiver.deposit(self.amount)
      self.sender.balance -= self.amount
      self.status = 'complete'
      #pp "I'm here"
 
    end
 
  end
 
    def reverse_transfer
      if self.status === "complete"
        self.sender.deposit(self.amount)
        self.receiver.balance -= self.amount
        self.status = "reversed"
 
      end
 
    end
 
end