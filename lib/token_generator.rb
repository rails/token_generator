module TokenGenerator
  def generate_token(size = 12, &validity)
    begin
      token = Digest::MD5.hexdigest("#{inspect}#{Time.now}").first(size)
    end while validity.call(token) if block_given?
    
    token
  end
  
  def set_token
    self.token = generate_token { |token| !self.find_by_token(token) }
  end
end