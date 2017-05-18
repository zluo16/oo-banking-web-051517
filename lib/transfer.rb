class Transfer

  attr_accessor :status
  attr_reader :sender, :receiver, :amount, :sender_account

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @sender_account = sender.balance
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if !valid? || amount > sender_account
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    elsif sender.balance > sender_account - amount
      sender.balance -= amount
      receiver.balance += amount
      @status = "complete"
    end
  end

  def reverse_transfer
    if status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      @status = "reversed"
    end
  end

end
