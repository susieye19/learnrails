class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all.order('code ASC')
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)
    @coupon.code == @coupon.code.upcase

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to coupons_url, notice: 'Coupon was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @coupon }
      else
        format.html { render action: 'new' }
        # format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to coupons_url, notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to coupons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:code, :price, :message, :extra_access)
    end
end
