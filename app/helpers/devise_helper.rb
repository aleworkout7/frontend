module DeviseHelper
	# A simple way to show error messages for the current devise resource. If you need
	# to customize this method, you can either overwrite it in your application helpers or
	# copy the views to your application.
	#
	# This method is intended to stay simple and it is unlikely that we are going to change
	# it to add more behavior or options.
	def devise_error_messages! hashes = {}
		return "" if resource.errors.empty?

		messages = ""
		hashes.each do |h|
			symbol = h[0].to_sym
			if resource.errors[symbol].present?
				resource.errors.delete(symbol)
				messages += content_tag(:p, h[1])
			end
		end

		messages += resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join
		sentence = I18n.t(	"errors.messages.not_saved",
							count: resource.errors.count,
							resource: resource.class.model_name.human.downcase)

		html = <<-HTML
			<div class="alert alert-dismissable alert-danger text-center">
				<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
				#{messages}
			</div>
		HTML

		html.html_safe
	end

	def devise_error_messages_without_alert_div
		return [] if resource.errors.empty?

		resource.errors.full_messages.map { |msg| content_tag(:p, msg) }
	end

end
