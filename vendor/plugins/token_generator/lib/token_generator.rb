module TokenGenerator
  def generate_token(size = 12, what = :hex, &validity)
    constant = "#{self.class.name}#{id}"
    alphanums = ('a'..'z').to_a+(0..9).to_a
    
    begin
      token = if what == :hex
        ActiveSupport::SecureRandom.hex(64).first(size)
      elsif what == :alpha_num
        (1..size).map { alphanums[ActiveSupport::SecureRandom.random_number(alphanums.size)] }.join
      elsif what == :alpha
        (1..size).map { ('a'..'z').to_a[ActiveSupport::SecureRandom.random_number(26)] }.join
      elsif what == :number
        (1..size).map { ActiveSupport::SecureRandom.random_number(10) }.join
      end
    end while block_given? && !validity.call(token)

    token
  end

  def set_token
    self.token = generate_token { |token| self.class.find_by_token(token).nil? }
  end
end
