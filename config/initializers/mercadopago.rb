require 'mercadopago.rb'

::MercadoPagoClient = MercadoPago.new(ENV["MP_CLIENT_ID"], ENV["MP_CLIENT_SECRET"])
