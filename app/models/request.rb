class Request < ActiveRecord::Base
  belongs_to :user

  def pick_by(user:)
    return if user.blank?

    update(allowed: 1, admin: user.full_name)
  end

  def ready_to_pick?
    allowed.zero?
  end

  def complite(params: {})
    update(complited: 1, **params)
  end
end
