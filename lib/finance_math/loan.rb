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

    # @return [Float] fee
    # @api public
    attr_reader :fee

    # create a new Loan instance
    # @return [Loan]
    # @param [Numeric] decimal value of the interest rate
    # @param [Integer] Duration of the loan period
    # @param [Float] Loan amount
    # @param [Float] structure fee - fee for the market in percentages
    # @param [Float] currency protection - Protection for currency changes - usually 3%, default to 0%
    # @example create a 10.5% Nominal rate
    # @see http://en.wikipedia.org/wiki/Nominal_interest_rate
    # @api public

    def initialize(options = {})
      initialize_options(options)
      @principal = principal_calculation
      @monthly_rate = @nominal_rate / 100 / 12
    end

    def pmt(options = {})
      future_value = options.fetch(:future_value, 0)
      type = options.fetch(:type, 0)
      ((@amount * interest(@monthly_rate, @duration) - future_value ) / ((1.0 + @monthly_rate * type) * fvifa(@monthly_rate, duration)))
    end

    def apr
      @apr ||= calculate_apr
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

      def initialize_options(options)
        @nominal_rate = options.fetch(:nominal_rate).to_f
        @duration = options.fetch(:duration).to_f
        @amount = options.fetch(:amount).to_f
        @structure_fee = options.fetch(:structure_fee, 5).to_f
        @currency_protection = options.fetch(:currency_protection, 3).to_f
        @fee = options.fetch(:fee, 0).to_f
      end

      def principal_calculation
        amount * (1 - currency_protection/100 - structure_fee / 100 ) - fee * duration
      end

      # solves APR
      # [a (1 + a)^N] / [(1 + a)^N - 1] - P/C = 0
      # where a = APR/1200, N = duration, P = monthly payment, C = loan_amount
      # Newton-Raphson finds root (the value for 'a' that makes f(a) = 0)
      def calculate_apr
        payment_ratio = pmt / principal_calculation
        duration = @duration
        f = lambda {|k| (k**(duration + 1) - (k**duration * (payment_ratio + 1)) + payment_ratio)}
        f_deriv = lambda { |k| ((duration + 1) * k**duration) - (duration * (payment_ratio + 1) * k**(duration - 1))}

        root = newton_raphson(f, f_deriv, monthly_rate + 1)
        100 * 12 * (root -1).to_f
      end

      # 'start' is the monthly_rate, Newton Raphson will find the apr root very quickly
      # k1 = k0 - f(k0)/f'(k0)
      # k_plus_one = k - f(k)/f_deriv(k)  f_deriv should be an positive number!
      # We find the k-intercept of the tangent line at point k_plus_one and compare k to k_plus_one.
      # This is repeated until a sufficiently accurate value is reached, which can be specified with the 'precision' parameter
      def newton_raphson(f, f_deriv, start, precision = 5)
        k_plus_one = start
        k = 0.0
        while ((k - 1) * 10**precision).to_f.floor !=  ((k_plus_one - 1) * 10**precision).to_f.floor
          k = k_plus_one
          k_plus_one = k - f.call(k) / f_deriv.call(k).abs
        end
        k_plus_one
      end
  end
end
