class EmergencyContactsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @emergency_contact = EmergencyContact.new
  end

  def create
    @user = User.find(params[:user_id])
    @emergency_contact = @user.emergency_contacts.build(emergency_contact_params)

    if @emergency_contact.save
      redirect_to edit_user_path(@user), notice: "Emergency Contact created successfully."
    else
      flash.now[:error] = "Emergency Contact creation failed"
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @emergency_contact = @user.emergency_contacts.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @emergency_contact = @user.emergency_contacts.find(params[:id])

    if @emergency_contact.update(emergency_contact_params)
      redirect_to edit_user_path(@user), notice: "Emergency Contact updated successfully."
    else
      flash.now[:error] = "Emergency Contact update failed"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @emergency_contact = @user.emergency_contacts.find(params[:id])
    @emergency_contact.destroy
    redirect_to edit_user_path(@user), notice: "Emergency contact successfully deleted."
  end

  private

  def emergency_contact_params
    params.require(:emergency_contact).permit(:first_name, :last_name, :phone_number, :address, :email, :state, :city)
  end
end
