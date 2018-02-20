class ContactsController < ApplicationController
	before_action :check_if_user_is_logged_in, except: [ :new, :create ]
	before_action :set_contact, only: [:show, :edit, :update, :destroy]

	# GET /contacts
	# GET /contacts.json
	def index
		@contacts = Contact.all
	end

	# GET /contacts/1
	# GET /contacts/1.json
	def show
	end

	# GET /contacts/new
	def new
		@contact = Contact.new
	end

	# GET /contacts/1/edit
	def edit
	end

	# POST /contacts
	# POST /contacts.json
	def create
		@contact = Contact.new(contact_params)

		respond_to do |format|
			if @contact.save
				format.html { redirect_to queries_path, notice: 'Seu contato foi enviado com sucesso. Logo entraremos em contato com você.' }
			else
				format.html { render :index }
			end
		end
	end

	# PATCH/PUT /contacts/1
	# PATCH/PUT /contacts/1.json
	def update
		respond_to do |format|
			if @contact.update(contact_params)
				ContactMailer.answer(@contact).deliver_later

				format.html { redirect_to edit_contact_path(@contact), notice: "Sua resposta foi enviada para #{@contact.email}." }
			else
				format.html { render :edit }
			end
		end
	end

	# DELETE /contacts/1
	# DELETE /contacts/1.json
	def destroy
		@contact.destroy
		respond_to do |format|
			format.html { redirect_to contacts_url, notice: 'Contato foi removido.' }
			format.json { head :no_content }
		end
	end

	private
	def set_contact
		@contact = Contact.find(params[:id])
	end

	def contact_params
		params.require(:contact).permit(:email, :phone, :city, :comment, :answer)
	end
end
