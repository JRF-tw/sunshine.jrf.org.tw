module Search
  class JudgeByCourtAndBranchContext < BaseContext
    before_perform :find_court
    before_perform :find_branches
    before_perform :find_judges

    def initialize(court_name, branch_name)
      @court_name = court_name
      @branch_name = branch_name
    end

    def perform
      run_callbacks :perform do
        @judges
      end
    end

    private

    def find_court
      @court = Court.find_by(full_name: @court_name)
      add_error(:data_not_found, "沒有該法院相關資料") unless @court
    end

    def find_branches
      @branches = @court.branches.current.where(name: @branch_name)
      add_error(:data_not_found, "沒有該法院下此股別相關資料") unless @branches.present?
    end

    def find_judges
      @judges = @branches.map(&:judge).uniq
    end
  end
end
