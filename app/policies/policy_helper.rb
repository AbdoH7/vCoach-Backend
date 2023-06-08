module PolicyHelper
  def doctor?
    user.user_type == 'doctor'
  end

  def patient?
    user.user_type == 'patient'
  end
end
  