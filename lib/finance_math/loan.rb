module FinanceMath
  # the Loan class provides an interface for working with interest rates.
  # @api public
  class Loan
    # @return [Integer] the duration for which the rate is valid, in months
    # @api public
    attr_accessor :duration

    # @return [Float] the amount of loan request
    # @api public
    attr_accessor :amount

    # @return [Float] the nominal annual rate
    # @api public
    attr_accessor :nominal_rate
   
    # @return [DecNum] the monthly rate
    # @api public
    attr_reader :monthly_rate



    # create a new Loan instance
    # @return [Loan]
    # @param [Numeric] decimal value of the interest rate
    # @param [Integer] Duration of the loan period
    # @param [Float] Loan amount
    # @example create a 10.5% Nominal rate
    #   Loan.new(10.5, 12, 1000)
    # @see http://en.wikipedia.org/wiki/Nominal_interest_rate
    # @api public

    def initialize(nominal_rate, duration, amount)
      @nominal_rate, @amount, @duration = nominal_rate.to_f, amount, duration
      @monthly_rate = @nominal_rate / 100 / 12
    end

    def pmt(future_value=0, type=0)
      ((@amount * interest(@monthly_rate, @duration) - future_value ) / ((1.0 + @monthly_rate * type) * fvifa(@monthly_rate, duration)))
    end

    protected

      def pow1pm1(x, y)
        (x <= -1) ? ((1 + x) ** y) - 1 : Math.exp(y * Math.log(1.0 + x)) - 1
      end
    
      def pow1p(x, y)
        (x.abs > 0.5) ? ((1 + x) ** y) : Math.exp(y * Math.log(1.0 + x))
      end
    
      def interest(monthly_rate, duration)
        pow1p(monthly_rate, duration)
      end
    
      def fvifa(monthly_rate, duration)
        (monthly_rate == 0) ? duration : pow1pm1(monthly_rate, duration) / monthly_rate
      end
  end
end