module Users
  class Base < ApplicationService
    private

    def not_saved(errors)
      { error: t.errors.users.not_saved(errors) }
    end
  end
end