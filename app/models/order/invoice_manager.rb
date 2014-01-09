module Order::InvoiceManager

  # captures the payment of the invoice by the payment processor
  #
  # @param [Invoice]
  # @return [Payment] payment object
  def capture_invoice(invoice)
    payment = invoice.capture_payment({})
    self.pay! if payment.success
    payment
  end


  ## This method creates the invoice and payment method.  If the payment is not authorized the whole transaction is roled back
  def create_invoice(credit_card, charge_amount, args, credited_amount = 0.0)
    transaction do
      new_invoice = create_invoice_transaction(credit_card, charge_amount, args, credited_amount)
      if new_invoice.succeeded?
        EmailWorker::SendOrderConfirmation.perform_async(self.id, new_invoice.id)                  
      end
      new_invoice
    end
  end

  # how much you initially charged the customer
  #
  # @param [none]
  # @return [String] amount in dollars as decimal or a blank string
  def first_invoice_amount
    return '' if completed_invoices.empty? && canceled_invoices.empty?
    completed_invoices.last ? completed_invoices.last.amount : canceled_invoices.last.amount
  end

  # status of the invoice
  #
  # @param [none]
  # @return [String] state of the latest invoice or 'not processed' if there aren't any invoices
  def invoice_status
    return 'not processed' if invoices.empty?
    invoices.last.state
  end

  private 

  def create_invoice_transaction(credit_card, charge_amount, args, credited_amount = 0.0)
    invoice_statement = Invoice.generate(self.id, charge_amount, credited_amount)
    invoice_statement.save
    invoice_statement.authorize_payment(credit_card, args)#, options = {})
    invoices.push(invoice_statement)

    if invoice_statement.succeeded?
      self.order_complete! #complete!
      self.save
    else
      invoice_statement.errors.add(:base, 'Payment denied!!!')
      invoice_statement.save
    end
    invoice_statement
  end
end