class Admin::ProsecutorDeleteContext < BaseContext

  def initialize(prosecutor)
    @prosecutor = prosecutor
  end

  def perform
    run_callbacks :perform do
      @prosecutor.destroy
    end
  end

end
