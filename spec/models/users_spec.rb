# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  context 'authentication' do
    context 'it is valid' do
      it 'without password confirmation' do
        user.password_confirmation = nil

        expect(user).to be_valid
      end

      it 'with uniq email' do
        create(:user, email: 'test@gmail.com')

        user.email = 'test2@gmail.com'
        expect(user).to be_valid
      end

      it 'with correct password' do
        expect(user.authenticate('SomePass123')).to be_truthy
      end
    end

    context 'it is invalid' do
      it 'without password' do
        user.password = nil

        expect(user).not_to be_valid
        expect(user.errors[:password_digest]).not_to be_empty
      end

      it 'if user with same email is already registered' do
        create(:user, email: 'test@gmail.com')

        user.email = 'test@gmail.com'
        expect(user).not_to be_valid
        expect(user.errors[:email]).not_to be_empty
      end

      it 'with incorrect password' do
        expect(user.authenticate('qwe')).to be_falsey
      end
    end
  end
end
