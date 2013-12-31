class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  RESERVED_LOGIN_NAMES = %w(about aboutus admin administer administor administrater administrator anonymous auther author blogger contact contactus contributer contributor cpanel delete directer director editer editor email emailus guest info loggedin loggedout login logout moderater moderator mysql nobody operater operator oracle owner postmaster president registar register registrar root signout test user vicepresident webmaster)
  paranoid
  validates :username, presence: true
  validates :email, presence: true
end
