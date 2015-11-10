require 'rails_helper'

describe "User:" do
	let(:user) {build(:user)}

	context "Validations:" do
		it "has a valid factory" do
			expect(build(:user)).to be_valid
		end

		it "is valid with firstname, lastname, authen, facility, email, firstinitial, middleinitial, updated_by" do
			user = build(:user)
			expect(user).to be_valid
		end

		it "is invalid without a firstname" do
			user.firstname = nil
			user.valid?
			expect(user.errors[:firstname]).to include("can't be blank")
		end

		it "is invalid without a lastname" do
			user.lastname = nil
			user.valid?
			expect(user.errors[:lastname]).to include ("can't be blank")
		end

		it "is invalid without authentication (authen)" do
			user.authen = nil
			user.valid?
			expect(user.errors[:authen]).to include ("can't be blank")
		end

		it "is invalid with deplicate authentication" do
			create(:user, authen: "authen1")
			user.authen = "authen1"
			user.valid?
			expect(user.errors[:authen]).to include ("has already been taken")
		end

		it "is invalid without a facility" do
			user.facility = nil
			user.valid?
			expect(user.errors[:facility]).to include ("can't be blank")
		end

		it "is invalid without an email" do
			user.email = nil
			user.valid?
			expect(user.errors[:email]).to include ("can't be blank")
		end

		it "is invalid with duplicate email" do
			create(:user, email: "test1@mail.com")
			user.email = "test1@mail.com"
			user.valid?
			expect(user.errors[:email]).to include("has already been taken")
		end

		it "is invalid without a first initial" do
			user.firstinitial = nil
			user.valid?
			expect(user.errors[:firstinitial]).to include ("can't be blank")
		end
	end

	context "Associations:" do
		it " 'many-to-many' with roles" do
			expect(user).to have_and_belong_to_many :roles
		end	
	end
end