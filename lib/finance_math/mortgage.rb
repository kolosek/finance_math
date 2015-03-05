module FinanceMath
  class Mortgage
    attr_accessor :loan_amount, :interest_rate, :period, :fees, :points

    def initialize(loan_amount, interest_rate, period=360, fees=0, points=0.0)
      self.loan_amount = Float(loan_amount.to_s)
      self.interest_rate = Float(interest_rate.to_s)
      self.period = Integer(period.to_s)
      self.fees = fees
      self.points = Float(points.to_s)
    end

    def apr
      @apr ||= calculate_apr
    end

    def monthly_payment
      @monthly_payment ||= calculate_monthly_payment(self.loan_amount, monthly_interest_rate, self.period)
    end

    def monthly_payment_with_fees
      @monthly_payment_with_fees ||= calculate_monthly_payment(self.loan_amount + total_fees, monthly_interest_rate, self.period)
    end

    def total_fees(negative_allowed = false)
      #fees may not be negative (borrower is not paid)
      total_fees = calculate_total_fees
      !negative_allowed && total_fees < 0 ? 0 : total_fees
    end

    private
    def monthly_interest_rate
      self.interest_rate / 100 / 12
    end

    def calculate_monthly_payment(amount, monthly_rate, period)
      amount * (monthly_rate/(1 - (1 + monthly_rate)**(-period)))
    end

    def calculate_total_fees
      self.fees + (self.loan_amount * points/100)
    end

    # solves APR
    # [a (1 + a)^N] / [(1 + a)^N - 1] - P/C = 0
    # where a = APR/1200, N = period, P = monthly payment, C = loan_amount
    # calculate APR uses the Newton-Raphson to find the root (the value for 'a' that makes f(a) = 0)
    def calculate_apr
      payment_ratio = monthly_payment_with_fees / loan_amount
      f = lambda {|k| (k**(self.period + 1) - (k**self.period * (payment_ratio + 1)) + payment_ratio)}
      f_deriv = lambda { |k| ((self.period + 1) * k**self.period) - (self.period * (payment_ratio + 1) * k**(self.period - 1))}

      root = newton_raphson(f, f_deriv, monthly_interest_rate + 1)
      puts root
      100 * 12 * (root - 1).to_f
    end

    # if 'start' is the monthly_interest_rate, Newton Raphson will find the apr root very quickly
    # k1 = k0 - f(k0)/f'(k0)
    # k_plus_one = k - f(k)/f_deriv(k)
    # We find the k-intercept of the tangent line at point k_plus_one and compare k to k_plus_one.
    # This is repeated until a sufficiently accurate value is reached, which can be specified with the 'precision' parameter
    def newton_raphson(f, f_deriv, start, precision = 5)
      k_plus_one = start
      k = 0.0

      while ((k - 1) * 10**precision).to_f.floor !=  ((k_plus_one - 1) * 10**precision).to_f.floor
        k = k_plus_one
        k_plus_one = k - f.call(k) / f_deriv.call(k)
      end
      k_plus_one
    end
  end
end