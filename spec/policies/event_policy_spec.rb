require 'rails_helper'

RSpec.describe EventPolicy do
  subject { described_class }

  permissions :edit?, :update?, :destroy? do
    let(:event)       { Event.new(user: event_owner) }
    let(:event_owner) { User.new }
    let(:other_user)  { User.new }

    context 'if user is not logged in' do
      it 'denies access' do
        is_expected.not_to permit(UserWithPincode.new(nil, nil), Event.new)
      end
    end

    context 'if user does not own the event' do
      it 'denies access' do
        is_expected.not_to permit(UserWithPincode.new(other_user, nil), event)
      end
    end

    context 'if user owns the event' do
      it 'grants access' do
        is_expected.to permit(UserWithPincode.new(event_owner, nil), event)
      end
    end
  end

  permissions :show? do
    context 'when the event is not protected with the pincode' do
      let(:public_event) { Event.new }

      it 'grants access' do
        is_expected.to permit(nil, public_event)
      end
    end

    context 'when the event is protected with the pincode' do
      let(:event_owner)   { User.new }
      let(:other_user)    { User.new }
      let(:private_event) { Event.new(pincode: '1234', user: event_owner) }

      context 'and is accessed by other user' do
        context 'and the correct pincode is provided' do
          it 'grants access' do
            is_expected.to permit(UserWithPincode.new(other_user, '1234'), private_event)
          end
        end

        context 'and the incorrect pincode is provided' do
          it 'denies access' do
            is_expected.not_to permit(UserWithPincode.new(other_user, '4321'), private_event)
          end
        end
      end

      context 'and is accessed by the owner' do
        it 'grants access' do
          is_expected.to permit(UserWithPincode.new(event_owner, nil), private_event)
        end
      end
    end
  end
end
