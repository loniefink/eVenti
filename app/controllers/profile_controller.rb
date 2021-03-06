class ProfileController < ApplicationController
  def show
    @member = current_member
    @host = request.host
    respond_to do |format|
      format.html { render "members/profiles/show" }
    end
  end

  def show_user
    @member = Member.find_by_profile_name(params[:profile_name])
    respond_to do |format|
      format.html { render "members/profiles/show_user" }
    end
  end

  def paged_profiles
    next_profile_pictures
  end

  def edit
    @member = current_member
    @host = request.host
    build_pictures @member
    respond_to do |format|
      format.html { render "members/profiles/edit" }
    end
  end

  def update
    @member = current_member
    @host = request.host
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to(show_profile_path, :notice => 'Event was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def verify_unique_email
    user = User.find_by_email params[:val]
    render :json => { :valid => user.nil?, :error => "That email address is already taken" }
  end

  def verify_unique_profile_name
    user = Member.find_by_profile_name params[:val]
    render :json => { :valid => user.nil?, :error => "That profile url is already taken" }
  end

  private

  def build_pictures(member)
    3.times { member.pictures.build } if member.pictures.empty?
  end
  
end