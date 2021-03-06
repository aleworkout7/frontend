class PagosController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:mp_notification]
	before_action :set_pago, only: [:show, :edit, :update, :destroy]

	# GET /pagos
	# GET /pagos.json
	def index
		if current_user.try(:has_subscription?)
			@subscription = SubscriptionNotification.where(external_reference: current_user.id).last
			@subscription = nil if @subscription.try(:status) != "authorized"
		end
	end

	def do_subscription
		if current_user.has_subscription?
			return redirect_to pagos_path
		end

		@price = 29.90
		begin
			@price = ENV["MP_PRICE"].try(:to_f)
		rescue => ex
			@price = 29.90
			puts ex.try(:message)
		end

		data = {
			payer_email: current_user.email,
			back_url: "https://www.prediosapp.com.br/pagos",
			reason: "Assinatura mensal para ter lojas no PrediosApp",
			external_reference: current_user.id,
			auto_recurring: {
				frequency: 1,
				frequency_type: "months",
				transaction_amount: @price,
				currency_id: "BRL"
			}
		}

		unless current_user.had_subscription_before?
			 data[:auto_recurring][:start_date] = Time.now + 15.days
		end

		@preapproval = MercadoPagoClient.create_preapproval_payment(data);

		puts "\n\npreapproval: "
		puts @preapproval
		puts "\n"

		respond_to do |format|
			if @preapproval['response'].present? && @preapproval['response']['init_point'].present?
				format.html { redirect_to @preapproval['response']['init_point'] }
			else
				format.html { redirect_to pagos_path, notice: 'Não foi possível gerar sua assinatura. Tente novamente por favor.' }
			end
		end
	end

	def cancel_subscription
		subscription = SubscriptionNotification.where(external_reference: current_user.id).last
		if subscription.present?
			tid = subscription.transaction_id
			MercadoPagoClient.cancel_preapproval_payment(tid)
		end

		if current_user.has_subscription?
			Alejandro.where(email: current_user.email).first.try(:delete)
		end

		respond_to do |format|
			format.html { redirect_to action: :index, notice: 'Assinatura cancelada' }
		end
	end

	def mp_notification
		if params[:topic].present?
			if params[:topic] == "preapproval"

				payment_info = MercadoPagoClient.get_preapproval_payment(params[:id])
				json = payment_info["response"]
				if json.present?

					SubscriptionNotification.create({
						transaction_id: json["id"],
						payer_id: json["payer_id"],
						collector_id: json["collector_id"],
						application_id: json["application_id"],
						status: json["status"],
						external_reference: json["external_reference"],
						date_created: json["date_created"],
						last_modified: json["last_modified"]
					})

				end

			else

				payment_info = MercadoPagoClient.get_payment_info(params[:id])
				json = payment_info["response"]["collection"]
				if json.present?

					PaymentNotification.create({
						transaction_id: json["id"],
						payer_id: json["payer"]["id"],
						status: json["status"],
						external_reference: json["external_reference"],
						total_paid_amount: json["total_paid_amount"],
						payment_type: json["payment_type"],
						payment_method_id: json["payment_method_id"],
						transaction_order_id: json["transaction_order_id"],
						date_created: json["date_created"],
						date_approved: json["date_approved"],
						money_release_date: json["money_release_date"],
						last_modified: json["last_modified"]
					})

				end

			end
		end

		render nothing: true, status: 200
	end

	# GET /pagos/1
	# GET /pagos/1.json
	def show
	end

	# GET /pagos/new
	def new
		@pago = Pago.new
		@members = Member.all
		@bancos = Banco.all
		@cuentas = Account.all
	end

	# GET /pagos/1/edit
	def edit
		@members = Member.all
		@bancos = Banco.all
		@cuentas = Account.all
	end

	# POST /pagos
	# POST /pagos.json
	def create
		@pago = Pago.new(pago_params)
		@pago.checked = false
		@pago.user_id = current_user.id
		@pago.email = current_user.email
		@pago.notice_date = Date.today
		respond_to do |format|
			if @pago.save
				format.html { redirect_to @pago, notice: 'Pago was successfully created.' }
				format.json { render :show, status: :created, location: @pago }
			else
				format.html { render :new }
				format.json { render json: @pago.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /pagos/1
	# PATCH/PUT /pagos/1.json
	def update
		respond_to do |format|
			if @pago.update(pago_params)
				format.html { redirect_to @pago, notice: 'Pago was successfully updated.' }
				format.json { render :show, status: :ok, location: @pago }
			else
				format.html { render :edit }
				format.json { render json: @pago.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /pagos/1
	# DELETE /pagos/1.json
	def destroy
		@pago.destroy
		respond_to do |format|
			format.html { redirect_to pagos_url, notice: 'Pago was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_pago
		@pago = Pago.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def pago_params
		params.require(:pago).permit(:account_number ,:banco_id, :account_id, :image, :user_id, :member_id, :payment_date, :amount, :message, :checked, :predio_name, :predio_address, :email, :notice_date)
	end
end
