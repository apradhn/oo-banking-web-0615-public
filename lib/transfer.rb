require "pry"

class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @@transactions = 0
  end

  def both_valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if both_valid? && @@transactions == 0 && sender.balance > amount
      sender.balance -= amount
      receiver.balance += amount
      @status = "complete"
      @@transactions += 1
    elsif sender.balance < amount
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @@transactions == 1
      sender.balance += amount
      receiver.balance -= amount
      @status = "reversed"
    end
  end
end