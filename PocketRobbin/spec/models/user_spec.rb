# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'password encryption' do
    it 'does not save password to the database' do
      User.create!(username: 'bill nye', password: 'scienceguy')
      user = User.find_by(username: 'bill nye')
      expect(user.password).to_not eq('scienceguy')
    end

    it 'encrypts the password with BCrypt' do
      user_params = { username: 'bill nye', password: 'scienceguy'}
      expect(BCrypt::Password).to receive(:create).with(user_params[:password])
      User.new(user_params)
    end
  end

  describe 'session_token' do
    it 'assigns a session token if not given' do
      beavis = User.new(username: 'butthead', password: 'heh_heh_heh_heh')
      expect(beavis.session_token).to_not be_nil
    end
  end

  describe '::find_by_credentials' do
    context 'with valid params' do
      it 'returns the user' do
        original = User.create!(username: 'bill nye', password: 'scienceguy')
        user = User.find_by_credentials('bill nye', 'scienceguy')
        expect(user).to eq(original)
      end
    end
    context 'with invalid params' do
      it 'returns nil' do
        User.create!(username: 'bill nye', password: 'scienceguy')
        user = User.find_by_credentials('bill nye', 'swoleguy')
        expect(user).to be_nil
      end
    end
  end
end
