class Enigma
  CHARSET = ("a".."z").to_a << " "

  def encrypt(text, key = gen_key, date = today_date)
    s            = shifts(key, date)
    shift_values = [s[:a], s[:b], s[:c], s[:d]]

    encrypted_text = text.downcase.chars.map.with_index do |char, index|
      if CHARSET.include?(char)
        shift     = shift_values[index % 4]
        old_index = CHARSET.index(char)
        new_index = (old_index + shift) % CHARSET.length
        CHARSET[new_index]
      else 
        char 
      end
    end.join
    
    {
      encryption: encrypted_text,
      key: key,
      date: date
    }
  end

  def decrypt(code, key, date = today_date)
    s            = shifts(key, date)
    shift_values = [s[:a], s[:b], s[:c], s[:d]]

    decrypted_text = code.downcase.chars.map.with_index do |char, index|
      if CHARSET.include?(char)
        shift     = shift_values[index % 4]
        old_index = CHARSET.index(char)
        new_index = (old_index - shift) % CHARSET.length
        CHARSET[new_index]
      else 
        char
      end
    end.join
    {
      decryption: decrypted_text,
      key: key,
      date: date
    }
  end

  private 

  def gen_key
    rand(0..99_999).to_s.rjust(5, "0")
  end

  def today_date
    Date.today.strftime("%d%m%y")
  end

  def shifts(key, date) #could be broken into helper methods
    a_key = key[0..1].to_i
    b_key = key[1..2].to_i
    c_key = key[2..3].to_i
    d_key = key[3..4].to_i

    date_sq = date.to_i ** 2
    last4   = date_sq.to_s[-4..]

    a_offset = last4[0].to_i
    b_offset = last4[1].to_i
    c_offset = last4[2].to_i
    d_offset = last4[3].to_i

    {
      a: a_key + a_offset,
      b: b_key + b_offset,
      c: c_key + c_offset,
      d: d_key + d_offset
    }
  end
end
