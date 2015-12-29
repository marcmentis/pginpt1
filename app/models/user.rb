class User < ActiveRecord::Base
  include Jqgridconcern
  rolify

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :authen, 
              presence: true,
              uniqueness: true
  validates :facility, presence: true
  validates :email,
              presence: true,
              uniqueness: true,
              format: {with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i,
                        message: "Please enter valid eMail"}
  validates :firstinitial, presence: true


  def get_jqGrid_obj(params)
  	conditions = User.all
    conditions = conditions.where("facility = :facility", {facility: params[:facility]}) if params[:facility]!= '-1'
    conditions = conditions.where("firstname LIKE ?", ''+params[:firstname]+'%') if params[:firstname]!= ''
    conditions = conditions.where("lastname LIKE ?", ''+params[:lastname]+'%') if params[:lastname]!= ''
    conditions = conditions.where("authen LIKE ?", ''+params[:authen]+'%') if not params[:authen].blank?
    # conditions = conditions.where("email LIKE ?", ''+params[:email]+'%') if not params[:email].blank?
    conditions = conditions.where("firstinitial LIKE ?", ''+params[:firstinitial]+'%') if params[:firstinitial]!= ''
    conditions = conditions.where("middleinitial LIKE ?", ''+params[:middleinitial]+'%') if params[:middleinitial]!= ''

  	return jqGrid_obj = create_jqGrid_obj(conditions, params)
  end
end
