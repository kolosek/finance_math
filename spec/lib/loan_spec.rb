require 'spec_helper'

describe Loan do
  it "should return initial set nominal rate" do
    loan = Loan.new(10, 12, 1000)
    expect(loan.nominal_rate).to eq(10)
  end

  it "should return initial set duration period" do
    loan = Loan.new(10, 12, 1000)
    expect(loan.duration).to eq(12)
  end

  it "should return initial set amount loaned" do
    loan = Loan.new(10, 12, 1000)
    expect(loan.amount).to eq(1000)
  end

  context ".pmt" do

    it "should return correct pmt value" do
      loan = Loan.new(10, 12, 1000)
      expect(loan.pmt).to eq(87.9158872300099)
    end

    it "should return correct pmt value" do
      loan = Loan.new(0, 12, 1200)
      expect(loan.pmt).to eq(100)
    end
  end
end