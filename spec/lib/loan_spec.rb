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

    it "should return correct pmt value" do
      loan = Loan.new(0, 36, 10000)
      expect(loan.pmt).to eq(277.77777777777777)
    end

    it "should return correct pmt value" do
      loan = Loan.new(0, 6, 10000)
      expect(loan.pmt).to eq(1666.6666666666667)
    end

    it "should return correct pmt value" do
      loan = Loan.new(13, 90, 1000000)
      expect(loan.pmt).to eq(17449.90775727763)
    end
  end

  context ".apr, edge cases" do

    it "should return correct apr value" do
      loan = Loan.new(16, 24, 9200)
      expect(loan.apr).to eq(24.699310868498614)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 24, 10000)
      expect(loan.apr).to eq(21.589972932434698)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 18, 10000)
      expect(loan.apr).to eq(24.1815502466296)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 12, 10000)
      expect(loan.apr).to eq(29.179538647635006)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 6, 10000)
      expect(loan.apr).to eq(42.82076503747119)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 36, 10000)
      expect(loan.apr).to eq(18.93638316167774)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 90, 10000000)
      expect(loan.apr).to eq(15.690778147507167)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 90, 50000000)
      expect(loan.apr).to eq(15.690778147507167)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 1, 50000000)
      expect(loan.apr).to eq(118.47826151517138)
    end

    it "should return correct apr value" do
      loan = Loan.new(80, 1, 1000)
      expect(loan.apr).to eq(191.30434783476406)
    end

    it "should return correct apr value" do
      loan = Loan.new(36, 200, 500)
      expect(loan.apr).to eq(39.173057290003044)
    end

    it "should return correct apr value" do
      loan = Loan.new(15, 36, 10000, 5, 3, 10)
      expect(loan.apr).to eq(23.964418264624054)
    end
  end
end