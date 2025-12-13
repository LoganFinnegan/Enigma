require 'spec_helper'

RSpec.describe 'Enigma' do
  before(:each) do
    @enigma = Enigma.new
  end

  it 'exists' do
    expect(@enigma).to be_a(Enigma)
  end

  it '#encrypt with key/date' do 
    response = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(@enigma.encrypt("hello world", "02715", "040895")).to eq(response)

  end

  it '#encrypt generates key/date when not provided' do
    allow(Date).to receive(:today).and_return(Date.new(1995, 8, 4))
    allow(@enigma).to receive(:gen_key).and_return("02715")

    response = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    expect(@enigma.encrypt("hello world")).to eq(response)
  end

  it '#encrypt uses todays date if not given one' do
    allow(Date).to receive(:today).and_return(Date.new(1995, 8, 4))

    encrypted = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(@enigma.encrypt("hello world", "02715")).to eq(encrypted)
  end

  it '#encrypt leaves non-charset characters unchanged' do
    encrypted = @enigma.encrypt("hi!", "02715", "040895")
    expect(encrypted[:encryption]).to eq("ki!")
  end

  it '#decrypt with key/date' do 
    response = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq(response)
  end

  it '#decrypt uses todays date if not given one' do
    allow(Date).to receive(:today).and_return(Date.new(1995, 8, 4))

    response = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    expect(@enigma.decrypt("keder ohulw", "02715")).to eq(response)
  end

  it '#decrypt leaves non-charset characters unchanged' do
    encrypted = @enigma.encrypt("hi!", "02715", "040895")[:encryption]
    decrypted = @enigma.decrypt(encrypted, "02715", "040895")
    expect(decrypted[:decryption]).to eq("hi!")
  end

  it '#gen_key' do
    expect(@enigma.send(:gen_key)).to match(/^\d{5}$/)
  end
end
