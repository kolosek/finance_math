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

    # @return [DecNum] the currency protection
    # @api public
    attr_reader :currency_protection  

    # @return [DecNum] the fee for the bank/market
    # @api public
    attr_reader :structure_fee    

    # @return [DecNum] P principal
    # @api public
    attr_reader :principal    



    # create a new Loan instance
    # @return [Loan]
    # @param [Numeric] decimal value of the interest rate
    # @param [Integer] Duration of the loan period
    # @param [Float] Loan amount
    # @param [Float] structure fee - fee for the market in percentages
    # @param [Float] currency protection - Protection for currency changes - usually 3%, default to 0%
    # @example create a 10.5% Nominal rate
    #   Loan.new(10.5, 12, 1000)
    # @see http://en.wikipedia.org/wiki/Nominal_interest_rate
    # @api public

    def initialize(nominal_rate, duration, amount, structure_fee=5, currency_protection=3)
      @nominal_rate, @amount, @duration, @structure_fee, @currency_protection = nominal_rate.to_f, amount, duration, structure_fee.to_f, currency_protection.to_f
      @principal = principal_calculation
      @monthly_rate = @nominal_rate / 100 / 12
    end

    def pmt(future_value=0, type=0)
      ((@amount * interest(@monthly_rate, @duration) - future_value ) / ((1.0 + @monthly_rate * type) * fvifa(@monthly_rate, duration)))
    end

    def apr
      pmt_base = pmt
      n = duration.to_f / 12
      q = (duration > 12) ? 12 : duration
      i = pmt_base * n * q / principal - 1
      #puts "n: #{n} q: #{q} i: #{i} pmt: #{pmt_base}"
      find(pmt_base, n, q, i)
    end

    def principal_base(m, n, q, i)
      m * ( 1 - ( 1 + ( i / q ) ) ** (- n * q) ) * q / i
    end

    def near(a, b)
      r = 0.1
      return ((a - r) < b && (a + r) > b) || ((b - r) < a && (b + r) > a)
    end

    def find(pmt_base, n, q, i)
      p = principal_base(pmt_base, n, q, i)

      return i if near(p, principal)
      
      if p < principal
        i -= 0.00001
      elsif p > principal
        i += 0.00001
      end
      
      find(pmt_base, n, q, i)
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

    private

      def principal_calculation
        amount * (1 - currency_protection/100 - structure_fee / 100 )
      end
  end
end