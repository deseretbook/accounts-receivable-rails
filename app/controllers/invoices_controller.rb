class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  after_action :save_line_items, except: [:index]

  def index
    @invoices = Invoice.all
  end

  def show
    @client = @invoice.client

    @line_items = (
      @invoice.line_items.joins(:product).where("products.price_cents != 0") +
      @invoice.line_items.joins(:service).where("services.price_cents != 0")
    ).group_by { |line_item| line_item.service.present? ? :service : :product }

    @total = @line_items.values.flatten.map { |line_item|
      [line_item.price_override_cents ||
        line_item&.product&.price_cents ||
        line_item&.service&.price_cents, line_item.quantity]
    }.sum { |(price_cents, quantity)|
      price_cents * quantity
    }
  end

  def new
    @invoice = Invoice.new
  end

  def edit
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to @invoice, notice: "Invoice was successfully created."
    else
      render :new
    end
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to @invoice, notice: "Invoice was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @invoice.destroy
    redirect_to invoices_url, notice: "Invoice was successfully destroyed."
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def save_line_items
    return if @invoice.blank?
    @invoice.line_items.each(&:save)
  end

  def invoice_params
    params.require(:invoice).permit(:client_id, :net_days, :note)
  end
end
