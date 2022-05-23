class ApplicationService

  def self.call(*args)
    new(*args).call
  end

  private

  def not_saved(key:, errors:)
    { error: t.errors.send(key).not_saved(errors) }
  end
end
