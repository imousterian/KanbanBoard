require 'spec_helper'
# require 'rails_helper'

describe "OrganizationsController" do

    subject {page}

    let(:user) { FactoryGirl.create(:user) }

    before do
        sign_in user
    end

    describe "profile page" do

        before { visit user_path(user) }

        it { should have_content(user.username) }

    end

end
