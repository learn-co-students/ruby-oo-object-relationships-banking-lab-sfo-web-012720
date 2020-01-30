class Transfer

  attr_reader :sender, :receiver
  attr_accessor :status, :amount

  def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
  end

  def bank_account
    BankAccount.all.select { |bank_account| bank_account.transfer == self }
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance > amount && status == "pending"
      receiver.balance += amount
      sender.balance -= amount
      self.status = "complete"
    else
      reject_transfer
    end
  end

  def reverse_transfer
    if status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    else
      "no transfer"
    end
  end

  def reject_transfer
    sender.balance < amount 
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

end