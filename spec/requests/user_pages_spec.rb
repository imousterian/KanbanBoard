require 'spec_helper'

describe "UserPages" do

    subject { page }

    describe "index" do

        let(:user) { FactoryGirl.create(:user) }

        before do
            sign_in user
            visit users_path
        end

        # it { should have_title('All users') }
        it { should have_content(user.username) }
    end
end
