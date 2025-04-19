# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    Rails.application.routes.url_helpers.customer_path(resource)    # 遷移先のパス
  end

  private
  # アクティブであるかを判断するメソッド
  def customer_state
    #byebug
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    customer = Customer.find_by(email: params.dig(:customer, :email))
    # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
    
    # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
    password_valid = customer.valid_password?(params.dig(:customer, :password)) if customer
    # 【処理内容4】 アクティブでない会員に対する処理
    reject_customer = customer && password_valid && !customer.is_active
    if reject_customer
      flash[:alert] = "退会済みのユーザーです"
      redirect_to new_customer_session_path
    end
  end
end
