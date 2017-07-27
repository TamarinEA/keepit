module Keepit
  # A float value which decays exponentially toward 0 over time.
  class Decaying
    attr_accessor :e
    attr_accessor :p

    # opts - Hash
    #        :p - Float (0.0) The initial value
    #        :e - Float (Math::E) Exponent base
    #        :r - Float (Math.log(0.5) / 10) Timescale factor - defaulting to decay 50% every 10 seconds
    def initialize(opts = {})
      @p = opts[:p] || 0.0
      @e = opts[:e] || Math::E
      @r = opts[:r] || Math.log(0.5) / 10
      @t0 = Time.now.to_i
    end

    # Add to current value
    #
    # d - Float value to add
    def <<(d)
      @p = value + d
    end

    # Returns Float the current value (adjusted for the time decay)
    def value
      return 0.0 unless @p > 0
      now = Time.now.to_i
      dt = now - @t0
      @t0 = now
      @p *= @e**(@r * dt)
    end
  end
end
