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
  end

  context ".apr" do

    it "should return correct apr value" do
      loan = Loan.new(16, 24, 10000)
      expect(loan.apr).to eq(0.24699853524196447)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 24, 10000)
      expect(loan.apr).to eq(0.2159014588291408)
    end

    it "should return correct apr value" do
      loan = Loan.new(13, 18, 10000)
      expect(loan.apr).to eq(0.2418055150965281)
    end

    # it "should return correct apr value" do
    #   loan = Loan.new(13, 6, 10000)
    #   expect(loan.apr).to eq(0.2418055150965281)
    # end

    # it "should return correct apr value" do
    #   loan = Loan.new(13, 36, 10000)
    #   expect(loan.apr).to eq(0.2418055150965281)
    # end
  end
end