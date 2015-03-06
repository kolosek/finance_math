require 'spec_helper'

describe Loan do
  it "should return initial set nominal rate" do
    loan = Loan.new(nominal_rate: 10, duration: 12, amount: 1000)
    expect(loan.nominal_rate).to eq(10)
  end

  it "should return initial set duration period" do
    loan = Loan.new(nominal_rate: 10, duration: 12, amount: 1000)
    expect(loan.duration).to eq(12)
  end

  it "should return initial set amount loaned" do
    loan = Loan.new(nominal_rate: 10, duration: 12, amount: 1000)
    expect(loan.amount).to eq(1000)
  end

  context ".pmt" do

    it "should return correct pmt value" do
      loan = Loan.new(nominal_rate: 10, duration: 12, amount: 1000)
      expect(loan.pmt).to eq(87.9158872300099)
    end

    it "should return correct pmt value" do
      loan = Loan.new(nominal_rate: 0, duration: 12, amount: 1200)
      expect(loan.pmt).to eq(100)
    end

    it "should return correct pmt value" do
      loan = Loan.new(nominal_rate: 0, duration: 36, amount: 10000)
      expect(loan.pmt).to eq(277.77777777777777)
    end

    it "should return correct pmt value" do
      loan = Loan.new(nominal_rate: 0, duration: 6, amount: 10000)
      expect(loan.pmt).to eq(1666.6666666666667)
    end

    it "should return correct pmt value" do
      loan = Loan.new(nominal_rate: 13, duration: 90, amount: 1000000)
      expect(loan.pmt).to eq(17449.90775727763)
    end
  end

  context ".apr, edge cases" do

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 16, duration: 24, amount: 9200)
      expect(loan.apr).to eq(24.699310868498614)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 13, duration: 24, amount: 10000)
      expect(loan.apr).to eq(21.589972932434698)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 13, duration: 18, amount: 10000)
      expect(loan.apr).to eq(24.1815502466296)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 13, duration: 12, amount: 10000)
      expect(loan.apr).to eq(29.179538647635006)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 13, duration: 6, amount: 10000)
      expect(loan.apr).to eq(42.82076503747119)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 13, duration: 36, amount: 10000)
      expect(loan.apr).to eq(18.93638316167774)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 13, duration: 90, amount: 10000000)
      expect(loan.apr).to eq(15.690778147507167)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 13, duration: 90, amount: 50000000)
      expect(loan.apr).to eq(15.690778147507167)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 13, duration: 1, amount: 50000000)
      expect(loan.apr).to eq(118.47826151517138)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 80, duration: 1, amount: 1000)
      expect(loan.apr).to eq(191.30434783476406)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 36, duration: 200, amount: 500)
      expect(loan.apr).to eq(39.173057290003044)
    end

    it "should return correct apr value" do
      loan = Loan.new(nominal_rate: 15, duration: 36, amount: 10000, structure_fee: 5, currency_protection: 3, fee: 10)
      expect(loan.apr).to eq(23.964418264624054)
    end
  end
end